# Quick assertions and traces with macros

![screenshot from 2017-03-17 04-08-57](https://cloud.githubusercontent.com/assets/1832496/24032563/76f8f01c-0ac7-11e7-88c1-ef8ab8af361d.png)

## Usage

```haxe
import Assertion.*;
[...]
var foo = "a";

// basic `assert`, that throws if the condition fails
assert(foo == "bar");

// trace some context if the assertion fails
// you can add as many expressions to trace as you need
assert(foo == "bar", foo, Sys.systemName());

// trace expressions consisting of string literals are automatically threated as descriptions
assert(foo.length == 3, "correct length at least");

// if you just want a warning, instead of a throw, use `weakAssert`
weakAssert(foo == "bar");

// if you just want to trace like us, use `show`
show(foo, Sys.systemName(), "show everything");
```

## Configuring

`Assertion` works out of the box without any configuration, but in some
cases you might want to change or disable certain default behaviors.

You can configure the library both at compile time and runtime.

### Compile time configuration

Use `-D ASSERTION_NO_ASSERT` to disable the generation of all assertions (both
regular and weak).

You can also use `-D ASSERTION_NO_WEAK_ASSERT` to only disable the generation
of weak assertions.  Similarly, you can disable the generation of code for
`show` with `-D ASSERTION_NO_SHOW`.

### Runtime configuration

Similarly to the compile time settings, you can use the following variables to
alter the behavior of `Assertion` at runtime:

 - `Assertion.enableAssert` (defaults to `true`)
 - `Assertion.enableWeakAssert` (defaults to `true`)
 - `Assertion.enableShow` (defaults to `true`)

