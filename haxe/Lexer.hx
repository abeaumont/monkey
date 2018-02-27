class Lexer {
	var input: String;
	var position= 0;
	var read_position = 0;
	var ch: String;

	public function new(_input: String) {
		input = _input;
		readChar();
	}

	public function nextToken(): Token {
		skipWhitespace();
		var type: TokenType = switch ch {
			case '=' if (peekChar() == '='): Eq;
			case '=': Assign;
			case '+': Plus;
			case '-': Minus;
			case '!' if (peekChar() == '='): NotEq;
			case '!': Bang;
			case '/': Slash;
			case '*': Asterisk;
			case '<': Lt;
			case '>': Gt;
			case ';': Semicolon;
			case '(': Lparen;
			case ')': Rparen;
			case ',': Comma;
			case '{': Lbrace;
			case '}': Rbrace;
			case '': Eof;
			case _ if (isLetter()): Ident;
			case _ if (isDigit()): Int_;
			case _: Illegal;
		};
		switch type {
			case Eq | NotEq:
				var literal = ch;
				readChar();
				literal += ch;
				readChar();
				return new Token(type, literal);
			case Ident:
				var literal = readIdentifier();
				return new Token(Token.lookupIdent(literal), literal);
			case Int_: return new Token(Int_, readNumber());
			case _:
				var literal = ch;
				readChar();
				return new Token(type, literal);
		}
	}

	function readChar() {
		ch = input.charAt(read_position);
		position = read_position;
		read_position += 1;
	}

	function peekChar(): String return input.charAt(read_position);

	function read(fn: Void -> Bool): String {
		var pos = position;
		while (fn()) {
			readChar();
		}
		return input.substring(pos, position);
	}

	function readIdentifier(): String {
		return read(isLetter);
	}

	function readNumber(): String {
		return read(isDigit);
	}

	function skipWhitespace() {
		while (StringTools.isSpace(ch, 0)) {
			readChar();
		}
	}

	function isDigit(): Bool return ch >= '0' && ch <= '9';

	function isLetter(): Bool {
		return ch >= 'A' && ch <= 'Z' || ch >= 'a' && ch <= 'z' || ch == '_';
	}
}
