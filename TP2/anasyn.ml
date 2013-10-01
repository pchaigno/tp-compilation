type vt = UL_EOF
	| UL_ERR 
	| UL_IDENT
	| UL_PAROUV
	| UL_PARFERM
	| UL_ET
	| UL_OU
	| UL_EGAL
	| UL_DIFF
	| UL_SUP
	| UL_INF
	| UL_SUPEGAL
	| UL_INFEGAL
	| UL_SI
	| UL_ALORS
	| UL_SINON
	| UL_FSI;;

type vn = EXPR
	| SUITEEXPR
	| TERMB
	| SUITETERMB
	| FACTEURB
	| RELATION
	| OP;;

type v = Vt of vt | Vn of vn;;

type arbre_concret = Leaf of vt | Node of v * arbre_concret list;;

let derivation = function
	| (EXPR, (UL_PAROUV | UL_SI | UL_IDENT)) -> [Vn TERMB; Vn SUITEEXPR]
	| (SUITEEXPR, UL_OU) -> [Vt UL_OU; Vn TERMB; Vn SUITEEXPR]
	| (SUITEEXPR, (UL_EOF | UL_ALORS | UL_SINON | UL_FSI)) -> []
	| (TERMB, (UL_PAROUV | UL_SI | UL_IDENT)) -> [Vn FACTEURB; Vn SUITETERMB]
	| (SUITETERMB, UL_ET) -> [Vt UL_ET; Vn FACTEURB; Vn SUITETERMB]
	| (SUITETERMB, (UL_OU | UL_EOF | UL_ALORS | UL_SINON | UL_FSI)) -> []
	| (FACTEURB, UL_PAROUV) -> [Vt UL_PAROUV; Vn EXPR; Vt UL_PARFERM]
	| (FACTEURB, UL_SI) -> [Vt UL_SI; Vn EXPR; Vt UL_ALORS; Vn EXPR; Vt UL_SINON; Vn EXPR; Vt UL_FSI]
	| (FACTEURB, UL_IDENT) -> [Vn RELATION]
	| (RELATION, UL_IDENT) -> [Vt UL_IDENT; Vn OP; Vt UL_IDENT]
	| (OP, ((UL_EGAL | UL_DIFF | UL_SUP | UL_INF | UL_SUPEGAL | UL_INFEGAL) as x)) -> [Vt x]
	| _ -> assert false;;


(*let analyse_caractere = 
	| (Vt v, p::rest) -> match p with 
			| (Leaf v, rest)
	| (Vn v, p::rest) -> (Node (v,analyse_mot ([v], rest)), rest)
and analyse_mot = 
	| ([], _) -> 
	| (p::rest, ) ->
*)
