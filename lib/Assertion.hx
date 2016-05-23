import haxe.macro.Context;
import haxe.macro.Expr;
using haxe.macro.ExprTools;

class Assertion {
#if macro
	static function dumpValue(v:Expr)
	{
		return switch v.expr {
		case EConst(_): macro @:pos(v.pos) trace("(assertion const) " + $v{v.toString()});
		case _: macro @:pos(v.pos) trace("(assertion trace) " + $v{v.toString()} + " = " + $v);
		}
	}
#end

	public static macro function assert(cond:ExprOf<Bool>, traces:Array<Expr>):ExprOf<Void>
	{
		var pos = Context.currentPos();
		var dump = traces.map(dumpValue);
		return macro @:pos(pos) {
			if (!$cond) {
				$a{dump};
				throw "Assertion failed: " + $v{cond.toString()};
			}
		}
	}
}

