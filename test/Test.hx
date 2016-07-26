import Assertion.*;
import utest.Assert in Utest;

class Test {
	function new() {}

	function test_it()
	{
		show("a simple show and tell");
		show(Date.now());

		weakAssert(1 == 1, "foo");
		weakAssert(1 == 0, "bar", Math.PI);

		assert(1 == 1, "red");
		assert(1 == 0, "blu", Math.atan(1));
	}

	static function main()
	{
		trace("Hello World");
		var r = new utest.Runner();
		r.addCase(new Test());
		utest.ui.Report.create(r);
		r.run();
	}
}

