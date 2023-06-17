open Ast
open Astlib
open Tctxt

(* Error Reporting ---------------------------------------------------------- *)
(* NOTE: Use type_error to report error messages for ill-typed programs. *)

exception TypeError of string

let type_error (l : 'a node) (err : string) = 
  let (_, (s, e), _) = l.loc in
  raise (TypeError (Printf.sprintf "[%d, %d] %s" s e err))


(* initial context: G0 ------------------------------------------------------ *)
(* The Oat types of the Oat built-in functions *)
let builtins =
  [ "array_of_string",  ([TRef RString],  RetVal (TRef(RArray TInt)))
  ; "string_of_array",  ([TRef(RArray TInt)], RetVal (TRef RString))
  ; "length_of_string", ([TRef RString],  RetVal TInt)
  ; "string_of_int",    ([TInt], RetVal (TRef RString))
  ; "string_cat",       ([TRef RString; TRef RString], RetVal (TRef RString))
  ; "print_string",     ([TRef RString],  RetVoid)
  ; "print_int",        ([TInt], RetVoid)
  ; "print_bool",       ([TBool], RetVoid)
  ]

(* binary operation types --------------------------------------------------- *)
let typ_of_binop : Ast.binop -> Ast.ty * Ast.ty * Ast.ty = function
  | Add | Mul | Sub | Shl | Shr | Sar | IAnd | IOr -> (TInt, TInt, TInt)
  | Lt | Lte | Gt | Gte -> (TInt, TInt, TBool)
  | And | Or -> (TBool, TBool, TBool)
  | Eq | Neq -> failwith "typ_of_binop called on polymorphic == or !="

(* unary operation types ---------------------------------------------------- *)
let typ_of_unop : Ast.unop -> Ast.ty * Ast.ty = function
  | Neg | Bitnot -> (TInt, TInt)
  | Lognot       -> (TBool, TBool)

(* subtyping ---------------------------------------------------------------- *)
(* Decides whether H |- t1 <: t2 
    - assumes that H contains the declarations of all the possible struct types

    - you will want to introduce addition (possibly mutually recursive) 
      helper functions to implement the different judgments of the subtyping
      relation. We have included a template for subtype_ref to get you started.
      (Don't forget about OCaml's 'and' keyword.)
*)
let rec subtype (c : Tctxt.t) (t1 : Ast.ty) (t2 : Ast.ty) : bool =
  begin match t1, t2 with 
    | TInt, TInt -> true
    | TBool, TBool -> true
    | TRef typ1, TRef typ2 | TNullRef typ1, TNullRef typ2 | TRef typ1, TNullRef typ2 -> subtype_ref c typ1 typ2
    | _ -> false
  end

(* Decides whether H |-r ref1 <: ref2 *)
and subtype_ref (c : Tctxt.t) (t1 : Ast.rty) (t2 : Ast.rty) : bool =
  match t1, t2 with 
  | RString, RString -> true
  | RStruct id1, RStruct id2 -> 
      let struct2 = lookup_struct id2 c in
        List.fold_left (fun bool_v struct2_elt ->
                          let find_mem =
                            begin match lookup_field_option id1 struct2_elt.fieldName c with
                              | Some typ -> struct2_elt.ftyp = typ
                              | None -> false 
                            end in
                          bool_v && find_mem ) true struct2
  | RArray typ1, RArray typ2 -> typ1 = typ2 
  | RFun (args_typ1, ret_typ1), RFun (args_typ2, ret_typ2) ->
      let args_bool = List.fold_left2 (fun bool_v arg1 arg2 -> 
                                         bool_v && subtype c arg2 arg1
                                      ) true args_typ1 args_typ2 in
      let ret_bool = 
        begin match ret_typ1, ret_typ2 with 
          | RetVoid, RetVoid -> true
          | RetVal ty1, RetVal ty2 -> subtype c ty1 ty2 
          | _ -> false
        end in
      (List.length args_typ1 = List.length args_typ2) &&
       args_bool &&
       ret_bool    
  | _ -> false


(* well-formed types -------------------------------------------------------- *)
(* Implement a (set of) functions that check that types are well formed according
   to the H |- t and related inference rules

    - the function should succeed by returning () if the type is well-formed
      according to the rules

    - the function should fail using the "type_error" helper function if the 
      type is not well formed

    - l is just an ast node that provides source location information for
      generating error messages (it's only needed for the type_error generation)

    - tc contains the structure definition context
 *)
let rec typecheck_ty (l : 'a Ast.node) (tc : Tctxt.t) (t : Ast.ty) : unit =
  begin match t with 
    | TInt | TBool -> ()
    | TRef rty | TNullRef rty ->
        begin match rty with
          | RString -> ()
          | RStruct id -> if (lookup_struct_option id tc <> None)
                            then ()
                          else type_error l "Error: unbound struct"
          | RArray typ -> typecheck_ty l tc typ
          | RFun (args_typ, ret_typ) ->
              let args_typ_check =
                List.fold_left (fun bool_v arg ->
                                  bool_v && (typecheck_ty l tc arg = ())
                               ) true args_typ in
              let ret_typ_check =
                begin match ret_typ with 
                  | RetVoid -> true
                  | RetVal typ -> typecheck_ty l tc typ = ()
                end in
              if args_typ_check && ret_typ_check
                then ()
              else type_error l "Error: ill-formed fun"             
        end
  end

(* A helper function to determine whether a type allows the null value *)
let is_nullable_ty (t : Ast.ty) : bool =
  match t with
  | TNullRef _ -> true
  | _ -> false

(* typechecking expressions ------------------------------------------------- *)
(* Typechecks an expression in the typing context c, returns the type of the
   expression.  This function should implement the inference rules given in the
   oat.pdf specification.  There, they are written:

       H; G; L |- exp : t

   See tctxt.ml for the implementation of the context c, which represents the
   four typing contexts: H - for structure definitions G - for global
   identifiers L - for local identifiers

   Returns the (most precise) type for the expression, if it is type correct
   according to the inference rules.

   Uses the type_error function to indicate a (useful!) error message if the
   expression is not type correct.  The exact wording of the error message is
   not important, but the fact that the error is raised, is important.  (Our
   tests also do not check the location information associated with the error.)

   Notes: - Structure values permit the programmer to write the fields in any
   order (compared with the structure definition).  This means that, given the
   declaration struct T { a:int; b:int; c:int } The expression new T {b=3; c=4;
   a=1} is well typed.  (You should sort the fields to compare them.)

*)
let rec typecheck_exp (c : Tctxt.t) (e : Ast.exp node) : Ast.ty =
  match e.elt with 
  | CNull rty -> if typecheck_ty e c (TNullRef rty) = () 
                   then TNullRef rty
                 else 
                   type_error e "Error: CNull ill-typed"
  | CBool _ -> TBool 
  | CInt _ -> TInt
  | CStr _ -> TRef RString
  | Id id ->
      begin match lookup_option id c with
        | Some typ -> typ
        | None -> type_error e "Error: unbound exp_id"
      end
  | CArr (typ, e_lst) -> 
      let bool_lst = List.fold_left (fun bool_v exp ->
                                       bool_v && (subtype c typ (typecheck_exp c exp))
                                    ) true e_lst in
        let valid_arr = (typecheck_ty e c typ = ()) && bool_lst in 
          if valid_arr
            then TRef (RArray typ)
          else 
            type_error e "Error: CArr ill-typed"
  | NewArr (typ, exp) ->
      let check_typ = 
        begin match typ with 
          | TInt | TBool | TNullRef _ -> true
          | _ -> false 
        end in 
        let valid_arr = (typecheck_ty e c typ = ()) &&
                        (typecheck_exp c exp = TInt) && 
                        check_typ in 
          if valid_arr 
            then TRef (RArray typ)
          else
            type_error e "Error: NewArr ill-typed"
  | NewArrInit (typ, exp1, id, exp2) ->
      let typ_check = (typecheck_ty e c typ = ()) in 
        let exp1_check = (typecheck_exp c exp1 = TInt) in 
          let id_look = (lookup_local_option id c = None) in 
            let exp2_check = subtype c (typecheck_exp c exp2) typ in 
              if typ_check && exp1_check && id_look && exp2_check
                then TRef (RArray typ)
              else 
                type_error exp2 "Error: newArrInit ill-typed"
  
  | Index (exp1, exp2) ->
      begin match typecheck_exp c exp1 with 
        | TRef (RArray typ) ->
            begin match typecheck_exp c exp2 with 
              | TInt -> typ
              | _ -> type_error exp2 "Error: bad index (non-integer)"
            end
        | _ -> type_error exp1 "Error: bad indexing (not an array)"
      end
  | Length exp ->
      begin match typecheck_exp c exp with 
        | TRef (RArray typ) -> TInt
        | _ -> type_error exp "Error: bad length (not an array)"
      end
  | CStruct (id, id_exp_lst) ->
      let ctxt_struct =
        begin match (lookup_struct_option id c) with
          | Some strct -> List.map (fun f -> f.fieldName) strct
          | None -> type_error e "Error: struct id not found in ctxt" 
        end in
        let exps_struct = List.map (fun (field_id, field_exp) ->
                                    let exp_typ = typecheck_exp c field_exp in 
                                      begin match (lookup_field_option id field_id c) with
                                        | Some field_exp_typ -> if subtype c exp_typ field_exp_typ
                                                                  then field_id
                                                                else
                                                                  type_error e "Error: bad struct field type"
                                        | None -> type_error e "Error: struct field id not found in ctxt" 
                                        
                                      end
                                  ) id_exp_lst in 
          if List.sort compare ctxt_struct = List.sort compare exps_struct
            then TRef (RStruct id) 
          else type_error e "Error: field ids mismatch"
  | Proj (exp, id) ->
      let exp_struct = 
        begin match typecheck_exp c exp with
          | TRef (RStruct strct) -> strct
          | _ -> type_error e "Error: bad proj (not a struct)"
        end in
          begin match lookup_field_option exp_struct id c with
            | Some typ -> typ
            | None -> type_error e "Error: struct not found in ctxt"
          end
  | Call (exp, exp_lst) ->
      let fun_args_tys, fun_ret_typ = 
        begin match typecheck_exp c exp with 
          | TRef (RFun (args_lst, RetVal ret_typ)) -> (args_lst, ret_typ)
          | _ -> type_error e "Error: not a valid function call"
        end in 
          let exp_args_tys = List.map (typecheck_exp c) exp_lst in 
            if List.length fun_args_tys = List.length exp_args_tys
              then
                begin if List.for_all2 (subtype c) exp_args_tys fun_args_tys
                        then fun_ret_typ
                      else type_error e "Error: bad arguments types"
                end
            else
              type_error e "Error: bad arguments list"
  | Bop (bop, exp1, exp2) -> 
        let exp1_typ = typecheck_exp c exp1 in 
          let exp2_typ = typecheck_exp c exp2 in 
            begin match bop with 
              | Eq | Neq -> 
                  if (subtype c exp1_typ exp2_typ) && (subtype c exp2_typ exp1_typ)  (* (equal ???) *)
                    then TBool
                  else type_error e "Error: bad Eq/Neq types"
              | _ ->
                let val1_typ, val2_typ, bop_typ = typ_of_binop bop in 
                  if val1_typ = exp1_typ && val2_typ = exp2_typ 
                    then bop_typ
                  else type_error e "Error: bad bop vals types"
            end 
  | Uop (uop, exp) ->
      let val_typ, uop_typ = typ_of_unop uop in 
        if typecheck_exp c exp = val_typ 
          then uop_typ
        else type_error e "Error: bad unop type"

(* statements --------------------------------------------------------------- *)

(* Typecheck a statement 
   This function should implement the statment typechecking rules from oat.pdf.  

   Inputs:
    - tc: the type context
    - s: the statement node
    - to_ret: the desired return type (from the function declaration)

   Returns:
     - the new type context (which includes newly declared variables in scope
       after this statement)

     - A boolean indicating the return behavior of a statement:
        false:  might not return
        true: definitely returns 

        in the branching statements, the return behavior of the branching 
        statement is the conjunction of the return behavior of the two 
        branches: both both branches must definitely return in order for 
        the whole statement to definitely return.

        Intuitively: if one of the two branches of a conditional does not 
        contain a return statement, then the entire conditional statement might 
        not return.
  
        looping constructs never definitely return 

   Uses the type_error function to indicate a (useful!) error message if the
   statement is not type correct.  The exact wording of the error message is
   not important, but the fact that the error is raised, is important.  (Our
   tests also do not check the location information associated with the error.)

   - You will probably find it convenient to add a helper function that implements the 
     block typecheck rules.
*)
let rec typecheck_stmt (tc : Tctxt.t) (s:Ast.stmt node) (to_ret:ret_ty) : Tctxt.t * bool =
  begin match s.elt with 
    | Assn (exp1, exp2) ->
        let is_fun_name = 
          begin match exp1.elt with
            | Id id -> 
                begin match lookup_global_option id tc with
                  | Some (TRef (RFun (args_lst, RetVal ret_typ))) -> 
                      true && (typecheck_exp tc exp1 = (TRef (RFun (args_lst, RetVal ret_typ))))
                  | _ -> false
                end
            | _ -> false
          end in
            if is_fun_name
              then type_error s "Error: function assignment"
            else
              let exp1_typ = (typecheck_exp tc exp1) in 
                let exp2_typ = (typecheck_exp tc exp2) in 
                  let assn_typ_check = (subtype tc exp2_typ exp1_typ) in 
                    if assn_typ_check
                      then tc, false
                    else 
                      type_error s "Error: bad assignment types"
    | Decl (id, exp) ->
        begin match lookup_local_option id tc with
          | Some s -> type_error (no_loc s) "Error: decl: exp already exists"
          | None -> 
              let exp_typ = typecheck_exp tc exp in 
                add_local tc id exp_typ, false
        end
    | Ret exp_opt ->
          begin match exp_opt with 
            | None -> if to_ret = RetVoid
                        then tc, true
                      else type_error (no_loc s) "Error: bad void return type"
            | Some exp_typ ->
                let exp_typ_check = typecheck_exp tc exp_typ in 
                  begin match to_ret with 
                    | RetVoid -> type_error (no_loc s) "Error: bad type: got void ret type"
                    | RetVal typ -> if subtype tc exp_typ_check typ
                                      then tc, true
                                    else
                                      type_error (no_loc s) "Error: bad return type"
                  end
          end
    | SCall (exp, exp_lst) ->
          begin match typecheck_exp tc exp with 
            | TRef (RFun (fun_args_tys, RetVoid)) | TNullRef (RFun (fun_args_tys, RetVoid)) -> 
                let exp_args_tys = List.map (typecheck_exp tc) exp_lst in 
                  if List.length fun_args_tys = List.length exp_args_tys 
                    then
                      begin if List.for_all2 (subtype tc) exp_args_tys fun_args_tys
                              then tc, false
                            else
                              type_error (no_loc s) "Error: scall: bad arguments types"
                      end
                  else type_error (no_loc s) "Error: scall: bad arguments list"
                    
            | _ -> type_error (no_loc s) "Error: scall: bad fun call"
          end
    | If (exp, st_lst1, st_lst2) ->
            if typecheck_exp tc exp = TBool
              then
                let st_lst1_ctxt, st_lst1_bool = typecheck_block tc to_ret st_lst1 in 
                  let st_lst2_ctxt, st_lst2_bool = typecheck_block tc to_ret st_lst2 in 
                    st_lst2_ctxt, st_lst1_bool && st_lst2_bool
            else
              type_error exp "Error: bad type: condition not bool"
    | Cast (ret_typ, id, exp, st_lst1, st_lst2) ->
        begin match typecheck_exp tc exp with 
          | TNullRef exp_typ ->
              if subtype_ref tc exp_typ ret_typ
                then
                  let cast_ctxt = add_local tc id (TRef ret_typ) in 
                    let _, st_lst1_bool = typecheck_block cast_ctxt to_ret st_lst1 in 
                      let _, st_lst2_bool = typecheck_block cast_ctxt to_ret st_lst2 in 
                        tc, st_lst1_bool && st_lst2_bool
              else 
                type_error s "Error: bad cast type"
          | _ -> type_error s "Error: bad cast: not TNullRef"
        end
    | For (vdecl_lst, exp_opt, st_opt, st_lst) ->
        let loop_ctxt = List.fold_left (fun tctxt (id, exp) ->
                                          let exp_ctxt, bool_v =
                                            typecheck_stmt tc (no_loc (Decl (id, exp))) to_ret in
                                              exp_ctxt
                                       ) tc vdecl_lst in
          let exp_exists =
            begin match exp_opt with 
              | Some exp -> typecheck_exp loop_ctxt exp = TBool
              | None -> type_error s "Error: forloop: no condition"
            end in 
          let st_exists =
            begin match st_opt with 
              | Some st -> snd (typecheck_stmt loop_ctxt st to_ret)
              | None -> type_error s "Error: forloop: no increment"
            end in 
            let _ = typecheck_block loop_ctxt to_ret st_lst in 
              if exp_exists && (not st_exists)
                then tc, false
              else 
                type_error s "Error: for loop condition invalid or return in loop stmt"
    | While (exp, st_lst) ->
        if typecheck_exp tc exp = TBool
          then tc, false
        else
          type_error s "Error: bad condition type: not bool"
  end 

  and typecheck_block (tc: Tctxt.t) (to_ret : ret_ty) (blck: Ast.stmt node list): Tctxt.t * bool = 
        begin match blck with 
          | [stmt] -> typecheck_stmt tc stmt to_ret
          | hd :: tl -> 
              let stmt_ctxt, ret_bool = typecheck_stmt tc hd to_ret in 
              if ret_bool 
                then type_error (no_loc to_ret) "Error: premature return"
              else typecheck_block stmt_ctxt to_ret tl
          | [] -> tc, false
        end  
      



(* struct type declarations ------------------------------------------------- *)
(* Here is an example of how to implement the TYP_TDECLOK rule, which is 
   is needed elswhere in the type system.
 *)

(* Helper function to look for duplicate field names *)
let rec check_dups (fs : field list) =
  match fs with
  | [] -> false
  | h :: t -> (List.exists (fun x -> x.fieldName = h.fieldName) t) || check_dups t

let typecheck_tdecl (tc : Tctxt.t) (id : id) (fs : field list)  (l : 'a Ast.node) : unit =
  if check_dups fs
  then type_error l ("Repeated fields in " ^ id) 
  else List.iter (fun f -> typecheck_ty l tc f.ftyp) fs

(* function declarations ---------------------------------------------------- *)
(* typecheck a function declaration 
    - extends the local context with the types of the formal parameters to the 
      function
    - typechecks the body of the function (passing in the expected return type
    - checks that the function actually returns
*)
let typecheck_fdecl (tc : Tctxt.t) (f : Ast.fdecl) (l : 'a Ast.node) : unit =
  let fun_ctxt = List.fold_left (fun tctxt (typ, id) ->
                                   let new_ctxt = add_local tctxt id typ  in 
                                   new_ctxt
                                ) tc f.args in 
    let _, ret_bool = typecheck_block fun_ctxt f.frtyp f.body in 
      if ret_bool 
        then ()
      else type_error l "Error: function does not return"

(* creating the typchecking context ----------------------------------------- *)

(* The following functions correspond to the
   judgments that create the global typechecking context.

   create_struct_ctxt: - adds all the struct types to the struct 'S'
   context (checking to see that there are no duplicate fields

     H |-s prog ==> H'


   create_function_ctxt: - adds the the function identifiers and their
   types to the 'G' context (ensuring that there are no redeclared
   function identifiers)

     H ; G1 |-f prog ==> G2


   create_global_ctxt: - typechecks the global initializers and adds
   their identifiers to the 'G' global context

     H ; G1 |-g prog ==> G2    


   NOTE: global initializers may mention function identifiers as
   constants, but can mention only other global values that were declared earlier
*)

let create_struct_ctxt (p:Ast.prog) : Tctxt.t =
  List.fold_left (fun tctxt decl -> 
                    match decl with
                    | Gtdecl {elt = (id, field_lst) ; loc =_} -> 
                      ( 
                        if lookup_struct_option id tctxt <> None
                          then type_error (no_loc decl) "Error: struct already in context"
                        else 
                          if check_dups field_lst
                            then type_error (no_loc decl) "Error: duplicate fields"
                          else
                            add_struct tctxt id field_lst
                      )
                    | _ -> tctxt
                 ) empty p

let create_function_ctxt (tc:Tctxt.t) (p:Ast.prog) : Tctxt.t =
  let ctxt_builtin = List.fold_left (fun tctxt funs ->
                                       let arg_ret = snd funs in
                                       add_global tctxt (fst funs) (TRef (RFun (fst arg_ret, snd arg_ret)))
                                    ) tc builtins in
    List.fold_left (fun tctxt decl -> 
                      match decl with
                      | Gfdecl {elt={ frtyp=frtyp; fname=fname; args=args_lst; body=_ }; loc=_} -> 
                        ( 
                          if lookup_global_option fname tctxt <> None
                            then type_error (no_loc decl) "Error: global already exists"
                          else  
                            add_global tctxt fname (TRef (RFun (List.map fst args_lst, frtyp)))
                        )
                      | _ -> tctxt
                    ) ctxt_builtin p

let create_global_ctxt (tc:Tctxt.t) (p:Ast.prog) : Tctxt.t =
  List.fold_left (fun tctxt decl -> 
                    match decl with
                    | Gvdecl {elt={name = name; init = init}; loc=_} -> 
                      ( 
                        if lookup_global_option name tctxt <> None
                          then type_error (no_loc decl) "Error: global already in context"
                        else 
                          add_global tctxt name (typecheck_exp tc init)
                      )
                    | _ -> tctxt
                 ) tc p
  

(* This function implements the |- prog and the H ; G |- prog 
   rules of the oat.pdf specification.   
*)
let typecheck_program (p:Ast.prog) : unit =
  let sc = create_struct_ctxt p in
  let fc = create_function_ctxt sc p in
  let tc = create_global_ctxt fc p in
  List.iter (fun p ->
    match p with
    | Gfdecl ({elt=f} as l) -> typecheck_fdecl tc f l
    | Gtdecl ({elt=(id, fs)} as l) -> typecheck_tdecl tc id fs l 
    | _ -> ()) p
