open Ll
open Datastructures

(* The lattice of symbolic constants ---------------------------------------- *)
module SymConst =
  struct
    type t = NonConst           (* Uid may take on multiple values at runtime *)
           | Const of int64     (* Uid will always evaluate to const i64 or i1 *)
           | UndefConst         (* Uid is not defined at the point *)

    let compare (a:t) (b:t) =
      match a, b with
      | (Const i, Const j) -> Int64.compare i j
      | (NonConst, NonConst) | (UndefConst, UndefConst) -> 0
      | (NonConst, _) | (_, UndefConst) -> 1
      | (UndefConst, _) | (_, NonConst) -> -1

    let to_string : t -> string = function
      | NonConst -> "NonConst"
      | Const i -> Printf.sprintf "Const (%LdL)" i
      | UndefConst -> "UndefConst"

    
  end

(* The analysis computes, at each program point, which UIDs in scope will evaluate 
   to integer constants *)
type fact = SymConst.t UidM.t



(* flow function across Ll instructions ------------------------------------- *)
(* - Uid of a binop or icmp with const arguments is constant-out
   - Uid of a binop or icmp with an UndefConst argument is UndefConst-out
   - Uid of a binop or icmp with an NonConst argument is NonConst-out
   - Uid of stores and void calls are UndefConst-out
   - Uid of all other instructions are NonConst-out
 *)
let insn_flow (u,i:uid * insn) (d:fact) : fact =
  (* failwith "Constprop.insn_flow unimplemented" *)
  let propagate fun_of_insn op1 op2 =
    begin match op1, op2 with
      | Const c1, Const c2 -> 
          UidM.add u (SymConst.Const (fun_of_insn c1 c2)) d
      | Const c1, Id id2 -> 
          begin try 
          begin match UidM.find id2 d with 
            | UndefConst -> UidM.add u SymConst.UndefConst d
            | Const c2 -> UidM.add u (SymConst.Const (fun_of_insn c1 c2)) d
            | NonConst -> UidM.add u SymConst.NonConst d
          end
        with Not_found -> d end
      | Id id1, Const c2  -> 
          begin try
          begin match UidM.find id1 d with 
            | UndefConst -> UidM.add u SymConst.UndefConst d
            | Const c1 -> UidM.add u (SymConst.Const (fun_of_insn c1 c2)) d
            | NonConst -> UidM.add u SymConst.NonConst d
          end
        with Not_found -> d end
      | Id id1, Id id2 -> 
          begin try
          begin match UidM.find id1 d, UidM.find id2 d with
            | Const c1, Const c2 -> UidM.add u (SymConst.Const (fun_of_insn c1 c2)) d
            | UndefConst, _ | _, UndefConst -> UidM.add u SymConst.UndefConst d 
            | NonConst, _ | _, NonConst -> UidM.add u SymConst.NonConst d
          end
        with Not_found -> d end
      | _ -> UidM.add u SymConst.NonConst d
    end in

      begin match i with
        | Binop (bop, typ, op1, op2) ->
            let fun_of_bop (int1_v: int64) (int2_v: int64): int64 = 
              begin match bop with 
                | Sub -> Int64.sub int1_v int2_v
                | Mul -> Int64.mul int1_v int2_v
                | Add -> Int64.add int1_v int2_v
                | Shl -> Int64.shift_left int1_v (Int64.to_int int2_v)
                | Lshr -> Int64.shift_right_logical int1_v (Int64.to_int int2_v)
                | Ashr -> Int64.shift_right int1_v (Int64.to_int int2_v)
                | And -> Int64.logand int1_v int2_v
                | Xor -> Int64.logxor int1_v int2_v
                | Or -> Int64.logor int1_v int2_v
              end in
                propagate fun_of_bop op1 op2
        | Icmp (cnd, typ, op1, op2) ->
            let fun_of_cnd (int1_v:int64) (int2_v:int64): int64 = 
              let bool_v =
                begin match cnd with 
                  | Eq -> int1_v == int2_v
                  | Ne -> int1_v != int2_v
                  | Sle -> int1_v <= int2_v
                  | Slt -> int1_v < int2_v
                  | Sge -> int1_v >= int2_v
                  | Sgt -> int1_v > int2_v
                end in 
              if bool_v then 1L else 0L in
                propagate fun_of_cnd op1 op2
        | Store (_, _, _) | Call (Void, _, _) -> UidM.add u SymConst.UndefConst d
        | _ -> UidM.add u SymConst.NonConst d
      end

(* The flow function across terminators is trivial: they never change const info *)
let terminator_flow (t:terminator) (d:fact) : fact = d

(* module for instantiating the generic framework --------------------------- *)
module Fact =
  struct
    type t = fact
    let forwards = true

    let insn_flow = insn_flow
    let terminator_flow = terminator_flow
    
    let normalize : fact -> fact = 
      UidM.filter (fun _ v -> v != SymConst.UndefConst)

    let compare (d:fact) (e:fact) : int  = 
      UidM.compare SymConst.compare (normalize d) (normalize e)

    let to_string : fact -> string =
      UidM.to_string (fun _ v -> SymConst.to_string v)

    (* The constprop analysis should take the meet over predecessors to compute the
       flow into a node. You may find the UidM.merge function useful *)
    let combine (ds:fact list) : fact = 
      (* failwith "Constprop.Fact.combine unimplemented" *)
      let lub _key (symconst1: SymConst.t option) (symconst2: SymConst.t option) : SymConst.t option =
        begin match symconst1, symconst2 with
          | Some c1, Some c2 -> if c1 = c2 then Some c1 else Some SymConst.NonConst
          | _, Some SymConst.UndefConst | Some SymConst.UndefConst, _ -> Some SymConst.UndefConst
          | None, Some c | Some c, None -> Some c
          | None, None -> None
        end in
          normalize (List.fold_left (UidM.merge lub) UidM.empty (ds))
  end

(* instantiate the general framework ---------------------------------------- *)
module Graph = Cfg.AsGraph (Fact)
module Solver = Solver.Make (Fact) (Graph)

(* expose a top-level analysis operation ------------------------------------ *)
let analyze (g:Cfg.t) : Graph.t =
  (* the analysis starts with every node set to bottom (the map of every uid 
     in the function to UndefConst *)
  let init l = UidM.empty in

  (* the flow into the entry node should indicate that any parameter to the
     function is not a constant *)
  let cp_in = List.fold_right 
    (fun (u,_) -> UidM.add u SymConst.NonConst)
    g.Cfg.args UidM.empty 
  in
  let fg = Graph.of_cfg init cp_in g in
  Solver.solve fg


(* run constant propagation on a cfg given analysis results ----------------- *)
(* HINT: your cp_block implementation will probably rely on several helper 
   functions.                                                                 *)
let run (cg:Graph.t) (cfg:Cfg.t) : Cfg.t =
  let open SymConst in
  
  let cp_block (l: Ll.lbl) (cfg:Cfg.t) : Cfg.t =
    let b = Cfg.block cfg l in
    let cb = Graph.uid_out cg l in

      let constprop_op (op: Ll.operand) (f: Fact.t): Ll.operand = 
        begin match op with 
          | Id op_uid -> 
            begin
              try
                begin match UidM.find op_uid f with 
                  | Const c -> Const c
                  | _ -> op
                end
              with Not_found -> op
            end
          | _ -> op
        end in

      let constprop_block (cpb: uid -> Fact.t) (blck: Ll.block): Ll.block =
        let {insns = uid_insn_lst; term = (term_uid, block_term)} = blck in

          let new_insns = 
            List.fold_left (fun prev_insns (uid, insn) ->
                              let uid_fact = cpb uid in  
                                let new_insn =
                                  begin match insn with 
                                    | Icmp(cnd, typ, op1, op2) ->
                                        Icmp(cnd, typ, constprop_op op1 uid_fact, constprop_op op2 uid_fact)
                                    | Binop(bop, typ, op1, op2) ->
                                        Binop(bop, typ, constprop_op op1 uid_fact, constprop_op op2 uid_fact)
                                    | Store(typ, op1, op2) ->
                                        Store(typ, constprop_op op1 uid_fact, constprop_op op2 uid_fact)
                                    | _ -> insn
                                  end in 
                                prev_insns @ [(uid, new_insn)]
                            ) [] uid_insn_lst in

          let term_fact = cpb term_uid in  
            let new_term =
              begin match block_term with 
                | Cbr(op, lbl1, lbl2) -> Cbr(constprop_op op term_fact, lbl1, lbl2)
                | Ret(typ, op_opt) ->
                    begin match op_opt with 
                      | None -> block_term 
                      | Some op -> Ret(typ, Some (constprop_op op term_fact))
                    end
                | _ -> block_term
              end in
          {insns=new_insns; term=(term_uid, new_term)} in

            let const_propped_block = constprop_block cb b in 
              let add_new_block = LblM.add l const_propped_block cfg.blocks in 
              {blocks=add_new_block; preds=cfg.preds; ret_ty=cfg.ret_ty; args=cfg.args} in

            LblS.fold cp_block (Cfg.nodes cfg) cfg