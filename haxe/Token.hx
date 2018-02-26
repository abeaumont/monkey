package;

class Token {
	public var type: TokenType;
	public var literal: String;
	public static var keywords: Map<String, TokenType> = [
		'fn' => Function,
		'let' => Let,
		'true' => True,
		'false' => False,
		'if' => If,
		'else' => Else,
		'return' => Return
	];

	public function new(_type: TokenType, _literal: String) {
		type = _type;
		literal = _literal;
	}

	public static function lookupIdent(ident: String): TokenType {
		return if (keywords.exists(ident)) keywords[ident] else Ident;
	}
}