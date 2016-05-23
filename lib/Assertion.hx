import haxe.macro.Context;
import haxe.macro.Expr;
using haxe.macro.ExprTools;

class Assertion {
	public static macro function assert(cond:ExprOf<Bool>, traces:Array<Expr>):ExprOf<Void>
	{
		var pos = Context.currentPos();
		var dump = [for (t in traces) macro @:pos(pos) trace($v{t.toString()} + " = " + $t)];
		return macro @:pos(pos) {
			if (!$cond) {
				$a{dump};
				throw "Assertion failed: " + $v{cond.toString()};
			}
		}
	}
}

