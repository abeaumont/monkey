package;

class LexerTestCase extends haxe.unit.TestCase {
    public function testNextToken() {
        var input = 'let five = 5;
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
}';

				var tests: Array<Token> = [
					new Token(Let, 'let'),
					new Token(Ident, 'five'),
					new Token(Assign, '='),
					new Token(Int_, '5'),
					new Token(Semicolon, ';'),
					new Token(Let, 'let'),
					new Token(Ident, 'ten'),
					new Token(Assign, '='),
					new Token(Int_, '10'),
					new Token(Semicolon, ';'),
					new Token(Let, 'let'),
					new Token(Ident, 'add'),
					new Token(Assign, '='),
					new Token(Function, 'fn'),
					new Token(Lparen, '('),
					new Token(Ident, 'x'),
					new Token(Comma, ','),
					new Token(Ident, 'y'),
					new Token(Rparen, ')'),
					new Token(Lbrace, '{'),
					new Token(Ident, 'x'),
					new Token(Plus, '+'),
					new Token(Ident, 'y'),
					new Token(Semicolon, ';'),
					new Token(Rbrace, '}'),
					new Token(Semicolon, ';'),
					new Token(Let, 'let'),
					new Token(Ident, 'result'),
					new Token(Assign, '='),
					new Token(Ident, 'add'),
					new Token(Lparen, '('),
					new Token(Ident, 'five'),
					new Token(Comma, ','),
					new Token(Ident, 'ten'),
					new Token(Rparen, ')'),
					new Token(Semicolon, ';'),
					new Token(Bang, '!'),
					new Token(Minus, '-'),
					new Token(Slash, '/'),
					new Token(Asterisk, '*'),
					new Token(Int_, '5'),
					new Token(Semicolon, ';'),
					new Token(Int_, '5'),
					new Token(Lt, '<'),
					new Token(Int_, '10'),
					new Token(Gt, '>'),
					new Token(Int_, '5'),
					new Token(Semicolon, ';'),
					new Token(If, 'if'),
					new Token(Lparen, '('),
					new Token(Int_, '5'),
					new Token(Lt, '<'),
					new Token(Int_, '10'),
					new Token(Rparen, ')'),
					new Token(Lbrace, '{'),
					new Token(Return, 'return'),
					new Token(True, 'true'),
					new Token(Semicolon, ';'),
					new Token(Rbrace, '}'),
					new Token(Else, 'else'),
					new Token(Lbrace, '{'),
					new Token(Return, 'return'),
					new Token(False, 'false'),
					new Token(Semicolon, ';'),
					new Token(Rbrace, '}'),
					new Token(Eof, ''),
				];

				var l = new Lexer(input);
				for (expected in tests) {
					var token = l.nextToken();
					assertEquals(expected.type, token.type);
					assertEquals(expected.literal, token.literal);
				}
		}
}

