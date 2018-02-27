package;

enum TokenType {
	Illegal;
	Eof;

	// Identifiers + literals
	Ident; // add, foobar, x, y, ...
	Int_; // 1343456

	// Operators
	Assign;
	Plus;
	Minus;
	Bang;
	Asterisk;
	Slash;

	Lt;
	Gt;
	Eq;
	NotEq;

	// Delimiters
	Comma;
	Semicolon;

	Lparen;
	Rparen;

	Lbrace;
	Rbrace;

	// Keywords
	Function;
	Let;
	True;
	False;
	If;
	Else;
	Return;
}
