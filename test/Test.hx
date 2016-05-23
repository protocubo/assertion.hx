import Assertion.*;
import utest.Assert in Utest;

class Test {
	function new() {}

	function test_it()
	{
		assert(Std.random(6) != 0);
		assert(Std.random(5) != 0, Std.random(2));
		assert(Std.random(4) != 0, Std.random(3), Std.random(4));
		assert(Std.random(3) != 0, Date.now());
		assert(Std.random(2) != 0, "one simple message");

		weakAssert(Std.random(1) != 0);

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

