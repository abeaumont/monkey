module Type = struct
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

  let to_string = Variants.to_name

  let lookup_ident = function
    | "fn" -> Function
    | "let" -> Let
    | "true" -> True
    | "false" -> False
    | "if" -> If
    | "else" -> Else
    | "return" -> Return
    | _ -> Ident
end

type t = Type.t * string

let create t s = (t, s)

let to_type = fst

let to_string = snd
