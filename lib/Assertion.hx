import haxe.macro.Context;
import haxe.macro.Expr;
using haxe.macro.ExprTools;

@:dce
class Assertion {
#if macro
	public static var DISABLE_FLAG = "NO_ASSERTIONS";

	static function dumpValue(v:Expr)
	{
		return switch v.expr {
		case EConst(c) if (!c.match(CIdent(_))): macro @:pos(v.pos) trace("(assertion info) " + $v{v.toString()});
		case _: macro @:pos(v.pos) trace("(assertion trace) " + $v{v.toString()} + " = " + $v);
		}
	}
#end

	public static var enabled = true;

	public static macro function assert(cond:ExprOf<Bool>, traces:Array<Expr>):ExprOf<Void>
	{
		if (Context.defined(DISABLE_FLAG)) return macro {};
		var pos = Context.currentPos();
		var dump = traces.map(dumpValue);
		return macro @:pos(pos) {
			if (Assertion.enabled && !$cond) {
				$a{dump};
				throw "Assertion failed: " + $v{cond.toString()};
			}
		}
	}

	public static macro function weakAssert(cond:ExprOf<Bool>, traces:Array<Expr>):ExprOf<Void>
	{
		if (Context.defined(DISABLE_FLAG)) return macro {};
		var pos = Context.currentPos();
		var dump = traces.map(dumpValue);
		return macro @:pos(pos) {
			if (Assertion.enabled && !$cond) {
				$a{dump};
				trace("Weak assertion failed: " + $v{cond.toString()});
			}
		}
	}
}

