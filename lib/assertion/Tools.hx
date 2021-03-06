package assertion;

class Tools {
	/*
	Handle the a assert/weak assert/trace at runtime.

	The return will determinate wheather the default action (e.g. rainsing
	an exception when an assert fails) will happen (if it's true) or not
	(if it's false).
	*/
	public static dynamic function runtime(type:Type, traces:Array<assertion.Trace>, ?pos:haxe.PosInfos):Bool
	{
		var prefix = "", finalWarning = null;
		switch type {
		case Assert(_):
			prefix = "[assert] ";
		case WeakAssert(cond):
			prefix = "[weak assert] ";
			finalWarning = 'would have FAILED: $cond';
		case _:
		}
		for (t in traces)
			haxe.Log.trace(prefix + (t.expr != null ? t.expr + "=" : "") + t.value, pos);
		if (finalWarning != null)
			haxe.Log.trace(prefix + finalWarning, pos);
		return true;
	}
}
