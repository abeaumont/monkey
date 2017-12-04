import strutils
import token

type
  Lexer = ref object
    input: string
    position: int # current position in input (points to current char)
    readPosition: int # current position in input (after current char)
    ch: char # current char under examination

proc readChar(lexer: Lexer) =
  if lexer.readPosition > len(lexer.input):
    lexer.ch = '\0'
  else:
    lexer.ch = lexer.input[lexer.readPosition]
  lexer.position = lexer.readPosition
  lexer.readPosition += 1

proc newLexer*(input: string): Lexer =
  result = Lexer(input: input)
  result.readChar

proc nextToken*(lexer: Lexer): Token =
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
    else: discard

  lexer.readChar

when isMainModule:
  let
    input = "=+(){},;"
    tests = [
      newToken(Assign, "="),
      newToken(Plus, "+"),
      newToken(Lparen, "("),
      newToken(Rparen, ")"),
      newToken(Lbrace, "{"),
      newToken(Rbrace, "}"),
      newToken(Comma, ","),
      newToken(Semicolon, ";"),
      newToken(Eof, "")
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
