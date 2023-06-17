
module MenhirBasics = struct
  
  exception Error
  
  let _eRR =
    fun _s ->
      raise Error
  
  type token = 
    | XOR
    | VOID
    | UID of (
# 63 "ll/llparser.mly"
       (string)
# 17 "ll/llparser.ml"
  )
    | TYPE
    | TO
    | SUB
    | STRING of (
# 64 "ll/llparser.mly"
       (string)
# 25 "ll/llparser.ml"
  )
    | STORE
    | STAR
    | SLT
    | SLE
    | SHL
    | SGT
    | SGE
    | RPAREN
    | RET
    | RBRACKET
    | RBRACE
    | OR
    | NULL
    | NE
    | MUL
    | LSHR
    | LPAREN
    | LOAD
    | LBRACKET
    | LBRACE
    | LBL of (
# 61 "ll/llparser.mly"
       (string)
# 50 "ll/llparser.ml"
  )
    | LABEL
    | INT of (
# 60 "ll/llparser.mly"
       (int)
# 56 "ll/llparser.ml"
  )
    | ICMP
    | I8
    | I64
    | I32
    | I1
    | GLOBAL
    | GID of (
# 62 "ll/llparser.mly"
       (string)
# 67 "ll/llparser.ml"
  )
    | GEP
    | EXTERNAL
    | EQUALS
    | EQ
    | EOF
    | ENTRY
    | DEFINE
    | DECLARE
    | CROSS
    | COMMA
    | COLON
    | CALL
    | BR
    | BITCAST
    | ASHR
    | AND
    | ALLOCA
    | ADD
  
end

include MenhirBasics

# 1 "ll/llparser.mly"
   open Ll
   open Llutil.Parsing


# 97 "ll/llparser.ml"

type ('s, 'r) _menhir_state = 
  | MenhirState005 : ('s _menhir_cell0_decls_rev _menhir_cell0_UID, _menhir_box_prog) _menhir_state
    (** State 005.
        Stack shape : decls_rev UID.
        Start symbol: prog. *)

  | MenhirState010 : (('s, _menhir_box_prog) _menhir_cell1_LBRACKET _menhir_cell0_INT, _menhir_box_prog) _menhir_state
    (** State 010.
        Stack shape : LBRACKET INT.
        Start symbol: prog. *)

  | MenhirState011 : (('s, _menhir_box_prog) _menhir_cell1_LBRACE, _menhir_box_prog) _menhir_state
    (** State 011.
        Stack shape : LBRACE.
        Start symbol: prog. *)

  | MenhirState016 : (('s, _menhir_box_prog) _menhir_cell1_ty_list_rev, _menhir_box_prog) _menhir_state
    (** State 016.
        Stack shape : ty_list_rev.
        Start symbol: prog. *)

  | MenhirState017 : ((('s, _menhir_box_prog) _menhir_cell1_ty_list_rev, _menhir_box_prog) _menhir_cell1_ty, _menhir_box_prog) _menhir_state
    (** State 017.
        Stack shape : ty_list_rev ty.
        Start symbol: prog. *)

  | MenhirState019 : ((('s, _menhir_box_prog) _menhir_cell1_ty, _menhir_box_prog) _menhir_cell1_LPAREN, _menhir_box_prog) _menhir_state
    (** State 019.
        Stack shape : ty LPAREN.
        Start symbol: prog. *)

  | MenhirState022 : (('s, _menhir_box_prog) _menhir_cell1_ty, _menhir_box_prog) _menhir_state
    (** State 022.
        Stack shape : ty.
        Start symbol: prog. *)

  | MenhirState026 : ((('s, _menhir_box_prog) _menhir_cell1_LBRACKET _menhir_cell0_INT, _menhir_box_prog) _menhir_cell1_ty, _menhir_box_prog) _menhir_state
    (** State 026.
        Stack shape : LBRACKET INT ty.
        Start symbol: prog. *)

  | MenhirState028 : (('s _menhir_cell0_decls_rev _menhir_cell0_UID, _menhir_box_prog) _menhir_cell1_ty, _menhir_box_prog) _menhir_state
    (** State 028.
        Stack shape : decls_rev UID ty.
        Start symbol: prog. *)

  | MenhirState031 : ('s _menhir_cell0_decls_rev _menhir_cell0_GID, _menhir_box_prog) _menhir_state
    (** State 031.
        Stack shape : decls_rev GID.
        Start symbol: prog. *)

  | MenhirState032 : (('s _menhir_cell0_decls_rev _menhir_cell0_GID, _menhir_box_prog) _menhir_cell1_ty, _menhir_box_prog) _menhir_state
    (** State 032.
        Stack shape : decls_rev GID ty.
        Start symbol: prog. *)

  | MenhirState035 : ((('s, _menhir_box_prog) _menhir_cell1_ty, _menhir_box_prog) _menhir_cell1_LBRACKET, _menhir_box_prog) _menhir_state
    (** State 035.
        Stack shape : ty LBRACKET.
        Start symbol: prog. *)

  | MenhirState036 : (('s, _menhir_box_prog) _menhir_cell1_ty, _menhir_box_prog) _menhir_state
    (** State 036.
        Stack shape : ty.
        Start symbol: prog. *)

  | MenhirState037 : ((('s, _menhir_box_prog) _menhir_cell1_ty, _menhir_box_prog) _menhir_cell1_LBRACE, _menhir_box_prog) _menhir_state
    (** State 037.
        Stack shape : ty LBRACE.
        Start symbol: prog. *)

  | MenhirState039 : (('s, _menhir_box_prog) _menhir_cell1_gdecl_list_rev, _menhir_box_prog) _menhir_state
    (** State 039.
        Stack shape : gdecl_list_rev.
        Start symbol: prog. *)

  | MenhirState040 : ((('s, _menhir_box_prog) _menhir_cell1_gdecl_list_rev, _menhir_box_prog) _menhir_cell1_ty, _menhir_box_prog) _menhir_state
    (** State 040.
        Stack shape : gdecl_list_rev ty.
        Start symbol: prog. *)

  | MenhirState044 : ((('s, _menhir_box_prog) _menhir_cell1_ty, _menhir_box_prog) _menhir_cell1_BITCAST, _menhir_box_prog) _menhir_state
    (** State 044.
        Stack shape : ty BITCAST.
        Start symbol: prog. *)

  | MenhirState045 : (((('s, _menhir_box_prog) _menhir_cell1_ty, _menhir_box_prog) _menhir_cell1_BITCAST, _menhir_box_prog) _menhir_cell1_ty, _menhir_box_prog) _menhir_state
    (** State 045.
        Stack shape : ty BITCAST ty.
        Start symbol: prog. *)

  | MenhirState047 : ((((('s, _menhir_box_prog) _menhir_cell1_ty, _menhir_box_prog) _menhir_cell1_BITCAST, _menhir_box_prog) _menhir_cell1_ty, _menhir_box_prog) _menhir_cell1_ginit, _menhir_box_prog) _menhir_state
    (** State 047.
        Stack shape : ty BITCAST ty ginit.
        Start symbol: prog. *)

  | MenhirState048 : (((((('s, _menhir_box_prog) _menhir_cell1_ty, _menhir_box_prog) _menhir_cell1_BITCAST, _menhir_box_prog) _menhir_cell1_ty, _menhir_box_prog) _menhir_cell1_ginit, _menhir_box_prog) _menhir_cell1_ty, _menhir_box_prog) _menhir_state
    (** State 048.
        Stack shape : ty BITCAST ty ginit ty.
        Start symbol: prog. *)

  | MenhirState058 : ('s _menhir_cell0_decls_rev _menhir_cell0_GID, _menhir_box_prog) _menhir_state
    (** State 058.
        Stack shape : decls_rev GID.
        Start symbol: prog. *)

  | MenhirState059 : (('s _menhir_cell0_decls_rev _menhir_cell0_GID, _menhir_box_prog) _menhir_cell1_ty, _menhir_box_prog) _menhir_state
    (** State 059.
        Stack shape : decls_rev GID ty.
        Start symbol: prog. *)

  | MenhirState060 : ('s _menhir_cell0_decls_rev, _menhir_box_prog) _menhir_state
    (** State 060.
        Stack shape : decls_rev.
        Start symbol: prog. *)

  | MenhirState061 : (('s _menhir_cell0_decls_rev, _menhir_box_prog) _menhir_cell1_ty, _menhir_box_prog) _menhir_state
    (** State 061.
        Stack shape : decls_rev ty.
        Start symbol: prog. *)

  | MenhirState063 : ((('s _menhir_cell0_decls_rev, _menhir_box_prog) _menhir_cell1_ty, _menhir_box_prog) _menhir_cell1_GID, _menhir_box_prog) _menhir_state
    (** State 063.
        Stack shape : decls_rev ty GID.
        Start symbol: prog. *)

  | MenhirState064 : (('s, _menhir_box_prog) _menhir_cell1_ty, _menhir_box_prog) _menhir_state
    (** State 064.
        Stack shape : ty.
        Start symbol: prog. *)

  | MenhirState067 : (((('s _menhir_cell0_decls_rev, _menhir_box_prog) _menhir_cell1_ty, _menhir_box_prog) _menhir_cell1_GID, _menhir_box_prog) _menhir_cell1_arg_list_rev, _menhir_box_prog) _menhir_state
    (** State 067.
        Stack shape : decls_rev ty GID arg_list_rev.
        Start symbol: prog. *)

  | MenhirState071 : (((('s _menhir_cell0_decls_rev, _menhir_box_prog) _menhir_cell1_ty, _menhir_box_prog) _menhir_cell1_GID, _menhir_box_prog) _menhir_cell1_arg_list, _menhir_box_prog) _menhir_state
    (** State 071.
        Stack shape : decls_rev ty GID arg_list.
        Start symbol: prog. *)

  | MenhirState080 : (('s, _menhir_box_prog) _menhir_cell1_UID, _menhir_box_prog) _menhir_state
    (** State 080.
        Stack shape : UID.
        Start symbol: prog. *)

  | MenhirState081 : ((('s, _menhir_box_prog) _menhir_cell1_UID, _menhir_box_prog) _menhir_cell1_ty, _menhir_box_prog) _menhir_state
    (** State 081.
        Stack shape : UID ty.
        Start symbol: prog. *)

  | MenhirState082 : (((('s, _menhir_box_prog) _menhir_cell1_UID, _menhir_box_prog) _menhir_cell1_ty, _menhir_box_prog) _menhir_cell1_COMMA, _menhir_box_prog) _menhir_state
    (** State 082.
        Stack shape : UID ty COMMA.
        Start symbol: prog. *)

  | MenhirState083 : ((((('s, _menhir_box_prog) _menhir_cell1_UID, _menhir_box_prog) _menhir_cell1_ty, _menhir_box_prog) _menhir_cell1_COMMA, _menhir_box_prog) _menhir_cell1_ty, _menhir_box_prog) _menhir_state
    (** State 083.
        Stack shape : UID ty COMMA ty.
        Start symbol: prog. *)

  | MenhirState096 : (('s, _menhir_box_prog) _menhir_cell1_UID _menhir_cell0_cnd, _menhir_box_prog) _menhir_state
    (** State 096.
        Stack shape : UID cnd.
        Start symbol: prog. *)

  | MenhirState097 : ((('s, _menhir_box_prog) _menhir_cell1_UID _menhir_cell0_cnd, _menhir_box_prog) _menhir_cell1_ty, _menhir_box_prog) _menhir_state
    (** State 097.
        Stack shape : UID cnd ty.
        Start symbol: prog. *)

  | MenhirState099 : (((('s, _menhir_box_prog) _menhir_cell1_UID _menhir_cell0_cnd, _menhir_box_prog) _menhir_cell1_ty, _menhir_box_prog) _menhir_cell1_operand, _menhir_box_prog) _menhir_state
    (** State 099.
        Stack shape : UID cnd ty operand.
        Start symbol: prog. *)

  | MenhirState101 : (('s, _menhir_box_prog) _menhir_cell1_UID, _menhir_box_prog) _menhir_state
    (** State 101.
        Stack shape : UID.
        Start symbol: prog. *)

  | MenhirState102 : ((('s, _menhir_box_prog) _menhir_cell1_UID, _menhir_box_prog) _menhir_cell1_ty, _menhir_box_prog) _menhir_state
    (** State 102.
        Stack shape : UID ty.
        Start symbol: prog. *)

  | MenhirState103 : (((('s, _menhir_box_prog) _menhir_cell1_UID, _menhir_box_prog) _menhir_cell1_ty, _menhir_box_prog) _menhir_cell1_COMMA, _menhir_box_prog) _menhir_state
    (** State 103.
        Stack shape : UID ty COMMA.
        Start symbol: prog. *)

  | MenhirState104 : ((((('s, _menhir_box_prog) _menhir_cell1_UID, _menhir_box_prog) _menhir_cell1_ty, _menhir_box_prog) _menhir_cell1_COMMA, _menhir_box_prog) _menhir_cell1_ty, _menhir_box_prog) _menhir_state
    (** State 104.
        Stack shape : UID ty COMMA ty.
        Start symbol: prog. *)

  | MenhirState107 : (((((('s, _menhir_box_prog) _menhir_cell1_UID, _menhir_box_prog) _menhir_cell1_ty, _menhir_box_prog) _menhir_cell1_COMMA, _menhir_box_prog) _menhir_cell1_ty, _menhir_box_prog) _menhir_cell1_operand, _menhir_box_prog) _menhir_state
    (** State 107.
        Stack shape : UID ty COMMA ty operand.
        Start symbol: prog. *)

  | MenhirState109 : (((((('s, _menhir_box_prog) _menhir_cell1_UID, _menhir_box_prog) _menhir_cell1_ty, _menhir_box_prog) _menhir_cell1_COMMA, _menhir_box_prog) _menhir_cell1_ty, _menhir_box_prog) _menhir_cell1_operand, _menhir_box_prog) _menhir_state
    (** State 109.
        Stack shape : UID ty COMMA ty operand.
        Start symbol: prog. *)

  | MenhirState113 : (((((('s, _menhir_box_prog) _menhir_cell1_UID, _menhir_box_prog) _menhir_cell1_ty, _menhir_box_prog) _menhir_cell1_COMMA, _menhir_box_prog) _menhir_cell1_ty, _menhir_box_prog) _menhir_cell1_operand _menhir_cell0_i_operand_list_rev, _menhir_box_prog) _menhir_state
    (** State 113.
        Stack shape : UID ty COMMA ty operand i_operand_list_rev.
        Start symbol: prog. *)

  | MenhirState115 : (((((('s, _menhir_box_prog) _menhir_cell1_UID, _menhir_box_prog) _menhir_cell1_ty, _menhir_box_prog) _menhir_cell1_COMMA, _menhir_box_prog) _menhir_cell1_ty, _menhir_box_prog) _menhir_cell1_operand _menhir_cell0_i_operand_list_rev, _menhir_box_prog) _menhir_state
    (** State 115.
        Stack shape : UID ty COMMA ty operand i_operand_list_rev.
        Start symbol: prog. *)

  | MenhirState118 : (('s, _menhir_box_prog) _menhir_cell1_UID, _menhir_box_prog) _menhir_state
    (** State 118.
        Stack shape : UID.
        Start symbol: prog. *)

  | MenhirState119 : ((('s, _menhir_box_prog) _menhir_cell1_UID, _menhir_box_prog) _menhir_cell1_ty, _menhir_box_prog) _menhir_state
    (** State 119.
        Stack shape : UID ty.
        Start symbol: prog. *)

  | MenhirState121 : (((('s, _menhir_box_prog) _menhir_cell1_UID, _menhir_box_prog) _menhir_cell1_ty, _menhir_box_prog) _menhir_cell1_operand, _menhir_box_prog) _menhir_state
    (** State 121.
        Stack shape : UID ty operand.
        Start symbol: prog. *)

  | MenhirState123 : (((('s, _menhir_box_prog) _menhir_cell1_ty, _menhir_box_prog) _menhir_cell1_operand, _menhir_box_prog) _menhir_cell1_ty_operand_list_rev, _menhir_box_prog) _menhir_state
    (** State 123.
        Stack shape : ty operand ty_operand_list_rev.
        Start symbol: prog. *)

  | MenhirState124 : ((((('s, _menhir_box_prog) _menhir_cell1_ty, _menhir_box_prog) _menhir_cell1_operand, _menhir_box_prog) _menhir_cell1_ty_operand_list_rev, _menhir_box_prog) _menhir_cell1_ty, _menhir_box_prog) _menhir_state
    (** State 124.
        Stack shape : ty operand ty_operand_list_rev ty.
        Start symbol: prog. *)

  | MenhirState128 : (((('s, _menhir_box_prog) _menhir_cell1_ty, _menhir_box_prog) _menhir_cell1_operand, _menhir_box_prog) _menhir_cell1_ty, _menhir_box_prog) _menhir_state
    (** State 128.
        Stack shape : ty operand ty.
        Start symbol: prog. *)

  | MenhirState130 : (('s, _menhir_box_prog) _menhir_cell1_UID, _menhir_box_prog) _menhir_state
    (** State 130.
        Stack shape : UID.
        Start symbol: prog. *)

  | MenhirState131 : ((('s, _menhir_box_prog) _menhir_cell1_UID, _menhir_box_prog) _menhir_cell1_ty, _menhir_box_prog) _menhir_state
    (** State 131.
        Stack shape : UID ty.
        Start symbol: prog. *)

  | MenhirState133 : (((('s, _menhir_box_prog) _menhir_cell1_UID, _menhir_box_prog) _menhir_cell1_ty, _menhir_box_prog) _menhir_cell1_operand, _menhir_box_prog) _menhir_state
    (** State 133.
        Stack shape : UID ty operand.
        Start symbol: prog. *)

  | MenhirState134 : ((((('s, _menhir_box_prog) _menhir_cell1_UID, _menhir_box_prog) _menhir_cell1_ty, _menhir_box_prog) _menhir_cell1_operand, _menhir_box_prog) _menhir_cell1_ty, _menhir_box_prog) _menhir_state
    (** State 134.
        Stack shape : UID ty operand ty.
        Start symbol: prog. *)

  | MenhirState137 : (('s, _menhir_box_prog) _menhir_cell1_UID, _menhir_box_prog) _menhir_state
    (** State 137.
        Stack shape : UID.
        Start symbol: prog. *)

  | MenhirState138 : ((('s, _menhir_box_prog) _menhir_cell1_UID, _menhir_box_prog) _menhir_cell1_ty, _menhir_box_prog) _menhir_state
    (** State 138.
        Stack shape : UID ty.
        Start symbol: prog. *)

  | MenhirState140 : (('s, _menhir_box_prog) _menhir_cell1_UID _menhir_cell0_bop, _menhir_box_prog) _menhir_state
    (** State 140.
        Stack shape : UID bop.
        Start symbol: prog. *)

  | MenhirState141 : ((('s, _menhir_box_prog) _menhir_cell1_UID _menhir_cell0_bop, _menhir_box_prog) _menhir_cell1_ty, _menhir_box_prog) _menhir_state
    (** State 141.
        Stack shape : UID bop ty.
        Start symbol: prog. *)

  | MenhirState143 : (((('s, _menhir_box_prog) _menhir_cell1_UID _menhir_cell0_bop, _menhir_box_prog) _menhir_cell1_ty, _menhir_box_prog) _menhir_cell1_operand, _menhir_box_prog) _menhir_state
    (** State 143.
        Stack shape : UID bop ty operand.
        Start symbol: prog. *)

  | MenhirState145 : (('s, _menhir_box_prog) _menhir_cell1_STORE, _menhir_box_prog) _menhir_state
    (** State 145.
        Stack shape : STORE.
        Start symbol: prog. *)

  | MenhirState146 : ((('s, _menhir_box_prog) _menhir_cell1_STORE, _menhir_box_prog) _menhir_cell1_ty, _menhir_box_prog) _menhir_state
    (** State 146.
        Stack shape : STORE ty.
        Start symbol: prog. *)

  | MenhirState148 : (((('s, _menhir_box_prog) _menhir_cell1_STORE, _menhir_box_prog) _menhir_cell1_ty, _menhir_box_prog) _menhir_cell1_operand, _menhir_box_prog) _menhir_state
    (** State 148.
        Stack shape : STORE ty operand.
        Start symbol: prog. *)

  | MenhirState149 : ((((('s, _menhir_box_prog) _menhir_cell1_STORE, _menhir_box_prog) _menhir_cell1_ty, _menhir_box_prog) _menhir_cell1_operand, _menhir_box_prog) _menhir_cell1_ty, _menhir_box_prog) _menhir_state
    (** State 149.
        Stack shape : STORE ty operand ty.
        Start symbol: prog. *)

  | MenhirState152 : ((((('s _menhir_cell0_decls_rev, _menhir_box_prog) _menhir_cell1_ty, _menhir_box_prog) _menhir_cell1_GID, _menhir_box_prog) _menhir_cell1_arg_list, _menhir_box_prog) _menhir_cell1_ENTRY, _menhir_box_prog) _menhir_state
    (** State 152.
        Stack shape : decls_rev ty GID arg_list ENTRY.
        Start symbol: prog. *)

  | MenhirState153 : (('s, _menhir_box_prog) _menhir_cell1_CALL, _menhir_box_prog) _menhir_state
    (** State 153.
        Stack shape : CALL.
        Start symbol: prog. *)

  | MenhirState154 : ((('s, _menhir_box_prog) _menhir_cell1_CALL, _menhir_box_prog) _menhir_cell1_ty, _menhir_box_prog) _menhir_state
    (** State 154.
        Stack shape : CALL ty.
        Start symbol: prog. *)

  | MenhirState156 : (((('s, _menhir_box_prog) _menhir_cell1_CALL, _menhir_box_prog) _menhir_cell1_ty, _menhir_box_prog) _menhir_cell1_operand, _menhir_box_prog) _menhir_state
    (** State 156.
        Stack shape : CALL ty operand.
        Start symbol: prog. *)

  | MenhirState161 : (('s, _menhir_box_prog) _menhir_cell1_insn_list, _menhir_box_prog) _menhir_state
    (** State 161.
        Stack shape : insn_list.
        Start symbol: prog. *)

  | MenhirState162 : ((('s, _menhir_box_prog) _menhir_cell1_insn_list, _menhir_box_prog) _menhir_cell1_ty, _menhir_box_prog) _menhir_state
    (** State 162.
        Stack shape : insn_list ty.
        Start symbol: prog. *)

  | MenhirState167 : (('s, _menhir_box_prog) _menhir_cell1_insn_list, _menhir_box_prog) _menhir_state
    (** State 167.
        Stack shape : insn_list.
        Start symbol: prog. *)

  | MenhirState176 : (('s, _menhir_box_prog) _menhir_cell1_insn, _menhir_box_prog) _menhir_state
    (** State 176.
        Stack shape : insn.
        Start symbol: prog. *)

  | MenhirState182 : ((((('s _menhir_cell0_decls_rev, _menhir_box_prog) _menhir_cell1_ty, _menhir_box_prog) _menhir_cell1_GID, _menhir_box_prog) _menhir_cell1_arg_list, _menhir_box_prog) _menhir_cell1_entry_block _menhir_cell0_block_list_rev _menhir_cell0_LBL, _menhir_box_prog) _menhir_state
    (** State 182.
        Stack shape : decls_rev ty GID arg_list entry_block block_list_rev LBL.
        Start symbol: prog. *)

  | MenhirState188 : ('s _menhir_cell0_decls_rev, _menhir_box_prog) _menhir_state
    (** State 188.
        Stack shape : decls_rev.
        Start symbol: prog. *)

  | MenhirState189 : (('s _menhir_cell0_decls_rev, _menhir_box_prog) _menhir_cell1_ty, _menhir_box_prog) _menhir_state
    (** State 189.
        Stack shape : decls_rev ty.
        Start symbol: prog. *)

  | MenhirState191 : ((('s _menhir_cell0_decls_rev, _menhir_box_prog) _menhir_cell1_ty, _menhir_box_prog) _menhir_cell1_GID, _menhir_box_prog) _menhir_state
    (** State 191.
        Stack shape : decls_rev ty GID.
        Start symbol: prog. *)

  | MenhirState192 : (('s, _menhir_box_prog) _menhir_cell1_ty, _menhir_box_prog) _menhir_state
    (** State 192.
        Stack shape : ty.
        Start symbol: prog. *)

  | MenhirState193 : ((('s, _menhir_box_prog) _menhir_cell1_ty, _menhir_box_prog) _menhir_cell1_COMMA, _menhir_box_prog) _menhir_state
    (** State 193.
        Stack shape : ty COMMA.
        Start symbol: prog. *)


and ('s, 'r) _menhir_cell1_arg_list = 
  | MenhirCell1_arg_list of 's * ('s, 'r) _menhir_state * ((Ll.ty * Ll.uid) list)

and ('s, 'r) _menhir_cell1_arg_list_rev = 
  | MenhirCell1_arg_list_rev of 's * ('s, 'r) _menhir_state * ((Ll.ty * Ll.uid) list)

and 's _menhir_cell0_block_list_rev = 
  | MenhirCell0_block_list_rev of 's * ((Ll.lbl * Ll.block) list)

and 's _menhir_cell0_bop = 
  | MenhirCell0_bop of 's * (Ll.bop)

and 's _menhir_cell0_cnd = 
  | MenhirCell0_cnd of 's * (Ll.cnd)

and 's _menhir_cell0_decls_rev = 
  | MenhirCell0_decls_rev of 's * (Ll.prog)

and ('s, 'r) _menhir_cell1_entry_block = 
  | MenhirCell1_entry_block of 's * ('s, 'r) _menhir_state * (Ll.block)

and ('s, 'r) _menhir_cell1_gdecl_list_rev = 
  | MenhirCell1_gdecl_list_rev of 's * ('s, 'r) _menhir_state * ((Ll.ty * Ll.ginit) list)

and ('s, 'r) _menhir_cell1_ginit = 
  | MenhirCell1_ginit of 's * ('s, 'r) _menhir_state * (Ll.ginit)

and 's _menhir_cell0_i_operand_list_rev = 
  | MenhirCell0_i_operand_list_rev of 's * (Ll.operand list)

and ('s, 'r) _menhir_cell1_insn = 
  | MenhirCell1_insn of 's * ('s, 'r) _menhir_state * (Ll.uid * Ll.insn)

and ('s, 'r) _menhir_cell1_insn_list = 
  | MenhirCell1_insn_list of 's * ('s, 'r) _menhir_state * ((Ll.uid * Ll.insn) list)

and ('s, 'r) _menhir_cell1_operand = 
  | MenhirCell1_operand of 's * ('s, 'r) _menhir_state * (Ll.operand)

and ('s, 'r) _menhir_cell1_ty = 
  | MenhirCell1_ty of 's * ('s, 'r) _menhir_state * (Ll.ty)

and ('s, 'r) _menhir_cell1_ty_list_rev = 
  | MenhirCell1_ty_list_rev of 's * ('s, 'r) _menhir_state * (Ll.ty list)

and ('s, 'r) _menhir_cell1_ty_operand_list_rev = 
  | MenhirCell1_ty_operand_list_rev of 's * ('s, 'r) _menhir_state * ((Ll.ty * Ll.operand) list)

and ('s, 'r) _menhir_cell1_BITCAST = 
  | MenhirCell1_BITCAST of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_CALL = 
  | MenhirCell1_CALL of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_COMMA = 
  | MenhirCell1_COMMA of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_ENTRY = 
  | MenhirCell1_ENTRY of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_GID = 
  | MenhirCell1_GID of 's * ('s, 'r) _menhir_state * (
# 62 "ll/llparser.mly"
       (string)
# 545 "ll/llparser.ml"
)

and 's _menhir_cell0_GID = 
  | MenhirCell0_GID of 's * (
# 62 "ll/llparser.mly"
       (string)
# 552 "ll/llparser.ml"
)

and 's _menhir_cell0_INT = 
  | MenhirCell0_INT of 's * (
# 60 "ll/llparser.mly"
       (int)
# 559 "ll/llparser.ml"
)

and 's _menhir_cell0_LBL = 
  | MenhirCell0_LBL of 's * (
# 61 "ll/llparser.mly"
       (string)
# 566 "ll/llparser.ml"
)

and ('s, 'r) _menhir_cell1_LBRACE = 
  | MenhirCell1_LBRACE of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_LBRACKET = 
  | MenhirCell1_LBRACKET of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_LPAREN = 
  | MenhirCell1_LPAREN of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_STORE = 
  | MenhirCell1_STORE of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_UID = 
  | MenhirCell1_UID of 's * ('s, 'r) _menhir_state * (
# 63 "ll/llparser.mly"
       (string)
# 585 "ll/llparser.ml"
)

and 's _menhir_cell0_UID = 
  | MenhirCell0_UID of 's * (
# 63 "ll/llparser.mly"
       (string)
# 592 "ll/llparser.ml"
)

and _menhir_box_prog = 
  | MenhirBox_prog of (Ll.prog) [@@unboxed]

let _menhir_action_01 =
  fun t u ->
    (
# 147 "ll/llparser.mly"
               ( (t,u) )
# 603 "ll/llparser.ml"
     : (Ll.ty * Ll.uid))

let _menhir_action_02 =
  fun a ->
    (
# 159 "ll/llparser.mly"
    ( List.rev a )
# 611 "ll/llparser.ml"
     : ((Ll.ty * Ll.uid) list))

let _menhir_action_03 =
  fun () ->
    (
# 151 "ll/llparser.mly"
    ( [] )
# 619 "ll/llparser.ml"
     : ((Ll.ty * Ll.uid) list))

let _menhir_action_04 =
  fun a ->
    (
# 153 "ll/llparser.mly"
    ( [a] )
# 627 "ll/llparser.ml"
     : ((Ll.ty * Ll.uid) list))

let _menhir_action_05 =
  fun a args ->
    (
# 155 "ll/llparser.mly"
    ( a::args )
# 635 "ll/llparser.ml"
     : ((Ll.ty * Ll.uid) list))

let _menhir_action_06 =
  fun is t ->
    (
# 211 "ll/llparser.mly"
    ( { insns = is; term=(gensym "tmn", t) }  )
# 643 "ll/llparser.ml"
     : (Ll.block))

let _menhir_action_07 =
  fun bs ->
    (
# 221 "ll/llparser.mly"
    ( List.rev bs )
# 651 "ll/llparser.ml"
     : ((Ll.lbl * Ll.block) list))

let _menhir_action_08 =
  fun () ->
    (
# 215 "ll/llparser.mly"
    ( [] )
# 659 "ll/llparser.ml"
     : ((Ll.lbl * Ll.block) list))

let _menhir_action_09 =
  fun b bs l ->
    (
# 217 "ll/llparser.mly"
    ( (l,b) :: bs )
# 667 "ll/llparser.ml"
     : ((Ll.lbl * Ll.block) list))

let _menhir_action_10 =
  fun () ->
    (
# 230 "ll/llparser.mly"
       ( Or )
# 675 "ll/llparser.ml"
     : (Ll.bop))

let _menhir_action_11 =
  fun () ->
    (
# 231 "ll/llparser.mly"
        ( Add )
# 683 "ll/llparser.ml"
     : (Ll.bop))

let _menhir_action_12 =
  fun () ->
    (
# 232 "ll/llparser.mly"
        ( Sub )
# 691 "ll/llparser.ml"
     : (Ll.bop))

let _menhir_action_13 =
  fun () ->
    (
# 233 "ll/llparser.mly"
        ( Mul )
# 699 "ll/llparser.ml"
     : (Ll.bop))

let _menhir_action_14 =
  fun () ->
    (
# 234 "ll/llparser.mly"
        ( Shl )
# 707 "ll/llparser.ml"
     : (Ll.bop))

let _menhir_action_15 =
  fun () ->
    (
# 235 "ll/llparser.mly"
        ( Xor )
# 715 "ll/llparser.ml"
     : (Ll.bop))

let _menhir_action_16 =
  fun () ->
    (
# 236 "ll/llparser.mly"
        ( And )
# 723 "ll/llparser.ml"
     : (Ll.bop))

let _menhir_action_17 =
  fun () ->
    (
# 237 "ll/llparser.mly"
         ( Lshr )
# 731 "ll/llparser.ml"
     : (Ll.bop))

let _menhir_action_18 =
  fun () ->
    (
# 238 "ll/llparser.mly"
         ( Ashr )
# 739 "ll/llparser.ml"
     : (Ll.bop))

let _menhir_action_19 =
  fun () ->
    (
# 241 "ll/llparser.mly"
       ( Eq )
# 747 "ll/llparser.ml"
     : (Ll.cnd))

let _menhir_action_20 =
  fun () ->
    (
# 242 "ll/llparser.mly"
       ( Ne )
# 755 "ll/llparser.ml"
     : (Ll.cnd))

let _menhir_action_21 =
  fun () ->
    (
# 243 "ll/llparser.mly"
        ( Slt )
# 763 "ll/llparser.ml"
     : (Ll.cnd))

let _menhir_action_22 =
  fun () ->
    (
# 244 "ll/llparser.mly"
        ( Sle )
# 771 "ll/llparser.ml"
     : (Ll.cnd))

let _menhir_action_23 =
  fun () ->
    (
# 245 "ll/llparser.mly"
        ( Sgt )
# 779 "ll/llparser.ml"
     : (Ll.cnd))

let _menhir_action_24 =
  fun () ->
    (
# 246 "ll/llparser.mly"
        ( Sge )
# 787 "ll/llparser.ml"
     : (Ll.cnd))

let _menhir_action_25 =
  fun ds ->
    (
# 75 "ll/llparser.mly"
    ( { tdecls = List.rev ds.tdecls
      ; gdecls = List.rev ds.gdecls
      ; fdecls = List.rev ds.fdecls
      ; edecls = List.rev ds.edecls
    } )
# 799 "ll/llparser.ml"
     : (Ll.prog))

let _menhir_action_26 =
  fun () ->
    (
# 83 "ll/llparser.mly"
    ( { tdecls = [] ; gdecls = [] ; fdecls = [] ; edecls = [] } )
# 807 "ll/llparser.ml"
     : (Ll.prog))

let _menhir_action_27 =
  fun ds f ->
    (
# 85 "ll/llparser.mly"
    ( { ds with fdecls = f :: ds.fdecls }  )
# 815 "ll/llparser.ml"
     : (Ll.prog))

let _menhir_action_28 =
  fun ds g ->
    (
# 87 "ll/llparser.mly"
    ( { ds with gdecls = g :: ds.gdecls }  )
# 823 "ll/llparser.ml"
     : (Ll.prog))

let _menhir_action_29 =
  fun ds t ->
    (
# 89 "ll/llparser.mly"
    ( { ds with tdecls = t :: ds.tdecls }  )
# 831 "ll/llparser.ml"
     : (Ll.prog))

let _menhir_action_30 =
  fun ds e ->
    (
# 91 "ll/llparser.mly"
    ( { ds with edecls = e :: ds.edecls }  )
# 839 "ll/llparser.ml"
     : (Ll.prog))

let _menhir_action_31 =
  fun g rt xs ->
    let ts = 
# 229 "<standard.mly>"
    ( xs )
# 847 "ll/llparser.ml"
     in
    (
# 112 "ll/llparser.mly"
    ( (g, Fun (ts,rt)) )
# 852 "ll/llparser.ml"
     : (Ll.gid * Ll.ty))

let _menhir_action_32 =
  fun g t ->
    (
# 114 "ll/llparser.mly"
    ( (g, t) )
# 860 "ll/llparser.ml"
     : (Ll.gid * Ll.ty))

let _menhir_action_33 =
  fun b ->
    (
# 225 "ll/llparser.mly"
    ( b )
# 868 "ll/llparser.ml"
     : (Ll.block))

let _menhir_action_34 =
  fun b ->
    (
# 227 "ll/llparser.mly"
    ( b )
# 876 "ll/llparser.ml"
     : (Ll.block))

let _menhir_action_35 =
  fun a bs eb l t ->
    (
# 96 "ll/llparser.mly"
    ( (l, { f_ty = (List.map fst a, t)
          ; f_param = List.map snd a
          ; f_cfg = (eb, bs)
          }
    ) )
# 888 "ll/llparser.ml"
     : (Ll.gid * Ll.fdecl))

let _menhir_action_36 =
  fun g gi t ->
    (
# 104 "ll/llparser.mly"
    ( (g, (t,gi)) )
# 896 "ll/llparser.ml"
     : (Ll.gid * Ll.gdecl))

let _menhir_action_37 =
  fun gs ->
    (
# 282 "ll/llparser.mly"
    ( List.rev gs )
# 904 "ll/llparser.ml"
     : ((Ll.ty * Ll.ginit) list))

let _menhir_action_38 =
  fun () ->
    (
# 274 "ll/llparser.mly"
    ( [] )
# 912 "ll/llparser.ml"
     : ((Ll.ty * Ll.ginit) list))

let _menhir_action_39 =
  fun g t ->
    (
# 276 "ll/llparser.mly"
    ( [(t,g)] )
# 920 "ll/llparser.ml"
     : ((Ll.ty * Ll.ginit) list))

let _menhir_action_40 =
  fun g gs t ->
    (
# 278 "ll/llparser.mly"
    ( (t,g)::gs )
# 928 "ll/llparser.ml"
     : ((Ll.ty * Ll.ginit) list))

let _menhir_action_41 =
  fun () ->
    (
# 286 "ll/llparser.mly"
    ( GNull )
# 936 "ll/llparser.ml"
     : (Ll.ginit))

let _menhir_action_42 =
  fun g ->
    (
# 288 "ll/llparser.mly"
    ( GGid g )
# 944 "ll/llparser.ml"
     : (Ll.ginit))

let _menhir_action_43 =
  fun i ->
    (
# 290 "ll/llparser.mly"
    ( GInt (Int64.of_int i) )
# 952 "ll/llparser.ml"
     : (Ll.ginit))

let _menhir_action_44 =
  fun s ->
    (
# 292 "ll/llparser.mly"
    ( GString s )
# 960 "ll/llparser.ml"
     : (Ll.ginit))

let _menhir_action_45 =
  fun gs ->
    (
# 294 "ll/llparser.mly"
    ( GArray gs )
# 968 "ll/llparser.ml"
     : (Ll.ginit))

let _menhir_action_46 =
  fun gs ->
    (
# 296 "ll/llparser.mly"
    ( GStruct gs )
# 976 "ll/llparser.ml"
     : (Ll.ginit))

let _menhir_action_47 =
  fun g t1 t2 ->
    (
# 298 "ll/llparser.mly"
    ( GBitcast (t1, g, t2) )
# 984 "ll/llparser.ml"
     : (Ll.ginit))

let _menhir_action_48 =
  fun os ->
    (
# 197 "ll/llparser.mly"
    ( List.rev os )
# 992 "ll/llparser.ml"
     : (Ll.operand list))

let _menhir_action_49 =
  fun () ->
    (
# 185 "ll/llparser.mly"
    ( [] )
# 1000 "ll/llparser.ml"
     : (Ll.operand list))

let _menhir_action_50 =
  fun o ->
    (
# 187 "ll/llparser.mly"
      ( [o] )
# 1008 "ll/llparser.ml"
     : (Ll.operand list))

let _menhir_action_51 =
  fun o ->
    (
# 189 "ll/llparser.mly"
    ( [o] )
# 1016 "ll/llparser.ml"
     : (Ll.operand list))

let _menhir_action_52 =
  fun o os ->
    (
# 191 "ll/llparser.mly"
    ( o::os )
# 1024 "ll/llparser.ml"
     : (Ll.operand list))

let _menhir_action_53 =
  fun o os ->
    (
# 193 "ll/llparser.mly"
    ( o::os )
# 1032 "ll/llparser.ml"
     : (Ll.operand list))

let _menhir_action_54 =
  fun b o1 o2 t u ->
    (
# 250 "ll/llparser.mly"
    ( (u, Binop (b,t,o1,o2)) )
# 1040 "ll/llparser.ml"
     : (Ll.uid * Ll.insn))

let _menhir_action_55 =
  fun t u ->
    (
# 252 "ll/llparser.mly"
    ( (u, Alloca t) )
# 1048 "ll/llparser.ml"
     : (Ll.uid * Ll.insn))

let _menhir_action_56 =
  fun o t u ->
    (
# 254 "ll/llparser.mly"
    ( (u, Load (t,o)) )
# 1056 "ll/llparser.ml"
     : (Ll.uid * Ll.insn))

let _menhir_action_57 =
  fun o1 o2 t1 t2 ->
    (
# 256 "ll/llparser.mly"
    ( (gensym "store", Store (t1,o1,o2)) )
# 1064 "ll/llparser.ml"
     : (Ll.uid * Ll.insn))

let _menhir_action_58 =
  fun c o1 o2 t u ->
    (
# 258 "ll/llparser.mly"
    ( (u, Icmp (c,t,o1,o2)) )
# 1072 "ll/llparser.ml"
     : (Ll.uid * Ll.insn))

let _menhir_action_59 =
  fun args o t ->
    (
# 260 "ll/llparser.mly"
    ( (gensym "call", Call (t, o, args)) )
# 1080 "ll/llparser.ml"
     : (Ll.uid * Ll.insn))

let _menhir_action_60 =
  fun args o t u ->
    (
# 262 "ll/llparser.mly"
    ( (u, Call (t, o, args)) )
# 1088 "ll/llparser.ml"
     : (Ll.uid * Ll.insn))

let _menhir_action_61 =
  fun o t1 t2 u ->
    (
# 264 "ll/llparser.mly"
    ( (u, Bitcast (t1,o,t2)) )
# 1096 "ll/llparser.ml"
     : (Ll.uid * Ll.insn))

let _menhir_action_62 =
  fun o os t u ->
    (
# 266 "ll/llparser.mly"
    ( (u, Gep (t,o,os)) )
# 1104 "ll/llparser.ml"
     : (Ll.uid * Ll.insn))

let _menhir_action_63 =
  fun is ->
    (
# 270 "ll/llparser.mly"
    ( is )
# 1112 "ll/llparser.ml"
     : ((Ll.uid * Ll.insn) list))

let _menhir_action_64 =
  fun () ->
    (
# 208 "<standard.mly>"
    ( [] )
# 1120 "ll/llparser.ml"
     : ((Ll.uid * Ll.insn) list))

let _menhir_action_65 =
  fun x xs ->
    (
# 210 "<standard.mly>"
    ( x :: xs )
# 1128 "ll/llparser.ml"
     : ((Ll.uid * Ll.insn) list))

let _menhir_action_66 =
  fun () ->
    (
# 139 "<standard.mly>"
    ( [] )
# 1136 "ll/llparser.ml"
     : (Ll.ty list))

let _menhir_action_67 =
  fun x ->
    (
# 141 "<standard.mly>"
    ( x )
# 1144 "ll/llparser.ml"
     : (Ll.ty list))

let _menhir_action_68 =
  fun () ->
    (
# 117 "ll/llparser.mly"
         ( Void )
# 1152 "ll/llparser.ml"
     : (Ll.ty))

let _menhir_action_69 =
  fun () ->
    (
# 118 "ll/llparser.mly"
       ( I1 )
# 1160 "ll/llparser.ml"
     : (Ll.ty))

let _menhir_action_70 =
  fun () ->
    (
# 119 "ll/llparser.mly"
       ( I8 )
# 1168 "ll/llparser.ml"
     : (Ll.ty))

let _menhir_action_71 =
  fun () ->
    (
# 120 "ll/llparser.mly"
        ( I64 )
# 1176 "ll/llparser.ml"
     : (Ll.ty))

let _menhir_action_72 =
  fun ts ->
    (
# 122 "ll/llparser.mly"
    ( Struct ts )
# 1184 "ll/llparser.ml"
     : (Ll.ty))

let _menhir_action_73 =
  fun i t ->
    (
# 124 "ll/llparser.mly"
    ( Array (i,t) )
# 1192 "ll/llparser.ml"
     : (Ll.ty))

let _menhir_action_74 =
  fun rt ts ->
    (
# 126 "ll/llparser.mly"
    ( Fun (ts, rt) )
# 1200 "ll/llparser.ml"
     : (Ll.ty))

let _menhir_action_75 =
  fun t ->
    (
# 128 "ll/llparser.mly"
    ( Namedt t )
# 1208 "ll/llparser.ml"
     : (Ll.ty))

let _menhir_action_76 =
  fun () ->
    (
# 163 "ll/llparser.mly"
    ( Null )
# 1216 "ll/llparser.ml"
     : (Ll.operand))

let _menhir_action_77 =
  fun i ->
    (
# 165 "ll/llparser.mly"
    ( Const (Int64.of_int i) )
# 1224 "ll/llparser.ml"
     : (Ll.operand))

let _menhir_action_78 =
  fun g ->
    (
# 167 "ll/llparser.mly"
    ( Gid g )
# 1232 "ll/llparser.ml"
     : (Ll.operand))

let _menhir_action_79 =
  fun u ->
    (
# 169 "ll/llparser.mly"
    ( Id u )
# 1240 "ll/llparser.ml"
     : (Ll.operand))

let _menhir_action_80 =
  fun ds ->
    (
# 71 "ll/llparser.mly"
    ( ds )
# 1248 "ll/llparser.ml"
     : (Ll.prog))

let _menhir_action_81 =
  fun x ->
    (
# 238 "<standard.mly>"
    ( [ x ] )
# 1256 "ll/llparser.ml"
     : (Ll.ty list))

let _menhir_action_82 =
  fun x xs ->
    (
# 240 "<standard.mly>"
    ( x :: xs )
# 1264 "ll/llparser.ml"
     : (Ll.ty list))

let _menhir_action_83 =
  fun t tid ->
    (
# 108 "ll/llparser.mly"
    ( (tid, t) )
# 1272 "ll/llparser.ml"
     : (Ll.tid * Ll.ty))

let _menhir_action_84 =
  fun o t ->
    (
# 201 "ll/llparser.mly"
    ( Ret (t, Some o) )
# 1280 "ll/llparser.ml"
     : (Ll.terminator))

let _menhir_action_85 =
  fun t ->
    (
# 203 "ll/llparser.mly"
    ( Ret (t, None) )
# 1288 "ll/llparser.ml"
     : (Ll.terminator))

let _menhir_action_86 =
  fun l ->
    (
# 205 "ll/llparser.mly"
    ( Br l )
# 1296 "ll/llparser.ml"
     : (Ll.terminator))

let _menhir_action_87 =
  fun l1 l2 o ->
    (
# 207 "ll/llparser.mly"
    ( Cbr (o,l1,l2) )
# 1304 "ll/llparser.ml"
     : (Ll.terminator))

let _menhir_action_88 =
  fun t ->
    (
# 132 "ll/llparser.mly"
    ( Ptr t )
# 1312 "ll/llparser.ml"
     : (Ll.ty))

let _menhir_action_89 =
  fun t ->
    (
# 134 "ll/llparser.mly"
    ( t )
# 1320 "ll/llparser.ml"
     : (Ll.ty))

let _menhir_action_90 =
  fun ts ->
    (
# 144 "ll/llparser.mly"
    ( List.rev ts )
# 1328 "ll/llparser.ml"
     : (Ll.ty list))

let _menhir_action_91 =
  fun t ->
    (
# 138 "ll/llparser.mly"
    ( [t] )
# 1336 "ll/llparser.ml"
     : (Ll.ty list))

let _menhir_action_92 =
  fun t ts ->
    (
# 140 "ll/llparser.mly"
    ( t::ts )
# 1344 "ll/llparser.ml"
     : (Ll.ty list))

let _menhir_action_93 =
  fun tos ->
    (
# 181 "ll/llparser.mly"
    ( List.rev tos )
# 1352 "ll/llparser.ml"
     : ((Ll.ty * Ll.operand) list))

let _menhir_action_94 =
  fun () ->
    (
# 173 "ll/llparser.mly"
    ( [] )
# 1360 "ll/llparser.ml"
     : ((Ll.ty * Ll.operand) list))

let _menhir_action_95 =
  fun o t ->
    (
# 175 "ll/llparser.mly"
    ( [(t,o)] )
# 1368 "ll/llparser.ml"
     : ((Ll.ty * Ll.operand) list))

let _menhir_action_96 =
  fun o t tos ->
    (
# 177 "ll/llparser.mly"
    ( (t,o)::tos )
# 1376 "ll/llparser.ml"
     : ((Ll.ty * Ll.operand) list))

let _menhir_print_token : token -> string =
  fun _tok ->
    match _tok with
    | ADD ->
        "ADD"
    | ALLOCA ->
        "ALLOCA"
    | AND ->
        "AND"
    | ASHR ->
        "ASHR"
    | BITCAST ->
        "BITCAST"
    | BR ->
        "BR"
    | CALL ->
        "CALL"
    | COLON ->
        "COLON"
    | COMMA ->
        "COMMA"
    | CROSS ->
        "CROSS"
    | DECLARE ->
        "DECLARE"
    | DEFINE ->
        "DEFINE"
    | ENTRY ->
        "ENTRY"
    | EOF ->
        "EOF"
    | EQ ->
        "EQ"
    | EQUALS ->
        "EQUALS"
    | EXTERNAL ->
        "EXTERNAL"
    | GEP ->
        "GEP"
    | GID _ ->
        "GID"
    | GLOBAL ->
        "GLOBAL"
    | I1 ->
        "I1"
    | I32 ->
        "I32"
    | I64 ->
        "I64"
    | I8 ->
        "I8"
    | ICMP ->
        "ICMP"
    | INT _ ->
        "INT"
    | LABEL ->
        "LABEL"
    | LBL _ ->
        "LBL"
    | LBRACE ->
        "LBRACE"
    | LBRACKET ->
        "LBRACKET"
    | LOAD ->
        "LOAD"
    | LPAREN ->
        "LPAREN"
    | LSHR ->
        "LSHR"
    | MUL ->
        "MUL"
    | NE ->
        "NE"
    | NULL ->
        "NULL"
    | OR ->
        "OR"
    | RBRACE ->
        "RBRACE"
    | RBRACKET ->
        "RBRACKET"
    | RET ->
        "RET"
    | RPAREN ->
        "RPAREN"
    | SGE ->
        "SGE"
    | SGT ->
        "SGT"
    | SHL ->
        "SHL"
    | SLE ->
        "SLE"
    | SLT ->
        "SLT"
    | STAR ->
        "STAR"
    | STORE ->
        "STORE"
    | STRING _ ->
        "STRING"
    | SUB ->
        "SUB"
    | TO ->
        "TO"
    | TYPE ->
        "TYPE"
    | UID _ ->
        "UID"
    | VOID ->
        "VOID"
    | XOR ->
        "XOR"

let _menhir_fail : unit -> 'a =
  fun () ->
    Printf.eprintf "Internal failure -- please contact the parser generator's developers.\n%!";
    assert false

include struct
  
  [@@@ocaml.warning "-4-37"]
  
  let rec _menhir_goto_decls_rev : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      match (_tok : MenhirBasics.token) with
      | UID _v_0 ->
          let _menhir_stack = MenhirCell0_decls_rev (_menhir_stack, _v) in
          let _menhir_stack = MenhirCell0_UID (_menhir_stack, _v_0) in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | EQUALS ->
              let _tok = _menhir_lexer _menhir_lexbuf in
              (match (_tok : MenhirBasics.token) with
              | TYPE ->
                  let _menhir_s = MenhirState005 in
                  let _tok = _menhir_lexer _menhir_lexbuf in
                  (match (_tok : MenhirBasics.token) with
                  | VOID ->
                      _menhir_run_006 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
                  | UID _v ->
                      _menhir_run_007 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
                  | LBRACKET ->
                      _menhir_run_008 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
                  | LBRACE ->
                      _menhir_run_011 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
                  | I8 ->
                      _menhir_run_012 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
                  | I64 ->
                      _menhir_run_013 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
                  | I1 ->
                      _menhir_run_014 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
                  | _ ->
                      _eRR ())
              | _ ->
                  _eRR ())
          | _ ->
              _eRR ())
      | GID _v_2 ->
          let _menhir_stack = MenhirCell0_decls_rev (_menhir_stack, _v) in
          let _menhir_stack = MenhirCell0_GID (_menhir_stack, _v_2) in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | EQUALS ->
              let _tok = _menhir_lexer _menhir_lexbuf in
              (match (_tok : MenhirBasics.token) with
              | GLOBAL ->
                  let _menhir_s = MenhirState031 in
                  let _tok = _menhir_lexer _menhir_lexbuf in
                  (match (_tok : MenhirBasics.token) with
                  | VOID ->
                      _menhir_run_006 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
                  | UID _v ->
                      _menhir_run_007 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
                  | LBRACKET ->
                      _menhir_run_008 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
                  | LBRACE ->
                      _menhir_run_011 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
                  | I8 ->
                      _menhir_run_012 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
                  | I64 ->
                      _menhir_run_013 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
                  | I1 ->
                      _menhir_run_014 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
                  | _ ->
                      _eRR ())
              | EXTERNAL ->
                  let _tok = _menhir_lexer _menhir_lexbuf in
                  (match (_tok : MenhirBasics.token) with
                  | GLOBAL ->
                      let _menhir_s = MenhirState058 in
                      let _tok = _menhir_lexer _menhir_lexbuf in
                      (match (_tok : MenhirBasics.token) with
                      | VOID ->
                          _menhir_run_006 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
                      | UID _v ->
                          _menhir_run_007 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
                      | LBRACKET ->
                          _menhir_run_008 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
                      | LBRACE ->
                          _menhir_run_011 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
                      | I8 ->
                          _menhir_run_012 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
                      | I64 ->
                          _menhir_run_013 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
                      | I1 ->
                          _menhir_run_014 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
                      | _ ->
                          _eRR ())
                  | _ ->
                      _eRR ())
              | _ ->
                  _eRR ())
          | _ ->
              _eRR ())
      | DEFINE ->
          let _menhir_stack = MenhirCell0_decls_rev (_menhir_stack, _v) in
          let _menhir_s = MenhirState060 in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | VOID ->
              _menhir_run_006 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | UID _v ->
              _menhir_run_007 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | LBRACKET ->
              _menhir_run_008 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | LBRACE ->
              _menhir_run_011 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | I8 ->
              _menhir_run_012 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | I64 ->
              _menhir_run_013 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | I1 ->
              _menhir_run_014 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | _ ->
              _eRR ())
      | DECLARE ->
          let _menhir_stack = MenhirCell0_decls_rev (_menhir_stack, _v) in
          let _menhir_s = MenhirState188 in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | VOID ->
              _menhir_run_006 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | UID _v ->
              _menhir_run_007 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | LBRACKET ->
              _menhir_run_008 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | LBRACE ->
              _menhir_run_011 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | I8 ->
              _menhir_run_012 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | I64 ->
              _menhir_run_013 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | I1 ->
              _menhir_run_014 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | _ ->
              _eRR ())
      | EOF ->
          let ds = _v in
          let _v = _menhir_action_25 ds in
          let ds = _v in
          let _v = _menhir_action_80 ds in
          MenhirBox_prog _v
      | _ ->
          _eRR ()
  
  and _menhir_run_006 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_prog) _menhir_state -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      let _v = _menhir_action_68 () in
      _menhir_goto_nonptr_ty _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_goto_nonptr_ty : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_prog) _menhir_state -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let t = _v in
      let _v = _menhir_action_89 t in
      _menhir_goto_ty _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_goto_ty : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_prog) _menhir_state -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match _menhir_s with
      | MenhirState193 ->
          _menhir_run_192 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState191 ->
          _menhir_run_192 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState188 ->
          _menhir_run_189 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState161 ->
          _menhir_run_162 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState153 ->
          _menhir_run_154 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState148 ->
          _menhir_run_149 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState145 ->
          _menhir_run_146 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState140 ->
          _menhir_run_141 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState137 ->
          _menhir_run_138 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState133 ->
          _menhir_run_134 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState130 ->
          _menhir_run_131 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState156 ->
          _menhir_run_128 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState121 ->
          _menhir_run_128 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState123 ->
          _menhir_run_124 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState118 ->
          _menhir_run_119 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState103 ->
          _menhir_run_104 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState101 ->
          _menhir_run_102 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState096 ->
          _menhir_run_097 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState082 ->
          _menhir_run_083 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState080 ->
          _menhir_run_081 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState067 ->
          _menhir_run_064 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState063 ->
          _menhir_run_064 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState060 ->
          _menhir_run_061 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState058 ->
          _menhir_run_059 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState047 ->
          _menhir_run_048 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState044 ->
          _menhir_run_045 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState039 ->
          _menhir_run_040 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState037 ->
          _menhir_run_036 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState035 ->
          _menhir_run_036 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState031 ->
          _menhir_run_032 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState005 ->
          _menhir_run_028 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState010 ->
          _menhir_run_026 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState011 ->
          _menhir_run_022 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState019 ->
          _menhir_run_022 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState016 ->
          _menhir_run_017 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_192 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_prog) _menhir_state -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | STAR ->
          let _menhir_stack = MenhirCell1_ty (_menhir_stack, _menhir_s, _v) in
          _menhir_run_018 _menhir_stack _menhir_lexbuf _menhir_lexer
      | LPAREN ->
          let _menhir_stack = MenhirCell1_ty (_menhir_stack, _menhir_s, _v) in
          _menhir_run_019 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState192
      | COMMA ->
          let _menhir_stack = MenhirCell1_ty (_menhir_stack, _menhir_s, _v) in
          let _menhir_stack = MenhirCell1_COMMA (_menhir_stack, MenhirState192) in
          let _menhir_s = MenhirState193 in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | VOID ->
              _menhir_run_006 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | UID _v ->
              _menhir_run_007 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | LBRACKET ->
              _menhir_run_008 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | LBRACE ->
              _menhir_run_011 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | I8 ->
              _menhir_run_012 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | I64 ->
              _menhir_run_013 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | I1 ->
              _menhir_run_014 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | _ ->
              _eRR ())
      | RPAREN ->
          let x = _v in
          let _v = _menhir_action_81 x in
          _menhir_goto_separated_nonempty_list_COMMA_ty_ _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_018 : type  ttv_stack. (ttv_stack, _menhir_box_prog) _menhir_cell1_ty -> _ -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      let MenhirCell1_ty (_menhir_stack, _menhir_s, t) = _menhir_stack in
      let _v = _menhir_action_88 t in
      _menhir_goto_ty _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_019 : type  ttv_stack. ((ttv_stack, _menhir_box_prog) _menhir_cell1_ty as 'stack) -> _ -> _ -> ('stack, _menhir_box_prog) _menhir_state -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_LPAREN (_menhir_stack, _menhir_s) in
      let _menhir_s = MenhirState019 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | VOID ->
          _menhir_run_006 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | UID _v ->
          _menhir_run_007 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | LBRACKET ->
          _menhir_run_008 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LBRACE ->
          _menhir_run_011 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | I8 ->
          _menhir_run_012 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | I64 ->
          _menhir_run_013 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | I1 ->
          _menhir_run_014 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_007 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_prog) _menhir_state -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      let t = _v in
      let _v = _menhir_action_75 t in
      _menhir_goto_nonptr_ty _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_008 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_prog) _menhir_state -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_LBRACKET (_menhir_stack, _menhir_s) in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | INT _v ->
          let _menhir_stack = MenhirCell0_INT (_menhir_stack, _v) in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | CROSS ->
              let _menhir_s = MenhirState010 in
              let _tok = _menhir_lexer _menhir_lexbuf in
              (match (_tok : MenhirBasics.token) with
              | VOID ->
                  _menhir_run_006 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | UID _v ->
                  _menhir_run_007 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
              | LBRACKET ->
                  _menhir_run_008 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | LBRACE ->
                  _menhir_run_011 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | I8 ->
                  _menhir_run_012 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | I64 ->
                  _menhir_run_013 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | I1 ->
                  _menhir_run_014 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | _ ->
                  _eRR ())
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_run_011 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_prog) _menhir_state -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_LBRACE (_menhir_stack, _menhir_s) in
      let _menhir_s = MenhirState011 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | VOID ->
          _menhir_run_006 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | UID _v ->
          _menhir_run_007 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | LBRACKET ->
          _menhir_run_008 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LBRACE ->
          _menhir_run_011 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | I8 ->
          _menhir_run_012 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | I64 ->
          _menhir_run_013 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | I1 ->
          _menhir_run_014 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_012 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_prog) _menhir_state -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      let _v = _menhir_action_70 () in
      _menhir_goto_nonptr_ty _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_013 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_prog) _menhir_state -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      let _v = _menhir_action_71 () in
      _menhir_goto_nonptr_ty _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_014 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_prog) _menhir_state -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      let _v = _menhir_action_69 () in
      _menhir_goto_nonptr_ty _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_goto_separated_nonempty_list_COMMA_ty_ : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_prog) _menhir_state -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      match _menhir_s with
      | MenhirState191 ->
          _menhir_run_195 _menhir_stack _menhir_lexbuf _menhir_lexer _v
      | MenhirState193 ->
          _menhir_run_194 _menhir_stack _menhir_lexbuf _menhir_lexer _v
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_195 : type  ttv_stack. ((ttv_stack _menhir_cell0_decls_rev, _menhir_box_prog) _menhir_cell1_ty, _menhir_box_prog) _menhir_cell1_GID -> _ -> _ -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v ->
      let x = _v in
      let _v = _menhir_action_67 x in
      _menhir_goto_loption_separated_nonempty_list_COMMA_ty__ _menhir_stack _menhir_lexbuf _menhir_lexer _v
  
  and _menhir_goto_loption_separated_nonempty_list_COMMA_ty__ : type  ttv_stack. ((ttv_stack _menhir_cell0_decls_rev, _menhir_box_prog) _menhir_cell1_ty, _menhir_box_prog) _menhir_cell1_GID -> _ -> _ -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      let MenhirCell1_GID (_menhir_stack, _, g) = _menhir_stack in
      let MenhirCell1_ty (_menhir_stack, _, rt) = _menhir_stack in
      let xs = _v in
      let _v = _menhir_action_31 g rt xs in
      _menhir_goto_edecl _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
  
  and _menhir_goto_edecl : type  ttv_stack. ttv_stack _menhir_cell0_decls_rev -> _ -> _ -> _ -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let MenhirCell0_decls_rev (_menhir_stack, ds) = _menhir_stack in
      let e = _v in
      let _v = _menhir_action_30 ds e in
      _menhir_goto_decls_rev _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
  
  and _menhir_run_194 : type  ttv_stack. ((ttv_stack, _menhir_box_prog) _menhir_cell1_ty, _menhir_box_prog) _menhir_cell1_COMMA -> _ -> _ -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v ->
      let MenhirCell1_COMMA (_menhir_stack, _) = _menhir_stack in
      let MenhirCell1_ty (_menhir_stack, _menhir_s, x) = _menhir_stack in
      let xs = _v in
      let _v = _menhir_action_82 x xs in
      _menhir_goto_separated_nonempty_list_COMMA_ty_ _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
  
  and _menhir_run_189 : type  ttv_stack. (ttv_stack _menhir_cell0_decls_rev as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_prog) _menhir_state -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_ty (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | STAR ->
          _menhir_run_018 _menhir_stack _menhir_lexbuf _menhir_lexer
      | LPAREN ->
          _menhir_run_019 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState189
      | GID _v_0 ->
          let _menhir_stack = MenhirCell1_GID (_menhir_stack, MenhirState189, _v_0) in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | LPAREN ->
              let _menhir_s = MenhirState191 in
              let _tok = _menhir_lexer _menhir_lexbuf in
              (match (_tok : MenhirBasics.token) with
              | VOID ->
                  _menhir_run_006 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | UID _v ->
                  _menhir_run_007 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
              | LBRACKET ->
                  _menhir_run_008 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | LBRACE ->
                  _menhir_run_011 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | I8 ->
                  _menhir_run_012 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | I64 ->
                  _menhir_run_013 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | I1 ->
                  _menhir_run_014 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | RPAREN ->
                  let _v = _menhir_action_66 () in
                  _menhir_goto_loption_separated_nonempty_list_COMMA_ty__ _menhir_stack _menhir_lexbuf _menhir_lexer _v
              | _ ->
                  _eRR ())
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_run_162 : type  ttv_stack. ((ttv_stack, _menhir_box_prog) _menhir_cell1_insn_list as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_prog) _menhir_state -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | UID _v_0 ->
          let _menhir_stack = MenhirCell1_ty (_menhir_stack, _menhir_s, _v) in
          _menhir_run_084 _menhir_stack _menhir_lexbuf _menhir_lexer _v_0 MenhirState162
      | STAR ->
          let _menhir_stack = MenhirCell1_ty (_menhir_stack, _menhir_s, _v) in
          _menhir_run_018 _menhir_stack _menhir_lexbuf _menhir_lexer
      | NULL ->
          let _menhir_stack = MenhirCell1_ty (_menhir_stack, _menhir_s, _v) in
          _menhir_run_085 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState162
      | LPAREN ->
          let _menhir_stack = MenhirCell1_ty (_menhir_stack, _menhir_s, _v) in
          _menhir_run_019 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState162
      | INT _v_1 ->
          let _menhir_stack = MenhirCell1_ty (_menhir_stack, _menhir_s, _v) in
          _menhir_run_086 _menhir_stack _menhir_lexbuf _menhir_lexer _v_1 MenhirState162
      | GID _v_2 ->
          let _menhir_stack = MenhirCell1_ty (_menhir_stack, _menhir_s, _v) in
          _menhir_run_087 _menhir_stack _menhir_lexbuf _menhir_lexer _v_2 MenhirState162
      | LBL _ | RBRACE ->
          let t = _v in
          let _v = _menhir_action_85 t in
          _menhir_goto_terminator _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_084 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_prog) _menhir_state -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      let u = _v in
      let _v = _menhir_action_79 u in
      _menhir_goto_operand _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_goto_operand : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_prog) _menhir_state -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match _menhir_s with
      | MenhirState167 ->
          _menhir_run_168 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | MenhirState162 ->
          _menhir_run_163 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | MenhirState154 ->
          _menhir_run_155 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState149 ->
          _menhir_run_150 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | MenhirState146 ->
          _menhir_run_147 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState143 ->
          _menhir_run_144 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | MenhirState141 ->
          _menhir_run_142 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState131 ->
          _menhir_run_132 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState128 ->
          _menhir_run_129 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | MenhirState124 ->
          _menhir_run_125 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | MenhirState119 ->
          _menhir_run_120 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState115 ->
          _menhir_run_116 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | MenhirState113 ->
          _menhir_run_114 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | MenhirState109 ->
          _menhir_run_110 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | MenhirState107 ->
          _menhir_run_108 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | MenhirState104 ->
          _menhir_run_105 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState099 ->
          _menhir_run_100 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | MenhirState097 ->
          _menhir_run_098 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState083 ->
          _menhir_run_088 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_168 : type  ttv_stack. (ttv_stack, _menhir_box_prog) _menhir_cell1_insn_list -> _ -> _ -> _ -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      match (_tok : MenhirBasics.token) with
      | COMMA ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | LABEL ->
              let _tok = _menhir_lexer _menhir_lexbuf in
              (match (_tok : MenhirBasics.token) with
              | UID _v_0 ->
                  let _tok = _menhir_lexer _menhir_lexbuf in
                  (match (_tok : MenhirBasics.token) with
                  | COMMA ->
                      let _tok = _menhir_lexer _menhir_lexbuf in
                      (match (_tok : MenhirBasics.token) with
                      | LABEL ->
                          let _tok = _menhir_lexer _menhir_lexbuf in
                          (match (_tok : MenhirBasics.token) with
                          | UID _v_1 ->
                              let _tok = _menhir_lexer _menhir_lexbuf in
                              let (o, l2, l1) = (_v, _v_1, _v_0) in
                              let _v = _menhir_action_87 l1 l2 o in
                              _menhir_goto_terminator _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
                          | _ ->
                              _eRR ())
                      | _ ->
                          _eRR ())
                  | _ ->
                      _eRR ())
              | _ ->
                  _eRR ())
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_goto_terminator : type  ttv_stack. (ttv_stack, _menhir_box_prog) _menhir_cell1_insn_list -> _ -> _ -> _ -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let MenhirCell1_insn_list (_menhir_stack, _menhir_s, is) = _menhir_stack in
      let t = _v in
      let _v = _menhir_action_06 is t in
      _menhir_goto_block _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_goto_block : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_prog) _menhir_state -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match _menhir_s with
      | MenhirState071 ->
          _menhir_run_186 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState182 ->
          _menhir_run_183 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | MenhirState152 ->
          _menhir_run_178 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_186 : type  ttv_stack. ((((ttv_stack _menhir_cell0_decls_rev, _menhir_box_prog) _menhir_cell1_ty, _menhir_box_prog) _menhir_cell1_GID, _menhir_box_prog) _menhir_cell1_arg_list as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_prog) _menhir_state -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let b = _v in
      let _v = _menhir_action_34 b in
      _menhir_goto_entry_block _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_goto_entry_block : type  ttv_stack. ((((ttv_stack _menhir_cell0_decls_rev, _menhir_box_prog) _menhir_cell1_ty, _menhir_box_prog) _menhir_cell1_GID, _menhir_box_prog) _menhir_cell1_arg_list as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_prog) _menhir_state -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_entry_block (_menhir_stack, _menhir_s, _v) in
      let _v = _menhir_action_08 () in
      _menhir_goto_block_list_rev _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
  
  and _menhir_goto_block_list_rev : type  ttv_stack. ((((ttv_stack _menhir_cell0_decls_rev, _menhir_box_prog) _menhir_cell1_ty, _menhir_box_prog) _menhir_cell1_GID, _menhir_box_prog) _menhir_cell1_arg_list, _menhir_box_prog) _menhir_cell1_entry_block -> _ -> _ -> _ -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      match (_tok : MenhirBasics.token) with
      | LBL _v_0 ->
          let _menhir_stack = MenhirCell0_block_list_rev (_menhir_stack, _v) in
          let _menhir_stack = MenhirCell0_LBL (_menhir_stack, _v_0) in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | COLON ->
              let _tok = _menhir_lexer _menhir_lexbuf in
              (match (_tok : MenhirBasics.token) with
              | UID _v_1 ->
                  _menhir_run_072 _menhir_stack _menhir_lexbuf _menhir_lexer _v_1 MenhirState182
              | STORE ->
                  _menhir_run_145 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState182
              | CALL ->
                  _menhir_run_153 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState182
              | BR | RET ->
                  let _v_2 = _menhir_action_64 () in
                  _menhir_run_159 _menhir_stack _menhir_lexbuf _menhir_lexer _v_2 MenhirState182 _tok
              | _ ->
                  _eRR ())
          | _ ->
              _eRR ())
      | RBRACE ->
          let bs = _v in
          let _v = _menhir_action_07 bs in
          let _tok = _menhir_lexer _menhir_lexbuf in
          let MenhirCell1_entry_block (_menhir_stack, _, eb) = _menhir_stack in
          let MenhirCell1_arg_list (_menhir_stack, _, a) = _menhir_stack in
          let MenhirCell1_GID (_menhir_stack, _, l) = _menhir_stack in
          let MenhirCell1_ty (_menhir_stack, _, t) = _menhir_stack in
          let bs = _v in
          let _v = _menhir_action_35 a bs eb l t in
          let MenhirCell0_decls_rev (_menhir_stack, ds) = _menhir_stack in
          let f = _v in
          let _v = _menhir_action_27 ds f in
          _menhir_goto_decls_rev _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_072 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_prog) _menhir_state -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      let _menhir_stack = MenhirCell1_UID (_menhir_stack, _menhir_s, _v) in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | EQUALS ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | XOR ->
              let _tok = _menhir_lexer _menhir_lexbuf in
              let _v = _menhir_action_15 () in
              _menhir_goto_bop _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
          | SUB ->
              let _tok = _menhir_lexer _menhir_lexbuf in
              let _v = _menhir_action_12 () in
              _menhir_goto_bop _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
          | SHL ->
              let _tok = _menhir_lexer _menhir_lexbuf in
              let _v = _menhir_action_14 () in
              _menhir_goto_bop _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
          | OR ->
              let _tok = _menhir_lexer _menhir_lexbuf in
              let _v = _menhir_action_10 () in
              _menhir_goto_bop _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
          | MUL ->
              let _tok = _menhir_lexer _menhir_lexbuf in
              let _v = _menhir_action_13 () in
              _menhir_goto_bop _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
          | LSHR ->
              let _tok = _menhir_lexer _menhir_lexbuf in
              let _v = _menhir_action_17 () in
              _menhir_goto_bop _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
          | LOAD ->
              let _menhir_s = MenhirState080 in
              let _tok = _menhir_lexer _menhir_lexbuf in
              (match (_tok : MenhirBasics.token) with
              | VOID ->
                  _menhir_run_006 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | UID _v ->
                  _menhir_run_007 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
              | LBRACKET ->
                  _menhir_run_008 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | LBRACE ->
                  _menhir_run_011 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | I8 ->
                  _menhir_run_012 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | I64 ->
                  _menhir_run_013 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | I1 ->
                  _menhir_run_014 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | _ ->
                  _eRR ())
          | ICMP ->
              let _tok = _menhir_lexer _menhir_lexbuf in
              (match (_tok : MenhirBasics.token) with
              | SLT ->
                  let _tok = _menhir_lexer _menhir_lexbuf in
                  let _v = _menhir_action_21 () in
                  _menhir_goto_cnd _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
              | SLE ->
                  let _tok = _menhir_lexer _menhir_lexbuf in
                  let _v = _menhir_action_22 () in
                  _menhir_goto_cnd _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
              | SGT ->
                  let _tok = _menhir_lexer _menhir_lexbuf in
                  let _v = _menhir_action_23 () in
                  _menhir_goto_cnd _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
              | SGE ->
                  let _tok = _menhir_lexer _menhir_lexbuf in
                  let _v = _menhir_action_24 () in
                  _menhir_goto_cnd _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
              | NE ->
                  let _tok = _menhir_lexer _menhir_lexbuf in
                  let _v = _menhir_action_20 () in
                  _menhir_goto_cnd _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
              | EQ ->
                  let _tok = _menhir_lexer _menhir_lexbuf in
                  let _v = _menhir_action_19 () in
                  _menhir_goto_cnd _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
              | _ ->
                  _eRR ())
          | GEP ->
              let _menhir_s = MenhirState101 in
              let _tok = _menhir_lexer _menhir_lexbuf in
              (match (_tok : MenhirBasics.token) with
              | VOID ->
                  _menhir_run_006 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | UID _v ->
                  _menhir_run_007 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
              | LBRACKET ->
                  _menhir_run_008 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | LBRACE ->
                  _menhir_run_011 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | I8 ->
                  _menhir_run_012 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | I64 ->
                  _menhir_run_013 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | I1 ->
                  _menhir_run_014 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | _ ->
                  _eRR ())
          | CALL ->
              let _menhir_s = MenhirState118 in
              let _tok = _menhir_lexer _menhir_lexbuf in
              (match (_tok : MenhirBasics.token) with
              | VOID ->
                  _menhir_run_006 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | UID _v ->
                  _menhir_run_007 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
              | LBRACKET ->
                  _menhir_run_008 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | LBRACE ->
                  _menhir_run_011 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | I8 ->
                  _menhir_run_012 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | I64 ->
                  _menhir_run_013 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | I1 ->
                  _menhir_run_014 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | _ ->
                  _eRR ())
          | BITCAST ->
              let _menhir_s = MenhirState130 in
              let _tok = _menhir_lexer _menhir_lexbuf in
              (match (_tok : MenhirBasics.token) with
              | VOID ->
                  _menhir_run_006 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | UID _v ->
                  _menhir_run_007 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
              | LBRACKET ->
                  _menhir_run_008 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | LBRACE ->
                  _menhir_run_011 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | I8 ->
                  _menhir_run_012 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | I64 ->
                  _menhir_run_013 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | I1 ->
                  _menhir_run_014 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | _ ->
                  _eRR ())
          | ASHR ->
              let _tok = _menhir_lexer _menhir_lexbuf in
              let _v = _menhir_action_18 () in
              _menhir_goto_bop _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
          | AND ->
              let _tok = _menhir_lexer _menhir_lexbuf in
              let _v = _menhir_action_16 () in
              _menhir_goto_bop _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
          | ALLOCA ->
              let _menhir_s = MenhirState137 in
              let _tok = _menhir_lexer _menhir_lexbuf in
              (match (_tok : MenhirBasics.token) with
              | VOID ->
                  _menhir_run_006 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | UID _v ->
                  _menhir_run_007 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
              | LBRACKET ->
                  _menhir_run_008 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | LBRACE ->
                  _menhir_run_011 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | I8 ->
                  _menhir_run_012 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | I64 ->
                  _menhir_run_013 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | I1 ->
                  _menhir_run_014 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | _ ->
                  _eRR ())
          | ADD ->
              let _tok = _menhir_lexer _menhir_lexbuf in
              let _v = _menhir_action_11 () in
              _menhir_goto_bop _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_goto_bop : type  ttv_stack. (ttv_stack, _menhir_box_prog) _menhir_cell1_UID -> _ -> _ -> _ -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let _menhir_stack = MenhirCell0_bop (_menhir_stack, _v) in
      match (_tok : MenhirBasics.token) with
      | VOID ->
          _menhir_run_006 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState140
      | UID _v_0 ->
          _menhir_run_007 _menhir_stack _menhir_lexbuf _menhir_lexer _v_0 MenhirState140
      | LBRACKET ->
          _menhir_run_008 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState140
      | LBRACE ->
          _menhir_run_011 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState140
      | I8 ->
          _menhir_run_012 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState140
      | I64 ->
          _menhir_run_013 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState140
      | I1 ->
          _menhir_run_014 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState140
      | _ ->
          _eRR ()
  
  and _menhir_goto_cnd : type  ttv_stack. (ttv_stack, _menhir_box_prog) _menhir_cell1_UID -> _ -> _ -> _ -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let _menhir_stack = MenhirCell0_cnd (_menhir_stack, _v) in
      match (_tok : MenhirBasics.token) with
      | VOID ->
          _menhir_run_006 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState096
      | UID _v_0 ->
          _menhir_run_007 _menhir_stack _menhir_lexbuf _menhir_lexer _v_0 MenhirState096
      | LBRACKET ->
          _menhir_run_008 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState096
      | LBRACE ->
          _menhir_run_011 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState096
      | I8 ->
          _menhir_run_012 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState096
      | I64 ->
          _menhir_run_013 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState096
      | I1 ->
          _menhir_run_014 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState096
      | _ ->
          _eRR ()
  
  and _menhir_run_145 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_prog) _menhir_state -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_STORE (_menhir_stack, _menhir_s) in
      let _menhir_s = MenhirState145 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | VOID ->
          _menhir_run_006 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | UID _v ->
          _menhir_run_007 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | LBRACKET ->
          _menhir_run_008 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LBRACE ->
          _menhir_run_011 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | I8 ->
          _menhir_run_012 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | I64 ->
          _menhir_run_013 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | I1 ->
          _menhir_run_014 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_153 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_prog) _menhir_state -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_CALL (_menhir_stack, _menhir_s) in
      let _menhir_s = MenhirState153 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | VOID ->
          _menhir_run_006 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | UID _v ->
          _menhir_run_007 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | LBRACKET ->
          _menhir_run_008 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LBRACE ->
          _menhir_run_011 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | I8 ->
          _menhir_run_012 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | I64 ->
          _menhir_run_013 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | I1 ->
          _menhir_run_014 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_159 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_prog) _menhir_state -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let is = _v in
      let _v = _menhir_action_63 is in
      let _menhir_stack = MenhirCell1_insn_list (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | RET ->
          let _menhir_s = MenhirState161 in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | VOID ->
              _menhir_run_006 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | UID _v ->
              _menhir_run_007 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | LBRACKET ->
              _menhir_run_008 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | LBRACE ->
              _menhir_run_011 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | I8 ->
              _menhir_run_012 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | I64 ->
              _menhir_run_013 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | I1 ->
              _menhir_run_014 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | _ ->
              _eRR ())
      | BR ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | LABEL ->
              let _tok = _menhir_lexer _menhir_lexbuf in
              (match (_tok : MenhirBasics.token) with
              | UID _v_1 ->
                  let _tok = _menhir_lexer _menhir_lexbuf in
                  let l = _v_1 in
                  let _v = _menhir_action_86 l in
                  _menhir_goto_terminator _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
              | _ ->
                  _eRR ())
          | I1 ->
              let _menhir_s = MenhirState167 in
              let _tok = _menhir_lexer _menhir_lexbuf in
              (match (_tok : MenhirBasics.token) with
              | UID _v ->
                  _menhir_run_084 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
              | NULL ->
                  _menhir_run_085 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | INT _v ->
                  _menhir_run_086 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
              | GID _v ->
                  _menhir_run_087 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
              | _ ->
                  _eRR ())
          | _ ->
              _eRR ())
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_085 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_prog) _menhir_state -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      let _v = _menhir_action_76 () in
      _menhir_goto_operand _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_086 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_prog) _menhir_state -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      let i = _v in
      let _v = _menhir_action_77 i in
      _menhir_goto_operand _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_087 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_prog) _menhir_state -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      let g = _v in
      let _v = _menhir_action_78 g in
      _menhir_goto_operand _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_183 : type  ttv_stack. ((((ttv_stack _menhir_cell0_decls_rev, _menhir_box_prog) _menhir_cell1_ty, _menhir_box_prog) _menhir_cell1_GID, _menhir_box_prog) _menhir_cell1_arg_list, _menhir_box_prog) _menhir_cell1_entry_block _menhir_cell0_block_list_rev _menhir_cell0_LBL -> _ -> _ -> _ -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let MenhirCell0_LBL (_menhir_stack, l) = _menhir_stack in
      let MenhirCell0_block_list_rev (_menhir_stack, bs) = _menhir_stack in
      let b = _v in
      let _v = _menhir_action_09 b bs l in
      _menhir_goto_block_list_rev _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
  
  and _menhir_run_178 : type  ttv_stack. ((((ttv_stack _menhir_cell0_decls_rev, _menhir_box_prog) _menhir_cell1_ty, _menhir_box_prog) _menhir_cell1_GID, _menhir_box_prog) _menhir_cell1_arg_list, _menhir_box_prog) _menhir_cell1_ENTRY -> _ -> _ -> _ -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let MenhirCell1_ENTRY (_menhir_stack, _menhir_s) = _menhir_stack in
      let b = _v in
      let _v = _menhir_action_33 b in
      _menhir_goto_entry_block _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_163 : type  ttv_stack. ((ttv_stack, _menhir_box_prog) _menhir_cell1_insn_list, _menhir_box_prog) _menhir_cell1_ty -> _ -> _ -> _ -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let MenhirCell1_ty (_menhir_stack, _, t) = _menhir_stack in
      let o = _v in
      let _v = _menhir_action_84 o t in
      _menhir_goto_terminator _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
  
  and _menhir_run_155 : type  ttv_stack. (((ttv_stack, _menhir_box_prog) _menhir_cell1_CALL, _menhir_box_prog) _menhir_cell1_ty as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_prog) _menhir_state -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_operand (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | LPAREN ->
          let _menhir_s = MenhirState156 in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | VOID ->
              _menhir_run_006 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | UID _v ->
              _menhir_run_007 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | LBRACKET ->
              _menhir_run_008 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | LBRACE ->
              _menhir_run_011 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | I8 ->
              _menhir_run_012 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | I64 ->
              _menhir_run_013 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | I1 ->
              _menhir_run_014 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | COMMA | RPAREN ->
              _menhir_reduce_94 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s _tok
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_reduce_94 : type  ttv_stack. (((ttv_stack, _menhir_box_prog) _menhir_cell1_ty, _menhir_box_prog) _menhir_cell1_operand as 'stack) -> _ -> _ -> ('stack, _menhir_box_prog) _menhir_state -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s _tok ->
      let _v = _menhir_action_94 () in
      _menhir_goto_ty_operand_list_rev _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_goto_ty_operand_list_rev : type  ttv_stack. (((ttv_stack, _menhir_box_prog) _menhir_cell1_ty, _menhir_box_prog) _menhir_cell1_operand as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_prog) _menhir_state -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | COMMA ->
          let _menhir_stack = MenhirCell1_ty_operand_list_rev (_menhir_stack, _menhir_s, _v) in
          let _menhir_s = MenhirState123 in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | VOID ->
              _menhir_run_006 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | UID _v ->
              _menhir_run_007 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | LBRACKET ->
              _menhir_run_008 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | LBRACE ->
              _menhir_run_011 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | I8 ->
              _menhir_run_012 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | I64 ->
              _menhir_run_013 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | I1 ->
              _menhir_run_014 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | _ ->
              _eRR ())
      | RPAREN ->
          let tos = _v in
          let _v = _menhir_action_93 tos in
          _menhir_goto_ty_operand_list _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_goto_ty_operand_list : type  ttv_stack. (((ttv_stack, _menhir_box_prog) _menhir_cell1_ty, _menhir_box_prog) _menhir_cell1_operand as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_prog) _menhir_state -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      match _menhir_s with
      | MenhirState156 ->
          _menhir_run_157 _menhir_stack _menhir_lexbuf _menhir_lexer _v
      | MenhirState121 ->
          _menhir_run_126 _menhir_stack _menhir_lexbuf _menhir_lexer _v
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_157 : type  ttv_stack. (((ttv_stack, _menhir_box_prog) _menhir_cell1_CALL, _menhir_box_prog) _menhir_cell1_ty, _menhir_box_prog) _menhir_cell1_operand -> _ -> _ -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      let MenhirCell1_operand (_menhir_stack, _, o) = _menhir_stack in
      let MenhirCell1_ty (_menhir_stack, _, t) = _menhir_stack in
      let MenhirCell1_CALL (_menhir_stack, _menhir_s) = _menhir_stack in
      let args = _v in
      let _v = _menhir_action_59 args o t in
      _menhir_goto_insn _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_goto_insn : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_prog) _menhir_state -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_insn (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | UID _v_0 ->
          _menhir_run_072 _menhir_stack _menhir_lexbuf _menhir_lexer _v_0 MenhirState176
      | STORE ->
          _menhir_run_145 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState176
      | CALL ->
          _menhir_run_153 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState176
      | BR | RET ->
          let _v_1 = _menhir_action_64 () in
          _menhir_run_177 _menhir_stack _menhir_lexbuf _menhir_lexer _v_1 _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_177 : type  ttv_stack. (ttv_stack, _menhir_box_prog) _menhir_cell1_insn -> _ -> _ -> _ -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let MenhirCell1_insn (_menhir_stack, _menhir_s, x) = _menhir_stack in
      let xs = _v in
      let _v = _menhir_action_65 x xs in
      _menhir_goto_list_insn_ _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_goto_list_insn_ : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_prog) _menhir_state -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match _menhir_s with
      | MenhirState176 ->
          _menhir_run_177 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | MenhirState182 ->
          _menhir_run_159 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState071 ->
          _menhir_run_159 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState152 ->
          _menhir_run_159 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_126 : type  ttv_stack. (((ttv_stack, _menhir_box_prog) _menhir_cell1_UID, _menhir_box_prog) _menhir_cell1_ty, _menhir_box_prog) _menhir_cell1_operand -> _ -> _ -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      let MenhirCell1_operand (_menhir_stack, _, o) = _menhir_stack in
      let MenhirCell1_ty (_menhir_stack, _, t) = _menhir_stack in
      let MenhirCell1_UID (_menhir_stack, _menhir_s, u) = _menhir_stack in
      let args = _v in
      let _v = _menhir_action_60 args o t u in
      _menhir_goto_insn _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_150 : type  ttv_stack. ((((ttv_stack, _menhir_box_prog) _menhir_cell1_STORE, _menhir_box_prog) _menhir_cell1_ty, _menhir_box_prog) _menhir_cell1_operand, _menhir_box_prog) _menhir_cell1_ty -> _ -> _ -> _ -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let MenhirCell1_ty (_menhir_stack, _, t2) = _menhir_stack in
      let MenhirCell1_operand (_menhir_stack, _, o1) = _menhir_stack in
      let MenhirCell1_ty (_menhir_stack, _, t1) = _menhir_stack in
      let MenhirCell1_STORE (_menhir_stack, _menhir_s) = _menhir_stack in
      let o2 = _v in
      let _v = _menhir_action_57 o1 o2 t1 t2 in
      _menhir_goto_insn _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_147 : type  ttv_stack. (((ttv_stack, _menhir_box_prog) _menhir_cell1_STORE, _menhir_box_prog) _menhir_cell1_ty as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_prog) _menhir_state -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_operand (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | COMMA ->
          let _menhir_s = MenhirState148 in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | VOID ->
              _menhir_run_006 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | UID _v ->
              _menhir_run_007 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | LBRACKET ->
              _menhir_run_008 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | LBRACE ->
              _menhir_run_011 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | I8 ->
              _menhir_run_012 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | I64 ->
              _menhir_run_013 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | I1 ->
              _menhir_run_014 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_run_144 : type  ttv_stack. (((ttv_stack, _menhir_box_prog) _menhir_cell1_UID _menhir_cell0_bop, _menhir_box_prog) _menhir_cell1_ty, _menhir_box_prog) _menhir_cell1_operand -> _ -> _ -> _ -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let MenhirCell1_operand (_menhir_stack, _, o1) = _menhir_stack in
      let MenhirCell1_ty (_menhir_stack, _, t) = _menhir_stack in
      let MenhirCell0_bop (_menhir_stack, b) = _menhir_stack in
      let MenhirCell1_UID (_menhir_stack, _menhir_s, u) = _menhir_stack in
      let o2 = _v in
      let _v = _menhir_action_54 b o1 o2 t u in
      _menhir_goto_insn _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_142 : type  ttv_stack. (((ttv_stack, _menhir_box_prog) _menhir_cell1_UID _menhir_cell0_bop, _menhir_box_prog) _menhir_cell1_ty as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_prog) _menhir_state -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_operand (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | COMMA ->
          let _menhir_s = MenhirState143 in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | UID _v ->
              _menhir_run_084 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | NULL ->
              _menhir_run_085 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | INT _v ->
              _menhir_run_086 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | GID _v ->
              _menhir_run_087 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_run_132 : type  ttv_stack. (((ttv_stack, _menhir_box_prog) _menhir_cell1_UID, _menhir_box_prog) _menhir_cell1_ty as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_prog) _menhir_state -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_operand (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | TO ->
          let _menhir_s = MenhirState133 in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | VOID ->
              _menhir_run_006 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | UID _v ->
              _menhir_run_007 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | LBRACKET ->
              _menhir_run_008 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | LBRACE ->
              _menhir_run_011 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | I8 ->
              _menhir_run_012 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | I64 ->
              _menhir_run_013 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | I1 ->
              _menhir_run_014 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_run_129 : type  ttv_stack. (((ttv_stack, _menhir_box_prog) _menhir_cell1_ty, _menhir_box_prog) _menhir_cell1_operand, _menhir_box_prog) _menhir_cell1_ty -> _ -> _ -> _ -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let MenhirCell1_ty (_menhir_stack, _menhir_s, t) = _menhir_stack in
      let o = _v in
      let _v = _menhir_action_95 o t in
      _menhir_goto_ty_operand_list_rev _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_125 : type  ttv_stack. ((((ttv_stack, _menhir_box_prog) _menhir_cell1_ty, _menhir_box_prog) _menhir_cell1_operand, _menhir_box_prog) _menhir_cell1_ty_operand_list_rev, _menhir_box_prog) _menhir_cell1_ty -> _ -> _ -> _ -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let MenhirCell1_ty (_menhir_stack, _, t) = _menhir_stack in
      let MenhirCell1_ty_operand_list_rev (_menhir_stack, _menhir_s, tos) = _menhir_stack in
      let o = _v in
      let _v = _menhir_action_96 o t tos in
      _menhir_goto_ty_operand_list_rev _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_120 : type  ttv_stack. (((ttv_stack, _menhir_box_prog) _menhir_cell1_UID, _menhir_box_prog) _menhir_cell1_ty as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_prog) _menhir_state -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_operand (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | LPAREN ->
          let _menhir_s = MenhirState121 in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | VOID ->
              _menhir_run_006 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | UID _v ->
              _menhir_run_007 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | LBRACKET ->
              _menhir_run_008 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | LBRACE ->
              _menhir_run_011 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | I8 ->
              _menhir_run_012 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | I64 ->
              _menhir_run_013 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | I1 ->
              _menhir_run_014 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | COMMA | RPAREN ->
              _menhir_reduce_94 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s _tok
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_run_116 : type  ttv_stack. (((((ttv_stack, _menhir_box_prog) _menhir_cell1_UID, _menhir_box_prog) _menhir_cell1_ty, _menhir_box_prog) _menhir_cell1_COMMA, _menhir_box_prog) _menhir_cell1_ty, _menhir_box_prog) _menhir_cell1_operand _menhir_cell0_i_operand_list_rev -> _ -> _ -> _ -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let MenhirCell0_i_operand_list_rev (_menhir_stack, os) = _menhir_stack in
      let o = _v in
      let _v = _menhir_action_53 o os in
      _menhir_goto_i_operand_list_rev _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
  
  and _menhir_goto_i_operand_list_rev : type  ttv_stack. (((((ttv_stack, _menhir_box_prog) _menhir_cell1_UID, _menhir_box_prog) _menhir_cell1_ty, _menhir_box_prog) _menhir_cell1_COMMA, _menhir_box_prog) _menhir_cell1_ty, _menhir_box_prog) _menhir_cell1_operand -> _ -> _ -> _ -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      match (_tok : MenhirBasics.token) with
      | COMMA ->
          let _menhir_stack = MenhirCell0_i_operand_list_rev (_menhir_stack, _v) in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | I64 ->
              let _menhir_s = MenhirState113 in
              let _tok = _menhir_lexer _menhir_lexbuf in
              (match (_tok : MenhirBasics.token) with
              | UID _v ->
                  _menhir_run_084 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
              | NULL ->
                  _menhir_run_085 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | INT _v ->
                  _menhir_run_086 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
              | GID _v ->
                  _menhir_run_087 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
              | _ ->
                  _eRR ())
          | I32 ->
              let _menhir_s = MenhirState115 in
              let _tok = _menhir_lexer _menhir_lexbuf in
              (match (_tok : MenhirBasics.token) with
              | UID _v ->
                  _menhir_run_084 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
              | NULL ->
                  _menhir_run_085 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | INT _v ->
                  _menhir_run_086 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
              | GID _v ->
                  _menhir_run_087 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
              | _ ->
                  _eRR ())
          | _ ->
              _eRR ())
      | BR | CALL | RET | STORE | UID _ ->
          let os = _v in
          let _v = _menhir_action_48 os in
          let MenhirCell1_operand (_menhir_stack, _, o) = _menhir_stack in
          let MenhirCell1_ty (_menhir_stack, _, t) = _menhir_stack in
          let MenhirCell1_COMMA (_menhir_stack, _) = _menhir_stack in
          let MenhirCell1_ty (_menhir_stack, _, _) = _menhir_stack in
          let MenhirCell1_UID (_menhir_stack, _menhir_s, u) = _menhir_stack in
          let os = _v in
          let _v = _menhir_action_62 o os t u in
          _menhir_goto_insn _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_114 : type  ttv_stack. (((((ttv_stack, _menhir_box_prog) _menhir_cell1_UID, _menhir_box_prog) _menhir_cell1_ty, _menhir_box_prog) _menhir_cell1_COMMA, _menhir_box_prog) _menhir_cell1_ty, _menhir_box_prog) _menhir_cell1_operand _menhir_cell0_i_operand_list_rev -> _ -> _ -> _ -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let MenhirCell0_i_operand_list_rev (_menhir_stack, os) = _menhir_stack in
      let o = _v in
      let _v = _menhir_action_52 o os in
      _menhir_goto_i_operand_list_rev _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
  
  and _menhir_run_110 : type  ttv_stack. (((((ttv_stack, _menhir_box_prog) _menhir_cell1_UID, _menhir_box_prog) _menhir_cell1_ty, _menhir_box_prog) _menhir_cell1_COMMA, _menhir_box_prog) _menhir_cell1_ty, _menhir_box_prog) _menhir_cell1_operand -> _ -> _ -> _ -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let o = _v in
      let _v = _menhir_action_51 o in
      _menhir_goto_i_operand_list_rev _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
  
  and _menhir_run_108 : type  ttv_stack. (((((ttv_stack, _menhir_box_prog) _menhir_cell1_UID, _menhir_box_prog) _menhir_cell1_ty, _menhir_box_prog) _menhir_cell1_COMMA, _menhir_box_prog) _menhir_cell1_ty, _menhir_box_prog) _menhir_cell1_operand -> _ -> _ -> _ -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let o = _v in
      let _v = _menhir_action_50 o in
      _menhir_goto_i_operand_list_rev _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
  
  and _menhir_run_105 : type  ttv_stack. (((((ttv_stack, _menhir_box_prog) _menhir_cell1_UID, _menhir_box_prog) _menhir_cell1_ty, _menhir_box_prog) _menhir_cell1_COMMA, _menhir_box_prog) _menhir_cell1_ty as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_prog) _menhir_state -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_operand (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | COMMA ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | I64 ->
              let _menhir_s = MenhirState107 in
              let _tok = _menhir_lexer _menhir_lexbuf in
              (match (_tok : MenhirBasics.token) with
              | UID _v ->
                  _menhir_run_084 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
              | NULL ->
                  _menhir_run_085 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | INT _v ->
                  _menhir_run_086 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
              | GID _v ->
                  _menhir_run_087 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
              | _ ->
                  _eRR ())
          | I32 ->
              let _menhir_s = MenhirState109 in
              let _tok = _menhir_lexer _menhir_lexbuf in
              (match (_tok : MenhirBasics.token) with
              | UID _v ->
                  _menhir_run_084 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
              | NULL ->
                  _menhir_run_085 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | INT _v ->
                  _menhir_run_086 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
              | GID _v ->
                  _menhir_run_087 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
              | _ ->
                  _eRR ())
          | BR | CALL | COMMA | RET | STORE | UID _ ->
              let _v = _menhir_action_49 () in
              _menhir_goto_i_operand_list_rev _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_run_100 : type  ttv_stack. (((ttv_stack, _menhir_box_prog) _menhir_cell1_UID _menhir_cell0_cnd, _menhir_box_prog) _menhir_cell1_ty, _menhir_box_prog) _menhir_cell1_operand -> _ -> _ -> _ -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let MenhirCell1_operand (_menhir_stack, _, o1) = _menhir_stack in
      let MenhirCell1_ty (_menhir_stack, _, t) = _menhir_stack in
      let MenhirCell0_cnd (_menhir_stack, c) = _menhir_stack in
      let MenhirCell1_UID (_menhir_stack, _menhir_s, u) = _menhir_stack in
      let o2 = _v in
      let _v = _menhir_action_58 c o1 o2 t u in
      _menhir_goto_insn _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_098 : type  ttv_stack. (((ttv_stack, _menhir_box_prog) _menhir_cell1_UID _menhir_cell0_cnd, _menhir_box_prog) _menhir_cell1_ty as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_prog) _menhir_state -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_operand (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | COMMA ->
          let _menhir_s = MenhirState099 in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | UID _v ->
              _menhir_run_084 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | NULL ->
              _menhir_run_085 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | INT _v ->
              _menhir_run_086 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | GID _v ->
              _menhir_run_087 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_run_088 : type  ttv_stack. ((((ttv_stack, _menhir_box_prog) _menhir_cell1_UID, _menhir_box_prog) _menhir_cell1_ty, _menhir_box_prog) _menhir_cell1_COMMA, _menhir_box_prog) _menhir_cell1_ty -> _ -> _ -> _ -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let MenhirCell1_ty (_menhir_stack, _, t) = _menhir_stack in
      let MenhirCell1_COMMA (_menhir_stack, _) = _menhir_stack in
      let MenhirCell1_ty (_menhir_stack, _, _) = _menhir_stack in
      let MenhirCell1_UID (_menhir_stack, _menhir_s, u) = _menhir_stack in
      let o = _v in
      let _v = _menhir_action_56 o t u in
      _menhir_goto_insn _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_154 : type  ttv_stack. ((ttv_stack, _menhir_box_prog) _menhir_cell1_CALL as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_prog) _menhir_state -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_ty (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | UID _v_0 ->
          _menhir_run_084 _menhir_stack _menhir_lexbuf _menhir_lexer _v_0 MenhirState154
      | STAR ->
          _menhir_run_018 _menhir_stack _menhir_lexbuf _menhir_lexer
      | NULL ->
          _menhir_run_085 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState154
      | LPAREN ->
          _menhir_run_019 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState154
      | INT _v_1 ->
          _menhir_run_086 _menhir_stack _menhir_lexbuf _menhir_lexer _v_1 MenhirState154
      | GID _v_2 ->
          _menhir_run_087 _menhir_stack _menhir_lexbuf _menhir_lexer _v_2 MenhirState154
      | _ ->
          _eRR ()
  
  and _menhir_run_149 : type  ttv_stack. ((((ttv_stack, _menhir_box_prog) _menhir_cell1_STORE, _menhir_box_prog) _menhir_cell1_ty, _menhir_box_prog) _menhir_cell1_operand as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_prog) _menhir_state -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_ty (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | UID _v_0 ->
          _menhir_run_084 _menhir_stack _menhir_lexbuf _menhir_lexer _v_0 MenhirState149
      | STAR ->
          _menhir_run_018 _menhir_stack _menhir_lexbuf _menhir_lexer
      | NULL ->
          _menhir_run_085 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState149
      | LPAREN ->
          _menhir_run_019 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState149
      | INT _v_1 ->
          _menhir_run_086 _menhir_stack _menhir_lexbuf _menhir_lexer _v_1 MenhirState149
      | GID _v_2 ->
          _menhir_run_087 _menhir_stack _menhir_lexbuf _menhir_lexer _v_2 MenhirState149
      | _ ->
          _eRR ()
  
  and _menhir_run_146 : type  ttv_stack. ((ttv_stack, _menhir_box_prog) _menhir_cell1_STORE as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_prog) _menhir_state -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_ty (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | UID _v_0 ->
          _menhir_run_084 _menhir_stack _menhir_lexbuf _menhir_lexer _v_0 MenhirState146
      | STAR ->
          _menhir_run_018 _menhir_stack _menhir_lexbuf _menhir_lexer
      | NULL ->
          _menhir_run_085 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState146
      | LPAREN ->
          _menhir_run_019 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState146
      | INT _v_1 ->
          _menhir_run_086 _menhir_stack _menhir_lexbuf _menhir_lexer _v_1 MenhirState146
      | GID _v_2 ->
          _menhir_run_087 _menhir_stack _menhir_lexbuf _menhir_lexer _v_2 MenhirState146
      | _ ->
          _eRR ()
  
  and _menhir_run_141 : type  ttv_stack. ((ttv_stack, _menhir_box_prog) _menhir_cell1_UID _menhir_cell0_bop as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_prog) _menhir_state -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_ty (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | UID _v_0 ->
          _menhir_run_084 _menhir_stack _menhir_lexbuf _menhir_lexer _v_0 MenhirState141
      | STAR ->
          _menhir_run_018 _menhir_stack _menhir_lexbuf _menhir_lexer
      | NULL ->
          _menhir_run_085 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState141
      | LPAREN ->
          _menhir_run_019 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState141
      | INT _v_1 ->
          _menhir_run_086 _menhir_stack _menhir_lexbuf _menhir_lexer _v_1 MenhirState141
      | GID _v_2 ->
          _menhir_run_087 _menhir_stack _menhir_lexbuf _menhir_lexer _v_2 MenhirState141
      | _ ->
          _eRR ()
  
  and _menhir_run_138 : type  ttv_stack. ((ttv_stack, _menhir_box_prog) _menhir_cell1_UID as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_prog) _menhir_state -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | STAR ->
          let _menhir_stack = MenhirCell1_ty (_menhir_stack, _menhir_s, _v) in
          _menhir_run_018 _menhir_stack _menhir_lexbuf _menhir_lexer
      | LPAREN ->
          let _menhir_stack = MenhirCell1_ty (_menhir_stack, _menhir_s, _v) in
          _menhir_run_019 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState138
      | BR | CALL | RET | STORE | UID _ ->
          let MenhirCell1_UID (_menhir_stack, _menhir_s, u) = _menhir_stack in
          let t = _v in
          let _v = _menhir_action_55 t u in
          _menhir_goto_insn _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_134 : type  ttv_stack. ((((ttv_stack, _menhir_box_prog) _menhir_cell1_UID, _menhir_box_prog) _menhir_cell1_ty, _menhir_box_prog) _menhir_cell1_operand as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_prog) _menhir_state -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | STAR ->
          let _menhir_stack = MenhirCell1_ty (_menhir_stack, _menhir_s, _v) in
          _menhir_run_018 _menhir_stack _menhir_lexbuf _menhir_lexer
      | LPAREN ->
          let _menhir_stack = MenhirCell1_ty (_menhir_stack, _menhir_s, _v) in
          _menhir_run_019 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState134
      | BR | CALL | RET | STORE | UID _ ->
          let MenhirCell1_operand (_menhir_stack, _, o) = _menhir_stack in
          let MenhirCell1_ty (_menhir_stack, _, t1) = _menhir_stack in
          let MenhirCell1_UID (_menhir_stack, _menhir_s, u) = _menhir_stack in
          let t2 = _v in
          let _v = _menhir_action_61 o t1 t2 u in
          _menhir_goto_insn _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_131 : type  ttv_stack. ((ttv_stack, _menhir_box_prog) _menhir_cell1_UID as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_prog) _menhir_state -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_ty (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | UID _v_0 ->
          _menhir_run_084 _menhir_stack _menhir_lexbuf _menhir_lexer _v_0 MenhirState131
      | STAR ->
          _menhir_run_018 _menhir_stack _menhir_lexbuf _menhir_lexer
      | NULL ->
          _menhir_run_085 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState131
      | LPAREN ->
          _menhir_run_019 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState131
      | INT _v_1 ->
          _menhir_run_086 _menhir_stack _menhir_lexbuf _menhir_lexer _v_1 MenhirState131
      | GID _v_2 ->
          _menhir_run_087 _menhir_stack _menhir_lexbuf _menhir_lexer _v_2 MenhirState131
      | _ ->
          _eRR ()
  
  and _menhir_run_128 : type  ttv_stack. (((ttv_stack, _menhir_box_prog) _menhir_cell1_ty, _menhir_box_prog) _menhir_cell1_operand as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_prog) _menhir_state -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_ty (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | UID _v_0 ->
          _menhir_run_084 _menhir_stack _menhir_lexbuf _menhir_lexer _v_0 MenhirState128
      | STAR ->
          _menhir_run_018 _menhir_stack _menhir_lexbuf _menhir_lexer
      | NULL ->
          _menhir_run_085 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState128
      | LPAREN ->
          _menhir_run_019 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState128
      | INT _v_1 ->
          _menhir_run_086 _menhir_stack _menhir_lexbuf _menhir_lexer _v_1 MenhirState128
      | GID _v_2 ->
          _menhir_run_087 _menhir_stack _menhir_lexbuf _menhir_lexer _v_2 MenhirState128
      | _ ->
          _eRR ()
  
  and _menhir_run_124 : type  ttv_stack. ((((ttv_stack, _menhir_box_prog) _menhir_cell1_ty, _menhir_box_prog) _menhir_cell1_operand, _menhir_box_prog) _menhir_cell1_ty_operand_list_rev as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_prog) _menhir_state -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_ty (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | UID _v_0 ->
          _menhir_run_084 _menhir_stack _menhir_lexbuf _menhir_lexer _v_0 MenhirState124
      | STAR ->
          _menhir_run_018 _menhir_stack _menhir_lexbuf _menhir_lexer
      | NULL ->
          _menhir_run_085 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState124
      | LPAREN ->
          _menhir_run_019 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState124
      | INT _v_1 ->
          _menhir_run_086 _menhir_stack _menhir_lexbuf _menhir_lexer _v_1 MenhirState124
      | GID _v_2 ->
          _menhir_run_087 _menhir_stack _menhir_lexbuf _menhir_lexer _v_2 MenhirState124
      | _ ->
          _eRR ()
  
  and _menhir_run_119 : type  ttv_stack. ((ttv_stack, _menhir_box_prog) _menhir_cell1_UID as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_prog) _menhir_state -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_ty (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | UID _v_0 ->
          _menhir_run_084 _menhir_stack _menhir_lexbuf _menhir_lexer _v_0 MenhirState119
      | STAR ->
          _menhir_run_018 _menhir_stack _menhir_lexbuf _menhir_lexer
      | NULL ->
          _menhir_run_085 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState119
      | LPAREN ->
          _menhir_run_019 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState119
      | INT _v_1 ->
          _menhir_run_086 _menhir_stack _menhir_lexbuf _menhir_lexer _v_1 MenhirState119
      | GID _v_2 ->
          _menhir_run_087 _menhir_stack _menhir_lexbuf _menhir_lexer _v_2 MenhirState119
      | _ ->
          _eRR ()
  
  and _menhir_run_104 : type  ttv_stack. ((((ttv_stack, _menhir_box_prog) _menhir_cell1_UID, _menhir_box_prog) _menhir_cell1_ty, _menhir_box_prog) _menhir_cell1_COMMA as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_prog) _menhir_state -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_ty (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | UID _v_0 ->
          _menhir_run_084 _menhir_stack _menhir_lexbuf _menhir_lexer _v_0 MenhirState104
      | STAR ->
          _menhir_run_018 _menhir_stack _menhir_lexbuf _menhir_lexer
      | NULL ->
          _menhir_run_085 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState104
      | LPAREN ->
          _menhir_run_019 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState104
      | INT _v_1 ->
          _menhir_run_086 _menhir_stack _menhir_lexbuf _menhir_lexer _v_1 MenhirState104
      | GID _v_2 ->
          _menhir_run_087 _menhir_stack _menhir_lexbuf _menhir_lexer _v_2 MenhirState104
      | _ ->
          _eRR ()
  
  and _menhir_run_102 : type  ttv_stack. ((ttv_stack, _menhir_box_prog) _menhir_cell1_UID as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_prog) _menhir_state -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_ty (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | STAR ->
          _menhir_run_018 _menhir_stack _menhir_lexbuf _menhir_lexer
      | LPAREN ->
          _menhir_run_019 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState102
      | COMMA ->
          let _menhir_stack = MenhirCell1_COMMA (_menhir_stack, MenhirState102) in
          let _menhir_s = MenhirState103 in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | VOID ->
              _menhir_run_006 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | UID _v ->
              _menhir_run_007 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | LBRACKET ->
              _menhir_run_008 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | LBRACE ->
              _menhir_run_011 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | I8 ->
              _menhir_run_012 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | I64 ->
              _menhir_run_013 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | I1 ->
              _menhir_run_014 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_run_097 : type  ttv_stack. ((ttv_stack, _menhir_box_prog) _menhir_cell1_UID _menhir_cell0_cnd as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_prog) _menhir_state -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_ty (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | UID _v_0 ->
          _menhir_run_084 _menhir_stack _menhir_lexbuf _menhir_lexer _v_0 MenhirState097
      | STAR ->
          _menhir_run_018 _menhir_stack _menhir_lexbuf _menhir_lexer
      | NULL ->
          _menhir_run_085 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState097
      | LPAREN ->
          _menhir_run_019 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState097
      | INT _v_1 ->
          _menhir_run_086 _menhir_stack _menhir_lexbuf _menhir_lexer _v_1 MenhirState097
      | GID _v_2 ->
          _menhir_run_087 _menhir_stack _menhir_lexbuf _menhir_lexer _v_2 MenhirState097
      | _ ->
          _eRR ()
  
  and _menhir_run_083 : type  ttv_stack. ((((ttv_stack, _menhir_box_prog) _menhir_cell1_UID, _menhir_box_prog) _menhir_cell1_ty, _menhir_box_prog) _menhir_cell1_COMMA as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_prog) _menhir_state -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_ty (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | UID _v_0 ->
          _menhir_run_084 _menhir_stack _menhir_lexbuf _menhir_lexer _v_0 MenhirState083
      | STAR ->
          _menhir_run_018 _menhir_stack _menhir_lexbuf _menhir_lexer
      | NULL ->
          _menhir_run_085 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState083
      | LPAREN ->
          _menhir_run_019 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState083
      | INT _v_1 ->
          _menhir_run_086 _menhir_stack _menhir_lexbuf _menhir_lexer _v_1 MenhirState083
      | GID _v_2 ->
          _menhir_run_087 _menhir_stack _menhir_lexbuf _menhir_lexer _v_2 MenhirState083
      | _ ->
          _eRR ()
  
  and _menhir_run_081 : type  ttv_stack. ((ttv_stack, _menhir_box_prog) _menhir_cell1_UID as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_prog) _menhir_state -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_ty (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | STAR ->
          _menhir_run_018 _menhir_stack _menhir_lexbuf _menhir_lexer
      | LPAREN ->
          _menhir_run_019 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState081
      | COMMA ->
          let _menhir_stack = MenhirCell1_COMMA (_menhir_stack, MenhirState081) in
          let _menhir_s = MenhirState082 in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | VOID ->
              _menhir_run_006 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | UID _v ->
              _menhir_run_007 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | LBRACKET ->
              _menhir_run_008 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | LBRACE ->
              _menhir_run_011 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | I8 ->
              _menhir_run_012 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | I64 ->
              _menhir_run_013 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | I1 ->
              _menhir_run_014 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_run_064 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_prog) _menhir_state -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | UID _v_0 ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let (t, u) = (_v, _v_0) in
          let _v = _menhir_action_01 t u in
          _menhir_goto_arg _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | STAR ->
          let _menhir_stack = MenhirCell1_ty (_menhir_stack, _menhir_s, _v) in
          _menhir_run_018 _menhir_stack _menhir_lexbuf _menhir_lexer
      | LPAREN ->
          let _menhir_stack = MenhirCell1_ty (_menhir_stack, _menhir_s, _v) in
          _menhir_run_019 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState064
      | _ ->
          _eRR ()
  
  and _menhir_goto_arg : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_prog) _menhir_state -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match _menhir_s with
      | MenhirState063 ->
          _menhir_run_187 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState067 ->
          _menhir_run_068 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_187 : type  ttv_stack. (((ttv_stack _menhir_cell0_decls_rev, _menhir_box_prog) _menhir_cell1_ty, _menhir_box_prog) _menhir_cell1_GID as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_prog) _menhir_state -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let a = _v in
      let _v = _menhir_action_04 a in
      _menhir_goto_arg_list_rev _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_goto_arg_list_rev : type  ttv_stack. (((ttv_stack _menhir_cell0_decls_rev, _menhir_box_prog) _menhir_cell1_ty, _menhir_box_prog) _menhir_cell1_GID as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_prog) _menhir_state -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | COMMA ->
          let _menhir_stack = MenhirCell1_arg_list_rev (_menhir_stack, _menhir_s, _v) in
          let _menhir_s = MenhirState067 in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | VOID ->
              _menhir_run_006 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | UID _v ->
              _menhir_run_007 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | LBRACKET ->
              _menhir_run_008 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | LBRACE ->
              _menhir_run_011 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | I8 ->
              _menhir_run_012 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | I64 ->
              _menhir_run_013 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | I1 ->
              _menhir_run_014 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | _ ->
              _eRR ())
      | RPAREN ->
          let a = _v in
          let _v = _menhir_action_02 a in
          let _menhir_stack = MenhirCell1_arg_list (_menhir_stack, _menhir_s, _v) in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | LBRACE ->
              let _tok = _menhir_lexer _menhir_lexbuf in
              (match (_tok : MenhirBasics.token) with
              | UID _v_0 ->
                  _menhir_run_072 _menhir_stack _menhir_lexbuf _menhir_lexer _v_0 MenhirState071
              | STORE ->
                  _menhir_run_145 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState071
              | ENTRY ->
                  let _menhir_stack = MenhirCell1_ENTRY (_menhir_stack, MenhirState071) in
                  let _tok = _menhir_lexer _menhir_lexbuf in
                  (match (_tok : MenhirBasics.token) with
                  | COLON ->
                      let _tok = _menhir_lexer _menhir_lexbuf in
                      (match (_tok : MenhirBasics.token) with
                      | UID _v_1 ->
                          _menhir_run_072 _menhir_stack _menhir_lexbuf _menhir_lexer _v_1 MenhirState152
                      | STORE ->
                          _menhir_run_145 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState152
                      | CALL ->
                          _menhir_run_153 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState152
                      | BR | RET ->
                          let _v_2 = _menhir_action_64 () in
                          _menhir_run_159 _menhir_stack _menhir_lexbuf _menhir_lexer _v_2 MenhirState152 _tok
                      | _ ->
                          _eRR ())
                  | _ ->
                      _eRR ())
              | CALL ->
                  _menhir_run_153 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState071
              | BR | RET ->
                  let _v_3 = _menhir_action_64 () in
                  _menhir_run_159 _menhir_stack _menhir_lexbuf _menhir_lexer _v_3 MenhirState071 _tok
              | _ ->
                  _eRR ())
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_run_068 : type  ttv_stack. (((ttv_stack _menhir_cell0_decls_rev, _menhir_box_prog) _menhir_cell1_ty, _menhir_box_prog) _menhir_cell1_GID, _menhir_box_prog) _menhir_cell1_arg_list_rev -> _ -> _ -> _ -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let MenhirCell1_arg_list_rev (_menhir_stack, _menhir_s, args) = _menhir_stack in
      let a = _v in
      let _v = _menhir_action_05 a args in
      _menhir_goto_arg_list_rev _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_061 : type  ttv_stack. (ttv_stack _menhir_cell0_decls_rev as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_prog) _menhir_state -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_ty (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | STAR ->
          _menhir_run_018 _menhir_stack _menhir_lexbuf _menhir_lexer
      | LPAREN ->
          _menhir_run_019 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState061
      | GID _v_0 ->
          let _menhir_stack = MenhirCell1_GID (_menhir_stack, MenhirState061, _v_0) in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | LPAREN ->
              let _menhir_s = MenhirState063 in
              let _tok = _menhir_lexer _menhir_lexbuf in
              (match (_tok : MenhirBasics.token) with
              | VOID ->
                  _menhir_run_006 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | UID _v ->
                  _menhir_run_007 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
              | LBRACKET ->
                  _menhir_run_008 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | LBRACE ->
                  _menhir_run_011 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | I8 ->
                  _menhir_run_012 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | I64 ->
                  _menhir_run_013 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | I1 ->
                  _menhir_run_014 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | COMMA | RPAREN ->
                  let _v = _menhir_action_03 () in
                  _menhir_goto_arg_list_rev _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
              | _ ->
                  _eRR ())
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_run_059 : type  ttv_stack. (ttv_stack _menhir_cell0_decls_rev _menhir_cell0_GID as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_prog) _menhir_state -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | STAR ->
          let _menhir_stack = MenhirCell1_ty (_menhir_stack, _menhir_s, _v) in
          _menhir_run_018 _menhir_stack _menhir_lexbuf _menhir_lexer
      | LPAREN ->
          let _menhir_stack = MenhirCell1_ty (_menhir_stack, _menhir_s, _v) in
          _menhir_run_019 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState059
      | DECLARE | DEFINE | EOF | GID _ | UID _ ->
          let MenhirCell0_GID (_menhir_stack, g) = _menhir_stack in
          let t = _v in
          let _v = _menhir_action_32 g t in
          _menhir_goto_edecl _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_048 : type  ttv_stack. (((((ttv_stack, _menhir_box_prog) _menhir_cell1_ty, _menhir_box_prog) _menhir_cell1_BITCAST, _menhir_box_prog) _menhir_cell1_ty, _menhir_box_prog) _menhir_cell1_ginit as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_prog) _menhir_state -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | STAR ->
          let _menhir_stack = MenhirCell1_ty (_menhir_stack, _menhir_s, _v) in
          _menhir_run_018 _menhir_stack _menhir_lexbuf _menhir_lexer
      | RPAREN ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let MenhirCell1_ginit (_menhir_stack, _, g) = _menhir_stack in
          let MenhirCell1_ty (_menhir_stack, _, t1) = _menhir_stack in
          let MenhirCell1_BITCAST (_menhir_stack, _menhir_s) = _menhir_stack in
          let t2 = _v in
          let _v = _menhir_action_47 g t1 t2 in
          _menhir_goto_ginit _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | LPAREN ->
          let _menhir_stack = MenhirCell1_ty (_menhir_stack, _menhir_s, _v) in
          _menhir_run_019 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState048
      | _ ->
          _eRR ()
  
  and _menhir_goto_ginit : type  ttv_stack. ((ttv_stack, _menhir_box_prog) _menhir_cell1_ty as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_prog) _menhir_state -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match _menhir_s with
      | MenhirState032 ->
          _menhir_run_056 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | MenhirState036 ->
          _menhir_run_053 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | MenhirState040 ->
          _menhir_run_050 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | MenhirState045 ->
          _menhir_run_046 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_056 : type  ttv_stack. (ttv_stack _menhir_cell0_decls_rev _menhir_cell0_GID, _menhir_box_prog) _menhir_cell1_ty -> _ -> _ -> _ -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let MenhirCell1_ty (_menhir_stack, _, t) = _menhir_stack in
      let MenhirCell0_GID (_menhir_stack, g) = _menhir_stack in
      let gi = _v in
      let _v = _menhir_action_36 g gi t in
      let MenhirCell0_decls_rev (_menhir_stack, ds) = _menhir_stack in
      let g = _v in
      let _v = _menhir_action_28 ds g in
      _menhir_goto_decls_rev _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
  
  and _menhir_run_053 : type  ttv_stack. (ttv_stack, _menhir_box_prog) _menhir_cell1_ty -> _ -> _ -> _ -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let MenhirCell1_ty (_menhir_stack, _menhir_s, t) = _menhir_stack in
      let g = _v in
      let _v = _menhir_action_39 g t in
      _menhir_goto_gdecl_list_rev _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_goto_gdecl_list_rev : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_prog) _menhir_state -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | COMMA ->
          let _menhir_stack = MenhirCell1_gdecl_list_rev (_menhir_stack, _menhir_s, _v) in
          let _menhir_s = MenhirState039 in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | VOID ->
              _menhir_run_006 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | UID _v ->
              _menhir_run_007 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | LBRACKET ->
              _menhir_run_008 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | LBRACE ->
              _menhir_run_011 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | I8 ->
              _menhir_run_012 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | I64 ->
              _menhir_run_013 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | I1 ->
              _menhir_run_014 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | _ ->
              _eRR ())
      | RBRACE | RBRACKET ->
          let gs = _v in
          let _v = _menhir_action_37 gs in
          _menhir_goto_gdecl_list _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_goto_gdecl_list : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_prog) _menhir_state -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match _menhir_s with
      | MenhirState035 ->
          _menhir_run_054 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | MenhirState037 ->
          _menhir_run_051 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_054 : type  ttv_stack. ((ttv_stack, _menhir_box_prog) _menhir_cell1_ty, _menhir_box_prog) _menhir_cell1_LBRACKET -> _ -> _ -> _ -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      match (_tok : MenhirBasics.token) with
      | RBRACKET ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let MenhirCell1_LBRACKET (_menhir_stack, _menhir_s) = _menhir_stack in
          let gs = _v in
          let _v = _menhir_action_45 gs in
          _menhir_goto_ginit _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_051 : type  ttv_stack. ((ttv_stack, _menhir_box_prog) _menhir_cell1_ty, _menhir_box_prog) _menhir_cell1_LBRACE -> _ -> _ -> _ -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      match (_tok : MenhirBasics.token) with
      | RBRACE ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let MenhirCell1_LBRACE (_menhir_stack, _menhir_s) = _menhir_stack in
          let gs = _v in
          let _v = _menhir_action_46 gs in
          _menhir_goto_ginit _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_050 : type  ttv_stack. ((ttv_stack, _menhir_box_prog) _menhir_cell1_gdecl_list_rev, _menhir_box_prog) _menhir_cell1_ty -> _ -> _ -> _ -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let MenhirCell1_ty (_menhir_stack, _, t) = _menhir_stack in
      let MenhirCell1_gdecl_list_rev (_menhir_stack, _menhir_s, gs) = _menhir_stack in
      let g = _v in
      let _v = _menhir_action_40 g gs t in
      _menhir_goto_gdecl_list_rev _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_046 : type  ttv_stack. ((((ttv_stack, _menhir_box_prog) _menhir_cell1_ty, _menhir_box_prog) _menhir_cell1_BITCAST, _menhir_box_prog) _menhir_cell1_ty as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_prog) _menhir_state -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_ginit (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | TO ->
          let _menhir_s = MenhirState047 in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | VOID ->
              _menhir_run_006 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | UID _v ->
              _menhir_run_007 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | LBRACKET ->
              _menhir_run_008 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | LBRACE ->
              _menhir_run_011 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | I8 ->
              _menhir_run_012 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | I64 ->
              _menhir_run_013 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | I1 ->
              _menhir_run_014 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_run_045 : type  ttv_stack. (((ttv_stack, _menhir_box_prog) _menhir_cell1_ty, _menhir_box_prog) _menhir_cell1_BITCAST as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_prog) _menhir_state -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_ty (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | STRING _v_0 ->
          _menhir_run_033 _menhir_stack _menhir_lexbuf _menhir_lexer _v_0 MenhirState045
      | STAR ->
          _menhir_run_018 _menhir_stack _menhir_lexbuf _menhir_lexer
      | NULL ->
          _menhir_run_034 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState045
      | LPAREN ->
          _menhir_run_019 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState045
      | LBRACKET ->
          _menhir_run_035 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState045
      | LBRACE ->
          _menhir_run_037 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState045
      | INT _v_1 ->
          _menhir_run_041 _menhir_stack _menhir_lexbuf _menhir_lexer _v_1 MenhirState045
      | GID _v_2 ->
          _menhir_run_042 _menhir_stack _menhir_lexbuf _menhir_lexer _v_2 MenhirState045
      | BITCAST ->
          _menhir_run_043 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState045
      | _ ->
          _eRR ()
  
  and _menhir_run_033 : type  ttv_stack. ((ttv_stack, _menhir_box_prog) _menhir_cell1_ty as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_prog) _menhir_state -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      let s = _v in
      let _v = _menhir_action_44 s in
      _menhir_goto_ginit _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_034 : type  ttv_stack. ((ttv_stack, _menhir_box_prog) _menhir_cell1_ty as 'stack) -> _ -> _ -> ('stack, _menhir_box_prog) _menhir_state -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      let _v = _menhir_action_41 () in
      _menhir_goto_ginit _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_035 : type  ttv_stack. ((ttv_stack, _menhir_box_prog) _menhir_cell1_ty as 'stack) -> _ -> _ -> ('stack, _menhir_box_prog) _menhir_state -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_LBRACKET (_menhir_stack, _menhir_s) in
      let _menhir_s = MenhirState035 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | VOID ->
          _menhir_run_006 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | UID _v ->
          _menhir_run_007 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | LBRACKET ->
          _menhir_run_008 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LBRACE ->
          _menhir_run_011 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | I8 ->
          _menhir_run_012 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | I64 ->
          _menhir_run_013 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | I1 ->
          _menhir_run_014 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | COMMA | RBRACKET ->
          _menhir_reduce_38 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_reduce_38 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_prog) _menhir_state -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s _tok ->
      let _v = _menhir_action_38 () in
      _menhir_goto_gdecl_list_rev _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_037 : type  ttv_stack. ((ttv_stack, _menhir_box_prog) _menhir_cell1_ty as 'stack) -> _ -> _ -> ('stack, _menhir_box_prog) _menhir_state -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_LBRACE (_menhir_stack, _menhir_s) in
      let _menhir_s = MenhirState037 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | VOID ->
          _menhir_run_006 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | UID _v ->
          _menhir_run_007 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | LBRACKET ->
          _menhir_run_008 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LBRACE ->
          _menhir_run_011 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | I8 ->
          _menhir_run_012 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | I64 ->
          _menhir_run_013 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | I1 ->
          _menhir_run_014 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | COMMA | RBRACE ->
          _menhir_reduce_38 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_041 : type  ttv_stack. ((ttv_stack, _menhir_box_prog) _menhir_cell1_ty as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_prog) _menhir_state -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      let i = _v in
      let _v = _menhir_action_43 i in
      _menhir_goto_ginit _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_042 : type  ttv_stack. ((ttv_stack, _menhir_box_prog) _menhir_cell1_ty as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_prog) _menhir_state -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      let g = _v in
      let _v = _menhir_action_42 g in
      _menhir_goto_ginit _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_043 : type  ttv_stack. ((ttv_stack, _menhir_box_prog) _menhir_cell1_ty as 'stack) -> _ -> _ -> ('stack, _menhir_box_prog) _menhir_state -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_BITCAST (_menhir_stack, _menhir_s) in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | LPAREN ->
          let _menhir_s = MenhirState044 in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | VOID ->
              _menhir_run_006 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | UID _v ->
              _menhir_run_007 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | LBRACKET ->
              _menhir_run_008 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | LBRACE ->
              _menhir_run_011 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | I8 ->
              _menhir_run_012 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | I64 ->
              _menhir_run_013 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | I1 ->
              _menhir_run_014 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_run_040 : type  ttv_stack. ((ttv_stack, _menhir_box_prog) _menhir_cell1_gdecl_list_rev as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_prog) _menhir_state -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_ty (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | STRING _v_0 ->
          _menhir_run_033 _menhir_stack _menhir_lexbuf _menhir_lexer _v_0 MenhirState040
      | STAR ->
          _menhir_run_018 _menhir_stack _menhir_lexbuf _menhir_lexer
      | NULL ->
          _menhir_run_034 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState040
      | LPAREN ->
          _menhir_run_019 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState040
      | LBRACKET ->
          _menhir_run_035 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState040
      | LBRACE ->
          _menhir_run_037 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState040
      | INT _v_1 ->
          _menhir_run_041 _menhir_stack _menhir_lexbuf _menhir_lexer _v_1 MenhirState040
      | GID _v_2 ->
          _menhir_run_042 _menhir_stack _menhir_lexbuf _menhir_lexer _v_2 MenhirState040
      | BITCAST ->
          _menhir_run_043 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState040
      | _ ->
          _eRR ()
  
  and _menhir_run_036 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_prog) _menhir_state -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_ty (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | STRING _v_0 ->
          _menhir_run_033 _menhir_stack _menhir_lexbuf _menhir_lexer _v_0 MenhirState036
      | STAR ->
          _menhir_run_018 _menhir_stack _menhir_lexbuf _menhir_lexer
      | NULL ->
          _menhir_run_034 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState036
      | LPAREN ->
          _menhir_run_019 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState036
      | LBRACKET ->
          _menhir_run_035 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState036
      | LBRACE ->
          _menhir_run_037 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState036
      | INT _v_1 ->
          _menhir_run_041 _menhir_stack _menhir_lexbuf _menhir_lexer _v_1 MenhirState036
      | GID _v_2 ->
          _menhir_run_042 _menhir_stack _menhir_lexbuf _menhir_lexer _v_2 MenhirState036
      | BITCAST ->
          _menhir_run_043 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState036
      | _ ->
          _eRR ()
  
  and _menhir_run_032 : type  ttv_stack. (ttv_stack _menhir_cell0_decls_rev _menhir_cell0_GID as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_prog) _menhir_state -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_ty (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | STRING _v_0 ->
          _menhir_run_033 _menhir_stack _menhir_lexbuf _menhir_lexer _v_0 MenhirState032
      | STAR ->
          _menhir_run_018 _menhir_stack _menhir_lexbuf _menhir_lexer
      | NULL ->
          _menhir_run_034 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState032
      | LPAREN ->
          _menhir_run_019 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState032
      | LBRACKET ->
          _menhir_run_035 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState032
      | LBRACE ->
          _menhir_run_037 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState032
      | INT _v_1 ->
          _menhir_run_041 _menhir_stack _menhir_lexbuf _menhir_lexer _v_1 MenhirState032
      | GID _v_2 ->
          _menhir_run_042 _menhir_stack _menhir_lexbuf _menhir_lexer _v_2 MenhirState032
      | BITCAST ->
          _menhir_run_043 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState032
      | _ ->
          _eRR ()
  
  and _menhir_run_028 : type  ttv_stack. (ttv_stack _menhir_cell0_decls_rev _menhir_cell0_UID as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_prog) _menhir_state -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | STAR ->
          let _menhir_stack = MenhirCell1_ty (_menhir_stack, _menhir_s, _v) in
          _menhir_run_018 _menhir_stack _menhir_lexbuf _menhir_lexer
      | LPAREN ->
          let _menhir_stack = MenhirCell1_ty (_menhir_stack, _menhir_s, _v) in
          _menhir_run_019 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState028
      | DECLARE | DEFINE | EOF | GID _ | UID _ ->
          let MenhirCell0_UID (_menhir_stack, tid) = _menhir_stack in
          let t = _v in
          let _v = _menhir_action_83 t tid in
          let MenhirCell0_decls_rev (_menhir_stack, ds) = _menhir_stack in
          let t = _v in
          let _v = _menhir_action_29 ds t in
          _menhir_goto_decls_rev _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_026 : type  ttv_stack. ((ttv_stack, _menhir_box_prog) _menhir_cell1_LBRACKET _menhir_cell0_INT as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_prog) _menhir_state -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | STAR ->
          let _menhir_stack = MenhirCell1_ty (_menhir_stack, _menhir_s, _v) in
          _menhir_run_018 _menhir_stack _menhir_lexbuf _menhir_lexer
      | RBRACKET ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let MenhirCell0_INT (_menhir_stack, i) = _menhir_stack in
          let MenhirCell1_LBRACKET (_menhir_stack, _menhir_s) = _menhir_stack in
          let t = _v in
          let _v = _menhir_action_73 i t in
          _menhir_goto_nonptr_ty _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | LPAREN ->
          let _menhir_stack = MenhirCell1_ty (_menhir_stack, _menhir_s, _v) in
          _menhir_run_019 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState026
      | _ ->
          _eRR ()
  
  and _menhir_run_022 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_prog) _menhir_state -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | STAR ->
          let _menhir_stack = MenhirCell1_ty (_menhir_stack, _menhir_s, _v) in
          _menhir_run_018 _menhir_stack _menhir_lexbuf _menhir_lexer
      | LPAREN ->
          let _menhir_stack = MenhirCell1_ty (_menhir_stack, _menhir_s, _v) in
          _menhir_run_019 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState022
      | COMMA | RBRACE | RPAREN ->
          let t = _v in
          let _v = _menhir_action_91 t in
          _menhir_goto_ty_list_rev _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_goto_ty_list_rev : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_prog) _menhir_state -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | COMMA ->
          let _menhir_stack = MenhirCell1_ty_list_rev (_menhir_stack, _menhir_s, _v) in
          let _menhir_s = MenhirState016 in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | VOID ->
              _menhir_run_006 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | UID _v ->
              _menhir_run_007 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | LBRACKET ->
              _menhir_run_008 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | LBRACE ->
              _menhir_run_011 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | I8 ->
              _menhir_run_012 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | I64 ->
              _menhir_run_013 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | I1 ->
              _menhir_run_014 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | _ ->
              _eRR ())
      | RBRACE | RPAREN ->
          let ts = _v in
          let _v = _menhir_action_90 ts in
          _menhir_goto_ty_list _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _menhir_fail ()
  
  and _menhir_goto_ty_list : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_prog) _menhir_state -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match _menhir_s with
      | MenhirState011 ->
          _menhir_run_024 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | MenhirState019 ->
          _menhir_run_020 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_024 : type  ttv_stack. (ttv_stack, _menhir_box_prog) _menhir_cell1_LBRACE -> _ -> _ -> _ -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      match (_tok : MenhirBasics.token) with
      | RBRACE ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let MenhirCell1_LBRACE (_menhir_stack, _menhir_s) = _menhir_stack in
          let ts = _v in
          let _v = _menhir_action_72 ts in
          _menhir_goto_nonptr_ty _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_020 : type  ttv_stack. ((ttv_stack, _menhir_box_prog) _menhir_cell1_ty, _menhir_box_prog) _menhir_cell1_LPAREN -> _ -> _ -> _ -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      match (_tok : MenhirBasics.token) with
      | RPAREN ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let MenhirCell1_LPAREN (_menhir_stack, _) = _menhir_stack in
          let MenhirCell1_ty (_menhir_stack, _menhir_s, rt) = _menhir_stack in
          let ts = _v in
          let _v = _menhir_action_74 rt ts in
          _menhir_goto_nonptr_ty _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_017 : type  ttv_stack. ((ttv_stack, _menhir_box_prog) _menhir_cell1_ty_list_rev as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_prog) _menhir_state -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | STAR ->
          let _menhir_stack = MenhirCell1_ty (_menhir_stack, _menhir_s, _v) in
          _menhir_run_018 _menhir_stack _menhir_lexbuf _menhir_lexer
      | LPAREN ->
          let _menhir_stack = MenhirCell1_ty (_menhir_stack, _menhir_s, _v) in
          _menhir_run_019 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState017
      | COMMA | RBRACE | RPAREN ->
          let MenhirCell1_ty_list_rev (_menhir_stack, _menhir_s, ts) = _menhir_stack in
          let t = _v in
          let _v = _menhir_action_92 t ts in
          _menhir_goto_ty_list_rev _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  let _menhir_run_000 : type  ttv_stack. ttv_stack -> _ -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      let _v = _menhir_action_26 () in
      _menhir_goto_decls_rev _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
  
end

let prog =
  fun _menhir_lexer _menhir_lexbuf ->
    let _menhir_stack = () in
    let MenhirBox_prog v = _menhir_run_000 _menhir_stack _menhir_lexbuf _menhir_lexer in
    v
