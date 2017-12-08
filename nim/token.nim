import tables

type
  TokenType* = enum
    Illegal,
    Eof,

    # Identfiers + literals
    Ident, # add, foobar, x, y, ...
    Int, # 1343456

    # Operators
    Assign,
    Plus,
    Minus,
    Bang,
    Asterisk,
    Slash,

    Lt,
    Gt,

    # Delimiters
    Comma,
    Semicolon,

    Lparen,
    Rparen,
    Lbrace,
    Rbrace,

    # Keywords
    Function,
    Let,
  Token* = (TokenType, string)

const Keywords* = {
  "fn": Function,
  "let": Let,
}.toTable

proc newToken*(t: TokenType, literal: string): Token = (t, literal)

proc newToken*(t: TokenType, literal: char): Token = newToken(t, $literal)

proc LookupIdent*(ident: string): TokenType =
  if Keywords.hasKey(ident):
    Keywords[ident]
  else:
    Ident

