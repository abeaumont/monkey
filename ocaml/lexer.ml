open Core_kernel

type t = {
  input: string;
  mutable position: int;
  mutable read_position: int;
  mutable ch: char
}

let read_char l =
  if l.read_position >= String.length l.input then
    l.ch <- '\000'
  else
    l.ch <- (l.input).[l.read_position];
  l.position <- l.read_position;
  l.read_position <- l.read_position + 1

let read f l =
  let pos = l.position in
  while f l.ch do read_char l done;
  Substring.create l.input ~pos ~len:(l.position - pos) |> Substring.to_string

let read_identifier = read Char.is_alpha

let read_number = read Char.is_digit

let skip_whitespace l = while Char.is_whitespace l.ch do read_char l done

let create input =
  let l = {input; position = 0; read_position = 0; ch= '\000'} in
  read_char l; l

let next_token l =
  skip_whitespace l;
  let module Type = Token.Type in
  let literal = String.of_char l.ch in
  let t = match l.ch with
    | '=' -> Token.create Type.Assign literal
    | '+' -> Token.create Type.Plus literal
    | '-' -> Token.create Type.Minus literal
    | '!' -> Token.create Type.Bang literal
    | '/' -> Token.create Type.Slash literal
    | '*' -> Token.create Type.Asterisk literal
    | '<' -> Token.create Type.Lt literal
    | '>' -> Token.create Type.Gt literal
    | ';' -> Token.create Type.Semicolon literal
    | '(' -> Token.create Type.Lparen literal
    | ')' -> Token.create Type.Rparen literal
    | ',' -> Token.create Type.Comma literal
    | '{' -> Token.create Type.Lbrace literal
    | '}' -> Token.create Type.Rbrace literal
    | '\000' -> Token.create Type.Eof ""
    | 'a'..'z' | 'A'..'Z' | '_' ->
        let literal = read_identifier l in
        Token.create (Type.lookup_ident literal) literal
    | '0'..'9' -> l |> read_number |> Token.create Type.Int
    | _ -> Token.create Type.Illegal literal
  in
  match Token.to_type t with
  | Type.Function | Type.Let | Type.True | Type.False | Type.If | Type.Else
  | Type.Return | Type.Ident | Type.Int
    -> t
  | _ -> read_char l ; t

