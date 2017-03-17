libname=assertion
zipname=${libname}.zip

noop:
	# Check the available Makefile targets

${zipname}:
	rm -f ${zipname}
	zip -r $@ ./* -x \*.zip dump/\*

set-pkg: ${zipname}
	haxelib dev ${libname}
	haxelib remove ${libname}
	haxelib install ${zipname}
	haxelib path ${libname}

set-dev:
	haxelib dev ${libname} ${PWD}
	haxelib path ${libname}

set-live:
	haxelib dev ${libname}
	haxelib remove ${libname}
	haxelib install ${libname}
	haxelib path ${libname}

.PHONY: ${zipname} set-pkg set-dev set-live

