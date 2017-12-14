module Type = struct
  type t =
    | Illegal
    | Eof
    (* Identifiers + literals *)
    | Ident  (** add, foobar, x, y, ... *)
    | Int  (** 1343456 *)
    (* Operators *)
    | Assign
    | Plus
    | Minus
    | Bang
    | Asterisk
    | Slash
    | Lt
    | Gt
    (* Delimiters *)
    | Comma
    | Semicolon
    | Lparen
    | Rparen
    | Lbrace
    | Rbrace
    (* Keywords *)
    | Function
    | Let
    | True
    | False
    | If
    | Else
    | Return

  let to_string = function
    | Illegal -> "ILLEGAL"
    | Eof -> "EOF"
    | Ident -> "IDENT"
    | Int -> "INT"
    | Assign -> "ASSIGN"
    | Plus -> "PLUS"
    | Minus -> "MINUS"
    | Bang -> "BANG"
    | Asterisk -> "ASTERISK"
    | Slash -> "SLASH"
    | Lt -> "LT"
    | Gt -> "GT"
    | Comma -> "COMMA"
    | Semicolon -> "SEMICOLON"
    | Lparen -> "LPAREN"
    | Rparen -> "RPAREN"
    | Lbrace -> "LBRACE"
    | Rbrace -> "RBRACE"
    | Function -> "FUNCTION"
    | Let -> "LET"
    | True -> "TRUE"
    | False -> "FALSE"
    | If -> "IF"
    | Else -> "ELSE"
    | Return -> "RETURN"


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
