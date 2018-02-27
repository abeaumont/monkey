let test_next_token_1 =
  let input =
    "let five = 5;
let ten = 10;

let add = fn(x, y) {
  x + y;
};

let result = add(five, ten);
!-/*5;
5 < 10 > 5;

if (5 < 10) {
  return true;
} else {
  return false;
}

10 == 10;
10 != 9;
"
  and tests =
    let open Token in
    let open Type in [
      create Let "let";
      create Ident "five";
      create Assign "=";
      create Int "5";
      create Semicolon ";";
      create Let "let";
      create Ident "ten";
      create Assign "=";
      create Int "10";
      create Semicolon ";";
      create Let "let";
      create Ident "add";
      create Assign "=";
      create Function "fn";
      create Lparen "(";
      create Ident "x";
      create Comma ",";
      create Ident "y";
      create Rparen ")";
      create Lbrace "{";
      create Ident "x";
      create Plus "+";
      create Ident "y";
      create Semicolon ";";
      create Rbrace "}";
      create Semicolon ";";
      create Let "let";
      create Ident "result";
      create Assign "=";
      create Ident "add";
      create Lparen "(";
      create Ident "five";
      create Comma ",";
      create Ident "ten";
      create Rparen ")";
      create Semicolon ";";
      create Bang "!";
      create Minus "-";
      create Slash "/";
      create Asterisk "*";
      create Int "5";
      create Semicolon ";";
      create Int "5";
      create Lt "<";
      create Int "10";
      create Gt ">";
      create Int "5";
      create Semicolon ";";
      create If "if";
      create Lparen "(";
      create Int "5";
      create Lt "<";
      create Int "10";
      create Rparen ")";
      create Lbrace "{";
      create Return "return";
      create True "true";
      create Semicolon ";";
      create Rbrace "}";
      create Else "else";
      create Lbrace "{";
      create Return "return";
      create False "false";
      create Semicolon ";";
      create Rbrace "}";
      create Int "10";
      create Eq "==";
      create Int "10";
      create Semicolon ";";
      create Int "10";
      create NotEq "!=";
      create Int "9";
      create Semicolon ";";
      create Eof ""
    ] in
  let lexer = Lexer.create input in
  fun () ->
    let f token =
      let expected_type = Token.to_type token |> Token.Type.to_string
      and expected_literal = Token.to_string token
      and token' = Lexer.next_token lexer in
      let type_ = Token.to_type token' |> Token.Type.to_string
      and literal = Token.to_string token in
      Alcotest.check Alcotest.string "token type" expected_type type_ ;
      Alcotest.check Alcotest.string "token literal" expected_literal literal in
    List.iter f tests

let next_token_tests = [("Test Case 1", `Quick, test_next_token_1)]

let () = Alcotest.run "Lexer Tests" [("Next Token Tests", next_token_tests)]
