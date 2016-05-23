import Assertion.assert;
import utest.Assert in Utest;

class Test {
	function new() {}

	function test_it()
	{
		assert(Std.random(2) == 1 && 1 == 1);
		assert(Std.random(2) == 1 && 2 == 2, Std.random(2));
		assert(Std.random(2) == 1 && 3 == 3, Std.random(3), Std.random(4));
		assert(Std.random(2) == 1 && 4 == 4, Date.now());
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

