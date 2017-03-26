import haxe.macro.Context;
import haxe.macro.Expr;
using haxe.macro.ExprTools;

@:dce
class Assertion {
#if macro
	public static var NO_ASSERT = "ASSERTION_NO_ASSERT";
	public static var NO_WEAK_ASSERT = "ASSERTION_NO_WEAK_ASSERT";
	public static var NO_SHOW = "ASSERTION_NO_SHOW";

	static function prepareTraces(v:Expr)
	{
		return switch v.expr {
		case EConst(c) if (!c.match(CIdent(_))): macro { expr:null, rawValue:($v:Dynamic), value:""+$v };
		case _: macro { expr:$v{v.toString()}, rawValue:($v:Dynamic), value:""+$v };
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
		var traces = macro $a{traces.map(prepareTraces)};
		return macro {
			if (Assertion.enableAssert && !$cond) @:pos(pos) {
				if (assertion.Tools.runtime(assertion.Type.Assert($v{cond.toString()}), $traces))
					throw "Assertion failed: " + $v{cond.toString()};
			}
		};
	}

	public static macro function weakAssert(cond:ExprOf<Bool>, traces:Array<Expr>):ExprOf<Void>
	{
		if (Context.defined(NO_ASSERT) || Context.defined(NO_WEAK_ASSERT)) return macro {};
		var pos = Context.currentPos();
		var traces = macro $a{traces.map(prepareTraces)};
		return macro {
			if (Assertion.enableAssert && Assertion.enableWeakAssert && !$cond) {
				@:pos(pos) assertion.Tools.runtime(assertion.Type.WeakAssert($v{cond.toString()}), $traces);
			}
		};
	}

	public static macro function show(exprs:Array<Expr>):ExprOf<Void>
	{
		if (Context.defined(NO_SHOW)) return macro {};
		var pos = Context.currentPos();
		var traces = macro $a{exprs.map(prepareTraces)};
		return macro {
			if (Assertion.enableShow) {
				@:pos(pos) assertion.Tools.runtime(assertion.Type.Show, $traces);
			}
		};
	}
}

