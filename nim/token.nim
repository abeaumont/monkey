type
  TokenType* = string
  Token* = (string, string)

const
  Illegal* = "ILLEGAL"
  Eof* = "EOF"

  # Identfiers + literals
  Ident* = "IDENT" # add, foobar, x, y, ...
  Int* = "INT" # 1343456

  # Operators
  Assign* = "="
  Plus* = "+"

  # Delimiters
  Comma* = ","
  Semicolon* = ";"

  Lparen* = "("
  Rparen* = ")"
  Lbrace* = "{"
  Rbrace* = "}"

  # Keywords
  Function* = "FUNCTION"
  Let* = "LET"

proc newToken*(t: TokenType, literal: string): Token = (t, literal)
proc newToken*(t: TokenType, literal: char): Token = newToken(t, $literal)
