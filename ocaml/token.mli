module Type : sig
  type t =
    | Illegal | Eof
    (* Identifiers + literals *)
    | Ident  (* add, foobar, x, y, ... *) | Int  (* 1343456 *)
    (* Operators *)
    | Assign | Plus | Minus | Bang | Asterisk | Slash | Lt | Gt | Eq | NotEq
    (* Delimiters *)
    | Comma | Semicolon | Lparen | Rparen | Lbrace | Rbrace
    (* Keywords *)
    | Function | Let | True | False | If | Else | Return
  [@@deriving variants]

  val to_string : t -> string

  val lookup_ident : string -> t
end

type t

val create : Type.t -> string -> t

val to_type : t -> Type.t

val to_string : t -> string
