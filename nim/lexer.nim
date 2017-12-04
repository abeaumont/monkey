import future
import strutils
import token

type
  Lexer = ref object
    input: string
    position: int # current position in input (points to current char)
    readPosition: int # current position in input (after current char)
    ch: char # current char under examination

proc isLetter(ch: char): bool = ch.isAlphaNumeric or ch == '_'

proc readChar(lexer: Lexer) =
  if lexer.readPosition > len(lexer.input):
    lexer.ch = '\0'
  else:
    lexer.ch = lexer.input[lexer.readPosition]
  lexer.position = lexer.readPosition
  lexer.readPosition.inc

template read(lexer: Lexer, fn: (x: char) -> bool): string =
  var position = lexer.position
  while lexer.ch.fn:
    lexer.readChar
  lexer.input[position..<lexer.position]

proc readIdentifier(lexer: Lexer): string = lexer.read(isLetter)

proc readNumber(lexer: Lexer): string = lexer.read(isDigit)

proc skipWhitespace(lexer: Lexer) =
  while lexer.ch.isSpaceAscii():
    lexer.readChar

proc newLexer*(input: string): Lexer =
  result = Lexer(input: input)
  result.readChar

proc nextToken*(lexer: Lexer): Token =
  lexer.skipWhitespace

  case lexer.ch:
    of '=':
      result = newToken(Assign, lexer.ch)
    of ';':
      result = newToken(Semicolon, lexer.ch)
    of '(':
      result = newToken(Lparen, lexer.ch)
    of ')':
      result = newToken(Rparen, lexer.ch)
    of ',':
      result = newToken(Comma, lexer.ch)
    of '+':
      result = newToken(Plus, lexer.ch)
    of '{':
      result = newToken(Lbrace, lexer.ch)
    of '}':
      result = newToken(Rbrace, lexer.ch)
    of '\0':
      result = newToken(Eof, "")
    of 'a'..'z', 'A'..'Z', '_':
      let literal = lexer.readIdentifier
      return newToken(literal.LookupIdent, literal)
    of '0'..'9':
      return newToken(Int, lexer.readNumber)
    else:
      result = newToken(Illegal, lexer.ch)

  lexer.readChar

when isMainModule:
  let
    input = """let five = 5;
let ten = 10;

let add = fn(x, y) {
  x + y;
};

let result = add(five, ten);
"""

    tests = [
      newToken(Let, "let"),
      newToken(Ident, "five"),
      newToken(Assign, "="),
      newToken(Int, "5"),
      newToken(Semicolon, ";"),
      newToken(Let, "let"),
      newToken(Ident, "ten"),
      newToken(Assign, "="),
      newToken(Int, "10"),
      newToken(Semicolon, ";"),
      newToken(Let, "let"),
      newToken(Ident, "add"),
      newToken(Assign, "="),
      newToken(Function, "fn"),
      newToken(Lparen, "("),
      newToken(Ident, "x"),
      newToken(Comma, ","),
      newToken(Ident, "y"),
      newToken(Rparen, ")"),
      newToken(Lbrace, "{"),
      newToken(Ident, "x"),
      newToken(Plus, "+"),
      newToken(Ident, "y"),
      newToken(Semicolon, ";"),
      newToken(Rbrace, "}"),
      newToken(Semicolon, ";"),
      newToken(Let, "let"),
      newToken(Ident, "result"),
      newToken(Assign, "="),
      newToken(Ident, "add"),
      newToken(Lparen, "("),
      newToken(Ident, "five"),
      newToken(Comma, ","),
      newToken(Ident, "ten"),
      newToken(Rparen, ")"),
      newToken(Semicolon, ";"),
      newToken(Eof, ""),
    ]
    lexer = newLexer(input)

  for i, tt in tests:
    let (expectedType, expectedLiteral) = tt
    let (t, literal) = lexer.nextToken()
    doAssert(t == expectedType,
             "tests[$1] - tokentype wrong. expected=`$2', got=`$3'" %
             [$i, $expectedType, $t])
    doAssert(literal == expectedLiteral,
             "tests[$1] - literal wrong. expected=`$2', got=`$3'" %
             [$i, expectedLiteral, literal])
