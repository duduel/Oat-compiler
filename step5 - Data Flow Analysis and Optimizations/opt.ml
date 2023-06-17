(** Optimizer *)
open Ll

(*
  This file drives the optimization for the compilation. For the leaderboard,
  you may optionally implement additional optimizations by editing this file.

  NOTE: your additional optimizations should run only if !opt_level = 2. 

  That is, your additional optimizations should be enabled only when the
  flag -O2 is passed to main.native.
 *)

(* dead code elimination ---------------------------------------------------- *)
let dce (g:Cfg.t) : Cfg.t =
  let ag = Alias.analyze g in
  let lg = Liveness.analyze g in
  Dce.run lg ag g

(* constant propagation ----------------------------------------------------- *)
let cp (g:Cfg.t) : Cfg.t =
  let cg = Constprop.analyze g in
  Constprop.run cg g

(* "full" optimization: n rounds of (dce followed by constant) propagation -- *)
let rec pass n (g:Cfg.t) =
  if n <= 0 
  then g 
  else pass (n - 1) (g |> dce |> cp)

(* optimize an fdecl -------------------------------------------------------- *)
(* runs (two) passes of dce followed by constant propagation on the supplied 
   LL IR fdecl.                                                               *)
let opt_fdecl (gid,fdecl:Ll.gid * Ll.fdecl) : Ll.gid * Ll.fdecl =
  let g = pass 2 (Cfg.of_ast fdecl) in
  gid, Cfg.to_ast g

(* optimization level, set by the main compiler driver *)
let opt_level = ref 0

(* optimize each fdecl in the program *)
let optimize (p:Ll.prog) : Ll.prog = 
  if !opt_level = 2 then
    (* OPTIONAL TASK: implement additional optimizations *)
    failwith "No -O2 optimizations implemented! This is an optional task."
  else if !opt_level = 1 
  then begin 
    Platform.verb @@ Printf.sprintf "..optimizing";  
    { p with Ll.fdecls = List.map opt_fdecl p.Ll.fdecls }
  end
  else p

