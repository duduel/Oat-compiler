(* ll ir compilation -------------------------------------------------------- *)

open Ll
open X86

(* Overview ----------------------------------------------------------------- *)

(* We suggest that you spend some time understanding this entire file and
   how it fits with the compiler pipeline before making changes.  The suggested
   plan for implementing the compiler is provided on the project web page.
*)


(* helpers ------------------------------------------------------------------ *)

(* Map LL comparison operations to X86 condition codes *)
let compile_cnd = function
  | Ll.Eq  -> X86.Eq
  | Ll.Ne  -> X86.Neq
  | Ll.Slt -> X86.Lt
  | Ll.Sle -> X86.Le
  | Ll.Sgt -> X86.Gt
  | Ll.Sge -> X86.Ge



(* locals and layout -------------------------------------------------------- *)

(* One key problem in compiling the LLVM IR is how to map its local
   identifiers to X86 abstractions.  For the best performance, one
   would want to use an X86 register for each LLVM %uid.  However,
   since there are an unlimited number of %uids and only 16 registers,
   doing so effectively is quite difficult.  We will see later in the
   course how _register allocation_ algorithms can do a good job at
   this.

   A simpler, but less performant, implementation is to map each %uid
   in the LLVM source to a _stack slot_ (i.e. a region of memory in
   the stack).  Since LLVMlite, unlike real LLVM, permits %uid locals
   to store only 64-bit data, each stack slot is an 8-byte value.

   [ NOTE: For compiling LLVMlite, even i1 data values should be
   represented as a 8-byte quad. This greatly simplifies code
   generation. ]

   We call the datastructure that maps each %uid to its stack slot a
   'stack layout'.  A stack layout maps a uid to an X86 operand for
   accessing its contents.  For this compilation strategy, the operand
   is always an offset from %rbp (in bytes) that represents a storage slot in
   the stack.
*)

type layout = (uid * X86.operand) list

(* A context contains the global type declarations (needed for getelementptr
   calculations) and a stack layout. *)
type ctxt = { tdecls : (tid * ty) list
            ; layout : layout
            }

(* useful for looking up items in tdecls or layouts *)
let lookup m x = List.assoc x m


(* compiling operands  ------------------------------------------------------ *)

(* LLVM IR instructions support several kinds of operands.

   LL local %uids live in stack slots, whereas global ids live at
   global addresses that must be computed from a label.  Constants are
   immediately available, and the operand Null is the 64-bit 0 value.

     NOTE: two important facts about global identifiers:

     (1) You should use (Platform.mangle gid) to obtain a string
     suitable for naming a global label on your platform (OS X expects
     "_main" while linux expects "main").

     (2) 64-bit assembly labels are not allowed as immediate operands.
     That is, the X86 code: movq _gid %rax which looks like it should
     put the address denoted by _gid into %rax is not allowed.
     Instead, you need to compute an %rip-relative address using the
     leaq instruction:   leaq _gid(%rip).

   One strategy for compiling instruction operands is to use a
   designated register (or registers) for holding the values being
   manipulated by the LLVM IR instruction. You might find it useful to
   implement the following helper function, whose job is to generate
   the X86 instruction that moves an LLVM operand into a designated
   destination (usually a register).
*)
let compile_operand (ctxt:ctxt) (dest:X86.operand) : Ll.operand -> ins = function 
  | Null -> (Movq, [Imm (Lit 0L); dest])
  | Const i -> (Movq, [Imm (Lit i); dest])
  | Gid g -> (Leaq, [Ind3 (Lbl (Platform.mangle g), Rip); dest])
  | Id u -> (Movq, [lookup ctxt.layout u; dest])


(* compiling call  ---------------------------------------------------------- *)

(* You will probably find it helpful to implement a helper function that
   generates code for the LLVM IR call instruction.

   The code you generate should follow the x64 System V AMD64 ABI
   calling conventions, which places the first six 64-bit (or smaller)
   values in registers and pushes the rest onto the stack.  Note that,
   since all LLVM IR operands are 64-bit values, the first six
   operands will always be placed in registers.  (See the notes about
   compiling fdecl below.)

   [ NOTE: It is the caller's responsibility to clean up arguments
   pushed onto the stack, so you must free the stack space after the
   call returns. ]

   [ NOTE: Don't forget to preserve caller-save registers (only if
   needed). ]
*)




(* compiling getelementptr (gep)  ------------------------------------------- *)

(* The getelementptr instruction computes an address by indexing into
   a datastructure, following a path of offsets.  It computes the
   address based on the size of the data, which is dictated by the
   data's type.

   To compile getelementptr, you must generate x86 code that performs
   the appropriate arithmetic calculations.
*)

(* [size_ty] maps an LLVMlite type to a size in bytes.
    (needed for getelementptr)

   - the size of a struct is the sum of the sizes of each component
   - the size of an array of t's with n elements is n * the size of t
   - all pointers, I1, and I64 are 8 bytes
   - the size of a named type is the size of its definition

   - Void, i8, and functions have undefined sizes according to LLVMlite.
     Your function should simply return 0 in those cases
*)
let rec size_ty (tdecls:(tid * ty) list) (t:Ll.ty) : int =
  match t with
  | Void -> 0
  | I1 -> 8
  | I8 -> 0
  | I64 -> 8
  | Ptr _ -> 8
  | Struct l -> List.fold_left (+) 0 (List.map (size_ty tdecls) l)
  | Array (x, tp) -> (size_ty tdecls tp) * x
  | Fun _ -> 0
  | Namedt td -> size_ty tdecls (lookup tdecls td) 




(* Generates code that computes a pointer value.

   1. op must be of pointer type: t*

   2. the value of op is the base address of the calculation

   3. the first index in the path is treated as the index into an array
     of elements of type t located at the base address

   4. subsequent indices are interpreted according to the type t:

     - if t is a struct, the index must be a constant n and it
       picks out the n'th element of the struct. [ NOTE: the offset
       within the struct of the n'th element is determined by the
       sizes of the types of the previous elements ]

     - if t is an array, the index can be any operand, and its
       value determines the offset within the array.

     - if t is any other type, the path is invalid

   5. if the index is valid, the remainder of the path is computed as
      in (4), but relative to the type f the sub-element picked out
      by the path so far
*)



let compile_gep (ctxt:ctxt) (op : Ll.ty * Ll.operand) (path: Ll.operand list) : ins list =
  (* failwith "compile_gep not implemented" *)
    begin match op with
      | (Ptr t, x) -> let ptr_gep =
                        [compile_operand ctxt (Reg R09) x] @
                        [(Movq, [Imm ( Lit (Int64.of_int (size_ty ctxt.tdecls t))); Reg Rdx])] @
                        [compile_operand ctxt (Reg Rcx) (List.hd path)] @
                        [(Imulq, [Reg Rcx; Reg Rdx])] @
                        [(Addq, [Reg Rdx; Reg R09])]
                        in
        let rec comp' (typ: Ll.ty) (pathc:Ll.operand list) : ins list =
          begin match pathc with
            | [] -> []
            | _ -> begin match typ with
                    | Struct ty_lst -> let path_head =
                                          begin match List.hd pathc with
                                            | Const i -> Int64.to_int i
                                            | _ -> failwith "wrong path"
                                          end in
                                          (List.fold_left (
                                                            fun x y ->
                                                              x @
                                                              [(Addq, [Imm ( Lit (Int64.of_int (size_ty ctxt.tdecls y))); Reg R09])]
                                                          )
                                                          [] (Array.to_list (Array.sub (Array.of_list (ty_lst)) 0 (path_head)))
                                          )
                                          @ comp' (List.nth ty_lst path_head) (List.tl pathc)       

                    | Array (len, tp) -> [compile_operand ctxt (Reg Rdx) (List.hd pathc)] @
                                       
                                         [(Imulq, [Imm ( Lit (Int64.of_int (size_ty ctxt.tdecls tp))); Reg Rdx])] @

                                         [(Addq, [Reg Rdx; Reg R09])] @

                                       comp' tp (List.tl pathc)
                    | I1 | I64 -> [compile_operand ctxt (Reg Rdx) (List.hd pathc)] @
                                       
                                  [(Imulq, [Imm ( Lit (Int64.of_int (size_ty ctxt.tdecls typ))); Reg Rdx])] @

                                  [(Addq, [Reg Rdx; Reg R09])]
                    | Void | I8 | Fun _ -> []
                    | Namedt td -> comp' (lookup ctxt.tdecls td) pathc
                    | _ -> failwith "wrong type"
                  end
          end
          in ptr_gep @ comp' t (List.tl path)
  
      | _ -> failwith "not a pointer"
    end

      (* [(Addq, [(Int64.of_int (size_ty ctxt.tdecls y)); Reg R09])]
                    
                    
                    
                    match pathc with


                                [(Imulq, [(Int64.of_int (size_ty ctxt.tdecls y)); Reg R09])]

                    
                    
                    
                    let mem_typ = comp' tp  in

                    
                    (size_ty ctxt.tdecls tp) path[1] +     (List.tl path) *)



(* compiling instructions  -------------------------------------------------- *)

(* The result of compiling a single LLVM instruction might be many x86
   instructions.  We have not determined the structure of this code
   for you. Some of the instructions require only a couple of assembly
   instructions, while others require more.  We have suggested that
   you need at least compile_operand, compile_call, and compile_gep
   helpers; you may introduce more as you see fit.

   Here are a few notes:

   - Icmp:  the Setb instruction may be of use.  Depending on how you
     compile Cbr, you may want to ensure that the value produced by
     Icmp is exactly 0 or 1.

   - Load & Store: these need to dereference the pointers. Const and
     Null operands aren't valid pointers.  Don't forget to
     Platform.mangle the global identifier.

   - Alloca: needs to return a pointer into the stack

   - Bitcast: does nothing interesting at the assembly level
*)
let compile_insn (ctxt:ctxt) ((uid:uid), (i:Ll.insn)) : X86.ins list =
  match i with
  | Binop (bop, _, opd1, opd2) -> let op = lookup (
                                                      List.combine
                                                      [Add; Sub; Mul; Shl; Lshr; Ashr; And; Or; Xor]
                                                      [Addq;  Subq; Imulq; Shlq; Shrq; Sarq; Andq; Orq; Xorq]
                                                  ) bop in
                                          [compile_operand ctxt (Reg Rcx) opd2] @
                                          [compile_operand ctxt (Reg Rax) opd1] @
                                          [(op, [Reg Rcx; Reg Rax])] @
                                          [(Movq, [Reg Rax; lookup ctxt.layout uid])]
  | Alloca _typ -> [
                      (Subq, [Imm (Lit (Int64.of_int (8))); Reg Rsp]);
                      (Movq, [Reg Rsp; lookup ctxt.layout uid])
                   ]
  | Load (_typ, opd) -> [ 
                          (compile_operand ctxt (Reg Rcx) opd);
                          (Movq, [Ind2 (Rcx); Reg Rax]);
                          (Movq, [Reg Rax; lookup ctxt.layout uid])
                        ]
  | Store (_typ, opd1, opd2) -> [ 
                                  (compile_operand ctxt (Reg Rcx) opd1);
                                  (compile_operand ctxt (Reg Rax) opd2);
                                  (Movq, [Reg Rcx; Ind2 (Rax)])
                               ]
  | Icmp (cnd, _, opd1, opd2) -> let local_uid = lookup ctxt.layout uid in
                                    let cnd_86 = lookup (
                                                    List.combine
                                                    [Ll.Eq; Ll.Ne; Ll.Sgt; Ll.Sge; Ll.Slt; Ll.Sle]
                                                    [Eq; Neq; Gt; Ge; Lt; Le]
                                                  ) cnd in
                                        [compile_operand ctxt (Reg Rcx) opd2] @
                                        [compile_operand ctxt (Reg Rax) opd1] @
                                        [(Cmpq, [Reg Rcx; Reg Rax])] @
                                        [(Set cnd_86, [local_uid])] @ 
                                        [Andq, [Imm (Lit (Int64.of_int 1)); local_uid]]

  | Call (ty, opd, ty_oplst) -> let len_oplst = List.length ty_oplst in
                                  let compiled_ops = List.flatten 
                                                        (List.mapi (
                                                            fun i (_, y) -> let first_op = [compile_operand ctxt (Reg R11) y] in
                                                                              let sec_op = 
                                                                                if i < (len_oplst - 6)
                                                                                  then
                                                                                    [
                                                                                      (Subq, [Imm (Lit (Int64.of_int (8))); Reg Rsp]);
                                                                                      (Movq, [Reg R11; Ind2 (Rsp)])
                                                                                      (* (Pushq, [Reg R11]) *)
                                                                                    ]
                                                                                else
                                                                                  let reg = List.nth [Rdi; Rsi; Rdx; Rcx; R08; R09] (len_oplst - i - 1) in
                                                                                    [
                                                                                      (Movq, [Reg R11; Reg reg])
                                                                                    ]
                                                                            in first_op @ sec_op
                                                          ) (List.rev ty_oplst)
                                                        ) in
                                    compiled_ops 
                                    
                                    @ 

                                    [(Subq, [Imm (Lit (Int64.of_int (8))); Reg Rsp])]
                                    
                                    @

                                    [compile_operand ctxt (Reg Rax) opd]
                                    
                                    @

                                    [(Callq, [Reg Rax])]

                                    @

                                    [(Movq, [Reg Rax; lookup ctxt.layout uid])] 
                                    
                                    @

                                    (
                                        if len_oplst > 6
                                          then
                                            [
                                              (Addq, [Imm (Lit (Int64.of_int (((len_oplst - 6) + 1) * 8))); Reg Rsp])
                                            ]
                                        else
                                          [
                                            (Addq, [Imm (Lit (Int64.of_int 8)); Reg Rsp])
                                          ]
                                    )

                                    

   (* (ty, operand, (ty, operand)) *)
  | Bitcast (typ1, opd, typ2) -> [compile_operand ctxt (Reg Rcx) opd] @ [(Movq, [Reg Rcx; lookup ctxt.layout uid])] 
  | Gep (typ, opd1, opd2lst) -> compile_gep ctxt (typ, opd1) opd2lst  @ [(Movq, [Reg R09; lookup ctxt.layout uid])](* (typ, opd1, opd2) *)


  




(* compiling terminators  --------------------------------------------------- *)

(* prefix the function name [fn] to a label to ensure that the X86 labels are 
   globally unique . *)
let mk_lbl (fn:string) (l:string) = fn ^ "." ^ l

(* Compile block terminators is not too difficult:

   - Ret should properly exit the function: freeing stack space,
     restoring the value of %rbp, and putting the return value (if
     any) in %rax.

   - Br should jump

   - Cbr branch should treat its operand as a boolean conditional

   [fn] - the name of the function containing this terminator
*)
let compile_terminator (fn:string) (ctxt:ctxt) (t:Ll.terminator) : ins list =
  (* failwith "compile_terminator not implemented" *)
  begin match t with
    | Ret (tp, opd_opt) -> let before_ret =
                            begin match opd_opt with
                              | None -> []
                              | Some x -> 
                                  let opd = Option.get opd_opt in
                                      begin match opd with
                                        | Null -> []
                                        | Const c -> [(Movq, [Imm (Lit c); Reg Rax])] 
                                        | Gid id | Id id -> [(Movq, [lookup ctxt.layout id; Reg Rax])] 
                                      end
                            end                      
                                  in  before_ret @ [
                                                      (Movq, [Ind3 (Lit (Int64.of_int (-8)), Rbp); Reg Rbx]);
                                                      (Movq, [Reg Rbp; Reg Rsp]);
                                                      (Popq, [Reg Rbp]);
                                                      (Retq, [])
                                                   ]
    | Br lbl -> [(Jmp, [Imm(Lbl (mk_lbl fn (Platform.mangle lbl)))])]
    | Cbr (opd, lbl1, lbl2) -> (compile_operand ctxt (Reg Rdx) opd) :: [(Cmpq, [Imm (Lit (Int64.of_int 1)); Reg Rdx]); (J Neq, [Imm (Lbl (mk_lbl fn (Platform.mangle lbl2)))])]
  end



(* compiling blocks --------------------------------------------------------- *)

(* We have left this helper function here for you to complete. 
   [fn] - the name of the function containing this block
   [ctxt] - the current context
   [blk]  - LLVM IR code for the block
*)
let compile_block (fn:string) (ctxt:ctxt) (blk:Ll.block) : ins list =
  let (_, ter) = blk.term in
  List.fold_left (@) [] (List.map (compile_insn ctxt) blk.insns)
  @ compile_terminator fn ctxt ter

let compile_lbl_block fn lbl ctxt blk : elem =
  Asm.text (mk_lbl fn lbl) (compile_block fn ctxt blk)



(* compile_fdecl ------------------------------------------------------------ *)


(* This helper function computes the location of the nth incoming
   function argument: either in a register or relative to %rbp,
   according to the calling conventions.  You might find it useful for
   compile_fdecl.

   [ NOTE: the first six arguments are numbered 0 .. 5 ]
*)
let arg_loc (n : int) : operand =
  if n >= 0 && n < 6 then
    Reg (List.nth [Rdi; Rsi; Rdx; Rcx; R08; R09] n)
  else
    Ind3 (Lit (Int64.of_int ((n-5)*8)), Rbp)


(* We suggest that you create a helper function that computes the
   stack layout for a given function declaration.

   - each function argument should be copied into a stack slot
   - in this (inefficient) compilation strategy, each local id
     is also stored as a stack slot.
   - see the discussion about locals

*)

(* let arg_lyt = List.init (last_n + 1) (fun x -> (List.nth args x, arg_loc x)) in *)
let stack_layout (args : uid list) ((block, lbled_blocks):cfg) : layout =
  let uids_block (blck: Ll.block) =
    let {insns = insns; term = (_, _)} = blck in
      (List.map (fun (x, _) -> x) insns) in
        let fn_uids = (args) @ (uids_block block) @ (List.fold_left (@) [] (List.map (fun (_, y) -> uids_block y) lbled_blocks)) in
          let ctr = ref (-8) in
            List.map (fun x ->
                        ctr := !ctr - 8;
                        (x, Ind3 (Lit (Int64.of_int !ctr), Rbp))
                     ) fn_uids
  (* block.insns
  args @ 
  (* let last_n = (List.length args) - 1 in *)
  let ctr = ref 0 in
    let arg_lyt = List.map (fun x ->
                              ctr := !ctr - 8;
                              (x, Ind3 (Lit (Int64.of_int !ctr), Rbp)
                            ) args in
        let lyt_block (blck: Ll.block): layout = 
          let {insns = lst; term = (u_ter, _)} = blck in
            let no_term = List.map (fun (x, _) ->
                                      ctr := !ctr - 8;
                                      (x, Ind3 (Lit (Int64.of_int !ctr), Rbp))
                                   ) lst in
              ctr := !ctr - 8;       
              no_term @ [(u_ter, Ind3 (Lit (Int64.of_int !ctr), Rbp))]
        in
          arg_lyt @ lyt_block block @ (List.fold_left (@) [] 
                                        (List.map (fun (_, y) -> lyt_block y) lbled_blocks)
                                      ) *)




(* The code for the entry-point of a function must do several things:

   - since our simple compiler maps local %uids to stack slots,
     compiling the control-flow-graph body of an fdecl requires us to
     compute the layout (see the discussion of locals and layout)

   - the function code should also comply with the calling
     conventions, typically by moving arguments out of the parameter
     registers (or stack slots) into local storage space.  For our
     simple compilation strategy, that local storage space should be
     in the stack. (So the function parameters can also be accounted
     for in the layout.)

   - the function entry code should allocate the stack storage needed
     to hold all of the local stack slots.
*)

let print_ty chan v = output_string chan (string_of_ins v)

let compile_fdecl (tdecls:(tid * ty) list) (name:string) ({ f_ty; f_param; f_cfg}:fdecl) : prog =
  (* failwith "compile_fdecl not implemented" *)

  let layt = stack_layout f_param f_cfg in

  let ctxt = {
    tdecls = tdecls;
    layout = layt
  } in

  let args_locals = List.fold_left (@) []
                      (
                        List.mapi (fun n _uid -> 
                                    [
                                      (Subq, [Imm (Lit (Int64.of_int (8))); Reg Rsp]);
                                      (Movq, [arg_loc n; Reg R10]);
                                      (Movq, [Reg R10; Ind2 (Rsp)])
                                    ]
                                 ) 
                        f_param
                      ) in
    let decrement_vars = (List.length layt) - (List.length f_param) in

    let (blk, lbl_blocks) = f_cfg in
    let instrs = 
      [
        (Pushq, [Reg Rbp]);
        (Movq, [Reg Rsp; Reg Rbp]);
        (Pushq, [Reg Rbx])
      ]

      @

      args_locals

      @

      (
        if decrement_vars > 0  then
          [(Subq, [Imm (Lit (Int64.of_int (decrement_vars * 8))); Reg Rsp])]
        else
          []
      )

      @

      compile_block name ctxt blk

      in
        
      [(Asm.gtext (Platform.mangle name) instrs)] @ List.map (fun (lbl, lbled_blk) -> compile_lbl_block name lbl ctxt lbled_blk) lbl_blocks

  (* List.iter (Printf.printf "%a \n" print_ty) instrs;

    print_endline "end \n"; *)

  (* stack_layout f_param f_cfg *)
  (* failwith "compile_fdecl not implemented" *)
  

  (* List.map (Movq, [; Reg x])



  (Movq, [Ind3 (Lit Int64.of_int n) ; Rbp])
  (Movq, [Ind3 (Lit Int64.of_int 24) ; Rbp])


  [{ lbl: lbl; global: bool; asm: asm }; ] *)



(* compile_gdecl ------------------------------------------------------------ *)
(* Compile a global value into an X86 global data declaration and map
   a global uid to its associated X86 label.
*)
let rec compile_ginit : ginit -> X86.data list = function
  | GNull     -> [Quad (Lit 0L)]
  | GGid gid  -> [Quad (Lbl (Platform.mangle gid))]
  | GInt c    -> [Quad (Lit c)]
  | GString s -> [Asciz s]
  | GArray gs | GStruct gs -> List.map compile_gdecl gs |> List.flatten
  | GBitcast (t1,g,t2) -> compile_ginit g

and compile_gdecl (_, g) = compile_ginit g


(* compile_prog ------------------------------------------------------------- *)
let compile_prog {tdecls; gdecls; fdecls} : X86.prog =
  let g = fun (lbl, gdecl) -> Asm.data (Platform.mangle lbl) (compile_gdecl gdecl) in
  let f = fun (name, fdecl) -> compile_fdecl tdecls name fdecl in
  (List.map g gdecls) @ (List.map f fdecls |> List.flatten)
