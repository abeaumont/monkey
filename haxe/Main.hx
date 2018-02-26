package;

class Main {
	public static function main() {
		var r = new haxe.unit.TestRunner();
		r.add(new LexerTestCase());
		r.run();
	}
}