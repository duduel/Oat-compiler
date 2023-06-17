open Ll
open Llutil
open Ast
open Astlib
open Llutil

(* instruction streams ------------------------------------------------------ *)

(* As in the last project, we'll be working with a flattened representation
   of LLVMlite programs to make emitting code easier. This version
   additionally makes it possible to emit elements will be gathered up and
   "hoisted" to specific parts of the constructed CFG
   - G of gid * Ll.gdecl: allows you to output global definitions in the middle
     of the instruction stream. You will find this useful for compiling string
     literals
   - E of uid * insn: allows you to emit an instruction that will be moved up
     to the entry block of the current function. This will be useful for 
     compiling local variable declarations
*)

type elt = 
  | L of Ll.lbl             (* block labels *)
  | I of uid * Ll.insn      (* instruction *)
  | T of Ll.terminator      (* block terminators *)
  | G of gid * Ll.gdecl     (* hoisted globals (usually strings) *)
  | E of uid * Ll.insn      (* hoisted entry block instructions *)

(* The type of streams of LLVMLite instructions. Note that to improve performance,
 * we will emit the instructions in reverse order. That is, the LLVMLite code:
 *     %1 = mul i64 2, 2
 *     %2 = add i64 1, %1
 *     br label %l1
 * would be constructed as a stream as follows:
 *     I ("1", Binop (Mul, I64, Const 2L, Const 2L))
 *     >:: I ("2", Binop (Add, I64, Const 1L, Id "1"))
 *     >:: E (Br "l1")
 *)

 (* if !debug then Printexc.record_backtrace true; *)

type stream = elt list
let ( >@ ) x y = y @ x
let ( >:: ) x y = y :: x
let lift : (uid * insn) list -> stream = List.rev_map (fun (x,i) -> I (x,i))

(* Build a CFG and collection of global variable definitions from a stream *)
let cfg_of_stream (code:stream) : Ll.cfg * (Ll.gid * Ll.gdecl) list  =
    let gs, einsns, insns, term_opt, blks = List.fold_left
      (fun (gs, einsns, insns, term_opt, blks) e ->
        match e with
        | L l ->
           begin match term_opt with
           | None -> 
              if (List.length insns) = 0 then (gs, einsns, [], None, blks)
              else failwith @@ Printf.sprintf "build_cfg: block labeled %s has\
                                               no terminator" l
           | Some term ->
              (gs, einsns, [], None, (l, {insns; term})::blks)
           end
        | T t  -> (gs, einsns, [], Some (Llutil.Parsing.gensym "tmn", t), blks)
        | I (uid,insn)  -> (gs, einsns, (uid,insn)::insns, term_opt, blks)
        | G (gid,gdecl) ->  ((gid,gdecl)::gs, einsns, insns, term_opt, blks)
        | E (uid,i) -> (gs, (uid, i)::einsns, insns, term_opt, blks)
      ) ([], [], [], None, []) code
    in
    match term_opt with
    | None -> failwith "build_cfg: entry block has no terminator" 
    | Some term -> 
       let insns = einsns @ insns in
       ({insns; term}, blks), gs


(* compilation contexts ----------------------------------------------------- *)

(* To compile OAT variables, we maintain a mapping of source identifiers to the
   corresponding LLVMlite operands. Bindings are added for global OAT variables
   and local variables that are in scope. *)

module Ctxt = struct

  type t = (Ast.id * (Ll.ty * Ll.operand)) list
  let empty = []

  (* Add a binding to the context *)
  let add (c:t) (id:id) (bnd:Ll.ty * Ll.operand) : t = (id,bnd)::c

  (* Lookup a binding in the context *)
  let lookup (id:Ast.id) (c:t) : Ll.ty * Ll.operand =
    List.assoc id c

  (* Lookup a function, fail otherwise *)
  let lookup_function (id:Ast.id) (c:t) : Ll.ty * Ll.operand =
    match List.assoc id c with
    | Ptr (Fun (args, ret)), g -> Ptr (Fun (args, ret)), g
    | _ -> failwith @@ id ^ " not bound to a function"

  let lookup_function_option (id:Ast.id) (c:t) : (Ll.ty * Ll.operand) option =
    try Some (lookup_function id c) with _ -> None
  
end

(* compiling OAT types ------------------------------------------------------ *)

(* The mapping of source types onto LLVMlite is straightforward. Booleans and ints
   are represented as the corresponding integer types. OAT strings are
   pointers to bytes (I8). Arrays are the most interesting type: they are
   represented as pointers to structs where the first component is the number
   of elements in the following array.

   The trickiest part of this project will be satisfying LLVM's rudimentary type
   system. Recall that global arrays in LLVMlite need to be declared with their
   length in the type to statically allocate the right amount of memory. The 
   global strings and arrays you emit will therefore have a more specific type
   annotation than the output of cmp_rty. You will have to carefully bitcast
   gids to satisfy the LLVM type checker.
*)

let rec cmp_ty : Ast.ty -> Ll.ty = function
  | Ast.TBool  -> I1
  | Ast.TInt   -> I64
  | Ast.TRef r -> Ptr (cmp_rty r)

and cmp_rty : Ast.rty -> Ll.ty = function
  | Ast.RString  -> I8
  | Ast.RArray u -> Struct [I64; Array(0, cmp_ty u)]
  | Ast.RFun (ts, t) -> 
      let args, ret = cmp_fty (ts, t) in
      Fun (args, ret)

and cmp_ret_ty : Ast.ret_ty -> Ll.ty = function
  | Ast.RetVoid  -> Void
  | Ast.RetVal t -> cmp_ty t

and cmp_fty (ts, r) : Ll.fty =
  List.map cmp_ty ts, cmp_ret_ty r


let typ_of_binop : Ast.binop -> Ast.ty * Ast.ty * Ast.ty = function
  | Add | Mul | Sub | Shl | Shr | Sar | IAnd | IOr -> (TInt, TInt, TInt)
  | Eq | Neq | Lt | Lte | Gt | Gte -> (TInt, TInt, TBool)
  | And | Or -> (TBool, TBool, TBool)

let typ_of_unop : Ast.unop -> Ast.ty * Ast.ty = function
  | Neg | Bitnot -> (TInt, TInt)
  | Lognot       -> (TBool, TBool)

(* Compiler Invariants

   The LLVM IR type of a variable (whether global or local) that stores an Oat
   array value (or any other reference type, like "string") will always be a
   double pointer.  In general, any Oat variable of Oat-type t will be
   represented by an LLVM IR value of type Ptr (cmp_ty t).  So the Oat variable
   x : int will be represented by an LLVM IR value of type i64*, y : string will
   be represented by a value of type i8**, and arr : int[] will be represented
   by a value of type {i64, [0 x i64]}**.  Whether the LLVM IR type is a
   "single" or "double" pointer depends on whether t is a reference type.

   We can think of the compiler as paying careful attention to whether a piece
   of Oat syntax denotes the "value" of an expression or a pointer to the
   "storage space associated with it".  This is the distinction between an
   "expression" and the "left-hand-side" of an assignment statement.  Compiling
   an Oat variable identifier as an expression ("value") does the load, so
   cmp_exp called on an Oat variable of type t returns (code that) generates a
   LLVM IR value of type cmp_ty t.  Compiling an identifier as a left-hand-side
   does not do the load, so cmp_lhs called on an Oat variable of type t returns
   and operand of type (cmp_ty t)*.  Extending these invariants to account for
   array accesses: the assignment e1[e2] = e3; treats e1[e2] as a
   left-hand-side, so we compile it as follows: compile e1 as an expression to
   obtain an array value (which is of pointer of type {i64, [0 x s]}* ).
   compile e2 as an expression to obtain an operand of type i64, generate code
   that uses getelementptr to compute the offset from the array value, which is
   a pointer to the "storage space associated with e1[e2]".

   On the other hand, compiling e1[e2] as an expression (to obtain the value of
   the array), we can simply compile e1[e2] as a left-hand-side and then do the
   load.  So cmp_exp and cmp_lhs are mutually recursive.  [[Actually, as I am
   writing this, I think it could make sense to factor the Oat grammar in this
   way, which would make things clearer, I may do that for next time around.]]

 
   Consider globals7.oat

   /--------------- globals7.oat ------------------ 
   global arr = int[] null;

   int foo() { 
     var x = new int[3]; 
     arr = x; 
     x[2] = 3; 
     return arr[2]; 
   }
   /------------------------------------------------

   The translation (given by cmp_ty) of the type int[] is {i64, [0 x i64}* so
   the corresponding LLVM IR declaration will look like:

   @arr = global { i64, [0 x i64] }* null

   This means that the type of the LLVM IR identifier @arr is {i64, [0 x i64]}**
   which is consistent with the type of a locally-declared array variable.

   The local variable x would be allocated and initialized by (something like)
   the following code snippet.  Here %_x7 is the LLVM IR uid containing the
   pointer to the "storage space" for the Oat variable x.

   %_x7 = alloca { i64, [0 x i64] }*                              ;; (1)
   %_raw_array5 = call i64*  @oat_alloc_array(i64 3)              ;; (2)
   %_array6 = bitcast i64* %_raw_array5 to { i64, [0 x i64] }*    ;; (3)
   store { i64, [0 x i64]}* %_array6, { i64, [0 x i64] }** %_x7   ;; (4)

   (1) note that alloca uses cmp_ty (int[]) to find the type, so %_x7 has 
       the same type as @arr 

   (2) @oat_alloc_array allocates len+1 i64's 

   (3) we have to bitcast the result of @oat_alloc_array so we can store it
        in %_x7 

   (4) stores the resulting array value (itself a pointer) into %_x7 

  The assignment arr = x; gets compiled to (something like):

  %_x8 = load { i64, [0 x i64] }*, { i64, [0 x i64] }** %_x7     ;; (5)
  store {i64, [0 x i64] }* %_x8, { i64, [0 x i64] }** @arr       ;; (6)

  (5) load the array value (a pointer) that is stored in the address pointed 
      to by %_x7 

  (6) store the array value (a pointer) into @arr 

  The assignment x[2] = 3; gets compiled to (something like):

  %_x9 = load { i64, [0 x i64] }*, { i64, [0 x i64] }** %_x7      ;; (7)
  %_index_ptr11 = getelementptr { i64, [0 x  i64] }, 
                  { i64, [0 x i64] }* %_x9, i32 0, i32 1, i32 2   ;; (8)
  store i64 3, i64* %_index_ptr11                                 ;; (9)

  (7) as above, load the array value that is stored %_x7 

  (8) calculate the offset from the array using GEP

  (9) store 3 into the array

  Finally, return arr[2]; gets compiled to (something like) the following.
  Note that the way arr is treated is identical to x.  (Once we set up the
  translation, there is no difference between Oat globals and locals, except
  how their storage space is initially allocated.)

  %_arr12 = load { i64, [0 x i64] }*, { i64, [0 x i64] }** @arr    ;; (10)
  %_index_ptr14 = getelementptr { i64, [0 x i64] },                
                 { i64, [0 x i64] }* %_arr12, i32 0, i32 1, i32 2  ;; (11)
  %_index15 = load i64, i64* %_index_ptr14                         ;; (12)
  ret i64 %_index15

  (10) just like for %_x9, load the array value that is stored in @arr 

  (11)  calculate the array index offset

  (12) load the array value at the index 

*)

(* Global initialized arrays:

  There is another wrinkle: To compile global initialized arrays like in the
  globals4.oat, it is helpful to do a bitcast once at the global scope to
  convert the "precise type" required by the LLVM initializer to the actual
  translation type (which sets the array length to 0).  So for globals4.oat,
  the arr global would compile to (something like):

  @arr = global { i64, [0 x i64] }* bitcast 
           ({ i64, [4 x i64] }* @_global_arr5 to { i64, [0 x i64] }* ) 
  @_global_arr5 = global { i64, [4 x i64] } 
                  { i64 4, [4 x i64] [ i64 1, i64 2, i64 3, i64 4 ] }

*) 



(* Some useful helper functions *)

(* Generate a fresh temporary identifier. Since OAT identifiers cannot begin
   with an underscore, these should not clash with any source variables *)
let gensym : string -> string =
  let c = ref 0 in
  fun (s:string) -> incr c; Printf.sprintf "_%s%d" s (!c)

(* Amount of space an Oat type takes when stored in the satck, in bytes.  
   Note that since structured values are manipulated by reference, all
   Oat values take 8 bytes on the stack.
*)
let size_oat_ty (t : Ast.ty) = 8L

(* Generate code to allocate a zero-initialized array of source type TRef (RArray t) of the
   given size. Note "size" is an operand whose value can be computed at
   runtime *)
let oat_alloc_array (t:Ast.ty) (size:Ll.operand) : Ll.ty * operand * stream =
  let ans_id, arr_id = gensym "array", gensym "raw_array" in
  let ans_ty = cmp_ty @@ TRef (RArray t) in
  let arr_ty = Ptr I64 in
  ans_ty, Id ans_id, lift
    [ arr_id, Call(arr_ty, Gid "oat_alloc_array", [I64, size])
    ; ans_id, Bitcast(arr_ty, Id arr_id, ans_ty) ]

(* Compiles an expression exp in context c, outputting the Ll operand that will
   recieve the value of the expression, and the stream of instructions
   implementing the expression. 

   Tips:
   - use the provided cmp_ty function!

   - string literals (CStr s) should be hoisted. You'll need to make sure
     either that the resulting gid has type (Ptr I8), or, if the gid has type
     [n x i8] (where n is the length of the string), convert the gid to a 
     (Ptr I8), e.g., by using getelementptr.

   - use the provided "oat_alloc_array" function to implement literal arrays
     (CArr) and the (NewArr) expressions

*)
let rec cmp_exp (c:Ctxt.t) (exp:Ast.exp node) : Ll.ty * Ll.operand * stream =
  begin match exp.elt with
    | CNull rtyp -> (cmp_rty rtyp), (Ll.Null), []
    | CBool boolv -> (cmp_ty TBool), (Ll.Const (Int64.of_int (Bool.to_int boolv))), []
    | CInt int64v -> (cmp_ty TInt), (Ll.Const int64v), []
    | CStr stringv -> let str_bitcast = gensym "bitcast" in
                        let l_str = gensym "l_str" in
                          Ptr I8, (Ll.Id str_bitcast),
                            [G(l_str, (Array(1 + String.length stringv, I8), GString stringv));
                            I(str_bitcast, Gep (Ptr (Array(1 + String.length stringv, I8)), Gid l_str, [Const 0L; Const 0L]))]
    | CArr (typ, e_list) -> 
        let (arr_ty, arr_op, arr_strm) = oat_alloc_array typ (Const (Int64.of_int (List.length e_list))) in
          let exps2_strm, exps_strm = List.split (List.mapi ( fun i e -> let (exp_ty, exp_op, exp_strm) = cmp_exp c e in
                                                                        let exp2_strm = 
                                                                          let gens1 = gensym "array" in
                                                                            let gens2 = gensym "array" in
                                                                              [I(gens1, Gep (cmp_ty (TRef (RArray typ)), arr_op, [Ll.Const 0L; Ll.Const 1L; Ll.Const (Int64.of_int i) ]));
                                                                                I(gens2, Store(cmp_ty typ, exp_op, Id gens1))] in
                                                                          exp2_strm, exp_strm
                                                            ) e_list
                                                ) in
            let cmp_exps_strm = List.flatten exps_strm in
              let cmp_exps2_strm = List.rev (List.flatten (exps2_strm)) in
                (arr_ty, arr_op, (arr_strm >@ cmp_exps_strm >@ cmp_exps2_strm))
    | NewArr (typ, e) -> 
        let len_ty, len_op, len_str = cmp_exp c e in
          let (arr_ty, arr_op, arr_strm) = oat_alloc_array typ (len_op) in
            (cmp_ty (TRef (RArray typ)), arr_op, (len_str >@ arr_strm))                   
    | Id ast_id ->  
        let gens_id = gensym ast_id in
          let (ll_ty, ll_op) =  Ctxt.lookup ast_id c in
            begin match ll_ty with
              | Ptr typ -> (typ, Ll.Id gens_id, [I(gens_id, Load (ll_ty, ll_op))])
              | badty -> failwith ("id not a pointer: " ^ ast_id)
            end                       
    | Index (e1, e2) -> 
        let ll_ty1, ll_op1, ll_strm1 = cmp_exp c e1 in
          let ll_ty2, ll_op2, ll_strm2 = cmp_exp c e2 in
            let gens_id = gensym "array_index" in
              let loaded_value = gensym "loaded_val" in
                let val_typ = begin match ll_ty1 with
                                | Ptr (Struct [I64; Array(len, typ)]) -> typ
                                | not_ptr -> failwith ("not a pointer" ^ string_of_exp e1)
                              end in   
                val_typ, Ll.Id loaded_value, ll_strm1 >@ ll_strm2 
                >@ [I(gens_id, Gep (ll_ty1, ll_op1, [Ll.Const 0L; Ll.Const 1L; ll_op2]))] >@
                [I(loaded_value, Load (Ptr val_typ, Ll.Id gens_id))]
    | Call (e, e_list) ->
        let fun_call =  begin match e.elt with
                          | Id e_id -> let (ll_rettyp, ll_fun_op) = Ctxt.lookup_function e_id c in
                                        let ll_args_tys, ll_fun_ty = begin match ll_rettyp with
                                                                        | Ptr (Fun(x, y)) -> x, y
                                                                        | _ -> failwith "wrong function type"
                                                                      end in
                                        let (ll_tys_ops, ll_strms) = List.split (
                                                                        List.map (
                                                                          fun e -> let ll_ty, ll_op, ll_strm = cmp_exp c e in
                                                                            (ll_ty, ll_op), ll_strm
                                                                        ) e_list) in
                                            let exps_strms = List.flatten (List.rev ll_strms) in
                                              let funct = gensym "funct" in
                                              (ll_fun_ty, Ll.Id funct, exps_strms >@ [I(funct, Call(ll_fun_ty, ll_fun_op, ll_tys_ops))])
                          | _ -> failwith "not a function"
                        end in
          fun_call
    | Bop (bop, e1, e2) ->
        let (ll_ty1, ll_op1, strm1) = cmp_exp c e1 in
          let (ll_ty2, ll_op2, strm2) = cmp_exp c e2 in
            let (op_insn, ret_tp) = 
              begin match bop with
                | Add -> Ll.Binop  (Add, (cmp_ty TInt), ll_op1, ll_op2), (cmp_ty TInt)
                | Sub -> Ll.Binop  (Sub, (cmp_ty TInt), ll_op1, ll_op2), (cmp_ty TInt)
                | Mul -> Ll.Binop  (Mul, (cmp_ty TInt), ll_op1, ll_op2), (cmp_ty TInt)
                | IAnd -> Ll.Binop (And, (cmp_ty TInt), ll_op1, ll_op2), (cmp_ty TInt)
                | IOr -> Ll.Binop  (Or, (cmp_ty TInt), ll_op1, ll_op2), (cmp_ty TInt)
                | Shl -> Ll.Binop  (Shl, (cmp_ty TInt), ll_op1, ll_op2), (cmp_ty TInt)
                | Shr -> Ll.Binop  (Lshr, (cmp_ty TInt), ll_op1, ll_op2), (cmp_ty TInt)
                | Sar -> Ll.Binop  (Ashr, (cmp_ty TInt), ll_op1, ll_op2), (cmp_ty TInt)
                | And -> Ll.Binop  (And, (cmp_ty TBool), ll_op1, ll_op2), (cmp_ty TBool)
                | Or -> Ll.Binop   (Or, (cmp_ty TBool), ll_op1, ll_op2), (cmp_ty TBool)
                | Eq  -> Ll.Icmp   (Eq, ll_ty1, ll_op1, ll_op2), (cmp_ty TBool)
                | Neq -> Ll.Icmp   (Ne, ll_ty1, ll_op1, ll_op2), (cmp_ty TBool)
                | Lt  -> Ll.Icmp   (Slt, ll_ty1, ll_op1, ll_op2), (cmp_ty TBool)
                | Lte -> Ll.Icmp   (Sle, ll_ty1, ll_op1, ll_op2), (cmp_ty TBool)
                | Gt  -> Ll.Icmp   (Sgt, ll_ty1, ll_op1, ll_op2), (cmp_ty TBool)
                | Gte -> Ll.Icmp   (Sge, ll_ty1, ll_op1, ll_op2), (cmp_ty TBool)
              end in
                let binop = (gensym "bop") in 
            (ret_tp, Ll.Id binop, (strm1 >@ strm2 >:: I (binop, op_insn)))
    | Uop (uop, e) ->  
        let (ll_ty, ll_op, strm) = (cmp_exp c e) in
          let match_exp = 
            begin match uop with
              | Neg -> Ll.Binop (Sub, ll_ty, Ll.Const 0L, ll_op)
              | Lognot -> Ll.Icmp  (Eq, ll_ty, ll_op, Ll.Const 0L)
              | Bitnot  -> Ll.Binop (Xor, ll_ty, ll_op, Ll.Const (-1L))
            end in
              let unop = (gensym "uop") in
        ((ll_ty, (Ll.Id unop), strm >:: I (unop, match_exp)))
  end

(* Compile a statement in context c with return typ rt. Return a new context, 
   possibly extended with new local bindings, and the instruction stream
   implementing the statement.

   Left-hand-sides of assignment statements must either be OAT identifiers,
   or an index into some arbitrary expression of array type. Otherwise, the
   program is not well-formed and your compiler may throw an error.

   Tips:
   - for local variable declarations, you will need to emit Allocas in the
     entry block of the current function using the E() constructor.

   - don't forget to add a bindings to the context for local variable 
     declarations
   
   - you can avoid some work by translating For loops to the corresponding
     While loop, building the AST and recursively calling cmp_stmt

   - you might find it helpful to reuse the code you wrote for the Call
     expression to implement the SCall statement

   - compiling the left-hand-side of an assignment is almost exactly like
     compiling the Id or Index expression. Instead of loading the resulting
     pointer, you just need to store to it!

 *)
let rec cmp_stmt (c:Ctxt.t) (rt:Ll.ty) (stmt:Ast.stmt node) : Ctxt.t * stream =
  (* failwith "cmp_stmt not implemented" *)
  begin match stmt.elt with
    | Assn (e1_assn, e2_assn) ->
        begin match e1_assn.elt with 
        | Id exp_id -> let ll_ty1, ll_op1 = Ctxt.lookup exp_id c in 
                     let ll_ty2, ll_op2, strm2 = cmp_exp c e2_assn in 
                     (c, (strm2 >@ [I("assn_store", Store(ll_ty2, ll_op2, ll_op1))]))
        | Index(e1, e2) -> 
            let e1_ty, e1_op, e1_strm = cmp_exp c e1 in 
            let e2_ty, e2_op, e2_strm = cmp_exp c e2 in 
            let ll_ty2, ll_op2, strm2 = cmp_exp c e2_assn in 
            let assn_ind = gensym "assn_ind" in  
            (c, e1_strm >@ e2_strm >@ strm2 >@ [I(assn_ind, Gep(e1_ty, e1_op, [Const 0L; Const 1L; e2_op]))]
            >@ [I(gensym "random", Store(ll_ty2, ll_op2, Ll.Id (assn_ind)))])
        | _ -> failwith "not a valid path"
        end
    | Decl (var_id, e) ->
        let var_ty, var_op, var_strm = cmp_exp c e in 
          let gens_var = gensym var_id in 
            let new_ctxt = Ctxt.add c var_id (Ptr var_ty, Ll.Id gens_var) in 
              new_ctxt, var_strm >@ 
              [E (gens_var, Alloca (var_ty))] >@ 
              [I (gensym "decl_store", Store (var_ty, var_op, Ll.Id gens_var))]
    | Ret e_opt -> 
        begin match e_opt with
          | Some e -> let (typ, op, strm) = (cmp_exp c e) in
                          (c, strm >@  [T(Ll.Ret (typ, Some op))])
          | None -> (c, [T (Ll.Ret(Ll.Void, None))])
        end
    | SCall (e, e_lst) ->
    let call_ty, call_op, strm = cmp_exp c (no_loc (Call (e, e_lst))) in
    c, strm

    | If (e, s_lst1, s_lst2) -> 
        let (typ, op, strm) = cmp_exp c e in
          let (c1, strm1) = cmp_block c rt s_lst1 in
            let (c2, strm2) = cmp_block c rt s_lst2 in
                let then_branch = (gensym "then") in
                  let merge = (gensym "merge") in 
                    let if_streams = 
                      if List.length strm2 == 0
                        then 
                          [T (Cbr (op, then_branch, merge))] >@
                          [L then_branch] >@ strm1 >@ [T (Br merge)] >@ 
                          [L merge]
                      else
                        let else_branch = (gensym "else") in
                          [T (Cbr (op, then_branch, else_branch))] >@
                          [L then_branch] >@ strm1 >@ [T (Br merge)] >@
                          [L else_branch] >@ strm2 >@ [T (Br merge)] >@ [L merge] in
          (c, strm >@ if_streams)
    | For (vdecl_lst, e_opt, stmt_opt, stmt_block) -> 
        let c_vdecl, vdecl_strms = List.fold_left (
                                    fun (ctext, strm) (decl_id, decl_exp) -> 
                                        let ll_ty1, ll_op1, strm1 = cmp_exp ctext decl_exp in
                                          let (new_ctxt, new_strm) = cmp_stmt ctext ll_ty1 (no_loc (Decl (decl_id, decl_exp))) in
                                            (new_ctxt, strm >@ new_strm)
                                    ) (c, []) vdecl_lst in
          let (exp_ty, exp_op, exp_strm) = begin match e_opt with
            | None -> cmp_exp c_vdecl (no_loc (CBool true))
            | Some e -> cmp_exp c_vdecl e
          end in
            let (stmt_ctxt, stmt_strm) = begin match stmt_opt with
              | None -> c_vdecl, []
              | Some s -> cmp_stmt c_vdecl rt s
            end in
              let n_ctxt, block_strm = cmp_block stmt_ctxt rt stmt_block in
                let body = (gensym "body") in
                  let entry = (gensym "entry") in
                    let merge = (gensym "merge") in

        stmt_ctxt, vdecl_strms >@
            [T (Br (entry))] >@
            [L entry]  >@ exp_strm >@
            [T (Cbr (exp_op, body, merge))] >@
            [L body] >@ block_strm >@ stmt_strm >@[T (Br entry)]>@ 
            [L merge]

    | While (e, s_lst) -> 
        let (typ, op, strm) = cmp_exp c e in
          let (c1, strm1) = cmp_block c rt s_lst in
            let body = (gensym "body") in
              let entry = (gensym "entry") in
                let merge = (gensym "merge") in
                  let streams =
                    [T (Br (entry))] >@
                    [L entry]  >@ strm >@
                    [T (Cbr (op, body, merge))] >@
                    [L body] >@ strm1 >@ [T (Br entry)]>@ 
                    [L merge] in
          (c, streams)
  end
(* Compile a series of statements *)

and cmp_block (c:Ctxt.t) (rt:Ll.ty) (stmts:Ast.block) : Ctxt.t * stream =
  List.fold_left (fun (c, code) s -> 
      let c, stmt_code = cmp_stmt c rt s in
      c, code >@ stmt_code
    ) (c,[]) stmts



(* Adds each function identifer to the context at an
   appropriately translated type.  

   NOTE: The Gid of a function is just its source name
*)
let cmp_function_ctxt (c:Ctxt.t) (p:Ast.prog) : Ctxt.t =
    List.fold_left (fun c -> function
      | Ast.Gfdecl { elt={ frtyp; fname; args } } ->
         let ft = TRef (RFun (List.map fst args, frtyp)) in
         Ctxt.add c fname (cmp_ty ft, Gid fname)
      | _ -> c
    ) c p 

(* Populate a context with bindings for global variables 
   mapping OAT identifiers to LLVMlite gids and their types.

   Only a small subset of OAT expressions can be used as global initializers
   in well-formed programs. (The constructors starting with C). 
*)
let cmp_global_ctxt (c:Ctxt.t) (p:Ast.prog) : Ctxt.t =
    (* failwith "cmp_global_ctxt unimplemented" *)
    List.fold_left (fun c -> function
      | Ast.Gvdecl { elt={ name; init } } ->
          begin match init.elt with
            | CNull rtyp -> Ctxt.add c name (Ptr (Ptr (cmp_rty rtyp)), Gid name) 
            | CBool boolv -> Ctxt.add c name (Ptr I1, Gid name)
            | CInt int64v -> Ctxt.add c name (Ptr I64, Gid name)
            | CStr stringv -> Ctxt.add c name (Ptr (Ptr I8), Gid name)
            | CArr (typ, exp_lst) -> Ctxt.add c name (Ptr (cmp_ty(TRef (RArray typ))), Gid name)
            | _ -> failwith "wrong global var"
          end
      | _ -> c
    ) c p


(* Compile a function declaration in global context c. Return the LLVMlite cfg
   and a list of global declarations containing the string literals appearing
   in the function.

   You will need to
   1. Allocate stack space for the function parameters using Alloca
   2. Store the function arguments in their corresponding alloca'd stack slot
   3. Extend the context with bindings for function variables
   4. Compile the body of the function using cmp_block
   5. Use cfg_of_stream to produce a LLVMlite cfg from 
 *)
let cmp_fdecl (c:Ctxt.t) (f:Ast.fdecl node) : Ll.fdecl * (Ll.gid * Ll.gdecl) list =
  (* failwith "cmp_fdecl not implemented" *)
  let { elt={ frtyp; fname; args; body } } = f in
    let (args_ts, func_param) = List.split args in
      let func_fty, llrtyp = cmp_fty (args_ts, frtyp) in
        let alloc_stack = List.map (
                            fun (typ, ast_id) ->
                              let stack_slot = gensym "alloca" in
                                (ast_id, cmp_ty typ, Ll.Id stack_slot), [ 
                                  E(stack_slot, (Alloca (cmp_ty typ)));
                                  I(gensym "", (Store (cmp_ty typ, Ll.Id ast_id, Ll.Id stack_slot)))
                                ]
                            ) args in
          let ctxt_args, stack = List.split alloc_stack in
            let ext_ctxt = List.fold_left (fun c (ids, tys, ops) -> Ctxt.add c ids (Ptr tys, ops)) c ctxt_args in
              let _, stream = cmp_block ext_ctxt llrtyp body in
                let func_cfg, func_llglobals = cfg_of_stream (List.rev (List.flatten stack) >@ stream) in
  {f_ty=(func_fty, llrtyp); f_param=func_param; f_cfg=func_cfg}, func_llglobals


(* Compile a global initializer, returning the resulting LLVMlite global
   declaration, and a list of additional global declarations.

   Tips:
   - Only CNull, CBool, CInt, CStr, and CArr can appear as global initializers
     in well-formed OAT programs. Your compiler may throw an error for the other
     cases

   - OAT arrays are always handled via pointers. A global array of arrays will
     be an array of pointers to arrays emitted as additional global declarations.
*)
let rec cmp_gexp c (e:Ast.exp node) : Ll.gdecl * (Ll.gid * Ll.gdecl) list =
  (* failwith "cmp_init not implemented" *)
  begin match e.elt with
    | CNull typ -> (Ptr (cmp_rty typ), GNull), []
    | CBool boolv -> (I1, GInt (Int64.of_int (Bool.to_int boolv))), []
    | CInt int64v -> (I64, GInt int64v), []
    | CStr str -> let gid = gensym "g_str" in
            (Ptr I8, GBitcast(Ptr (Array(1 + String.length str, I8)), GGid gid, Ptr I8)),
            [gid, (Array(1 + String.length str, I8), Ll.GString str)]
    | CArr  (typ, e_list) ->
        let gid = gensym "g_array" in
          let len_lst = List.length e_list in
          let gdecls, add_gdecls = List.split (List.map (cmp_gexp c) e_list) in 
            let array_elts_decls = List.flatten add_gdecls in
        (cmp_ty(TRef(RArray typ)),
          (GBitcast (Ptr (Struct[I64; Array (len_lst, cmp_ty typ)]), GGid gid, Ptr (Struct [ I64; Array (0, cmp_ty typ) ])))), 
          (array_elts_decls >:: (gid, (Struct [ I64; Array (len_lst, cmp_ty typ)], GStruct
          [ I64, GInt (Int64.of_int (len_lst)); Array (len_lst, cmp_ty typ), GArray gdecls ])))
    | _ -> failwith "wrong type"
  end

(* Oat internals function context ------------------------------------------- *)
let internals = [
    "oat_alloc_array",         Ll.Fun ([I64], Ptr I64)
  ]

(* Oat builtin function context --------------------------------------------- *)
let builtins =
  [ "array_of_string",  cmp_rty @@ RFun ([TRef RString], RetVal (TRef(RArray TInt)))
  ; "string_of_array",  cmp_rty @@ RFun ([TRef(RArray TInt)], RetVal (TRef RString))
  ; "length_of_string", cmp_rty @@ RFun ([TRef RString],  RetVal TInt)
  ; "string_of_int",    cmp_rty @@ RFun ([TInt],  RetVal (TRef RString))
  ; "string_cat",       cmp_rty @@ RFun ([TRef RString; TRef RString], RetVal (TRef RString))
  ; "print_string",     cmp_rty @@ RFun ([TRef RString],  RetVoid)
  ; "print_int",        cmp_rty @@ RFun ([TInt],  RetVoid)
  ; "print_bool",       cmp_rty @@ RFun ([TBool], RetVoid)
  ]


  let _ =
    Printexc.record_backtrace true
(* Compile a OAT program to LLVMlite *)
let cmp_prog (p:Ast.prog) : Ll.prog =
  (* add built-in functions to context *)
  let init_ctxt = 
    List.fold_left (fun c (i, t) -> Ctxt.add c i (Ll.Ptr t, Gid i))
      Ctxt.empty builtins
  in
  let fc = cmp_function_ctxt init_ctxt p in

  (* build global variable context *)
  let c = cmp_global_ctxt fc p in

  (* compile functions and global variables *)
  let fdecls, gdecls = 
    List.fold_right (fun d (fs, gs) ->
        match d with
        | Ast.Gvdecl { elt=gd } -> 
           let ll_gd, gs' = cmp_gexp c gd.init in
           (fs, (gd.name, ll_gd)::gs' @ gs)
        | Ast.Gfdecl fd ->
           let fdecl, gs' = cmp_fdecl c fd in
           (fd.elt.fname,fdecl)::fs, gs' @ gs
      ) p ([], [])
  in

  (* gather external declarations *)
  let edecls = internals @ builtins in
  { tdecls = []; gdecls; fdecls; edecls }