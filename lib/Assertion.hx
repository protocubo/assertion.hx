import haxe.macro.Context;
import haxe.macro.Expr;
using haxe.macro.ExprTools;

@:dce
class Assertion {
#if macro
	public static var NO_ASSERT = "ASSERTION_NO_ASSERT";
	public static var NO_WEAK_ASSERT = "ASSERTION_NO_WEAK_ASSERT";
	public static var NO_SHOW = "ASSERTION_NO_SHOW";

	static function showValue(prefix:String,  v:Expr)
	{
		return switch v.expr {
		case EConst(c) if (!c.match(CIdent(_))): macro @:pos(v.pos) trace($v{prefix} + $v);
		case _: macro @:pos(v.pos) trace($v{prefix + v.toString() + "="} + $v);
		}
	}
#end
	public static var enableAssert = true;
	public static var enableWeakAssert = true;
	public static var enableShow = true;

	public static macro function assert(cond:ExprOf<Bool>, traces:Array<Expr>):ExprOf<Void>
	{
		if (Context.defined(NO_ASSERT)) return macro {};
		var pos = Context.currentPos();
		var dump = traces.map(showValue.bind("[assert] "));
		return macro @:pos(pos) {
			if (Assertion.enableAssert && !$cond) {
				$a{dump};
				throw "Assertion failed: " + $v{cond.toString()};
			}
		}
	}

	public static macro function weakAssert(cond:ExprOf<Bool>, traces:Array<Expr>):ExprOf<Void>
	{
		if (Context.defined(NO_ASSERT) || Context.defined(NO_WEAK_ASSERT)) return macro {};
		var pos = Context.currentPos();
		var dump = traces.map(showValue.bind("[weak assert] "));
		return macro @:pos(pos) {
			if (Assertion.enableAssert && Assertion.enableWeakAssert && !$cond) {
				$a{dump};
				trace("[weak assert] would have FAILED: " + $v{cond.toString()});
			}
		}
	}

	public static macro function show(exprs:Array<Expr>):ExprOf<Void>
	{
		if (Context.defined(NO_SHOW)) return macro {};
		var pos = Context.currentPos();
		var dump = exprs.map(showValue.bind(""));
		return macro @:pos(pos) {
			if (Assertion.enableShow) {
				$a{dump};
			}
		}
	}
}

