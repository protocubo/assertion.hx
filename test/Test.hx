import Assertion.assert;
import utest.Assert in Utest;

class Test {
	function new() {}

	function test_it()
	{
		assert(Std.random(6) != 1);
		assert(Std.random(5) != 1, Std.random(2));
		assert(Std.random(4) != 1, Std.random(3), Std.random(4));
		assert(Std.random(3) != 1, Date.now());
		assert(Std.random(2) != 1, "one simple message");
		Utest.isTrue(true);  // for now, just run with it
	}

	static function main()
	{
		var r = new utest.Runner();
		r.addCase(new Test());
		utest.ui.Report.create(r);
		r.run();
	}
}

