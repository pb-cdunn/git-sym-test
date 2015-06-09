# Normally, the source would be outside the repo tree,
# but this is for testing.
HERE:=$(dir $(abspath $(lastword $(MAKEFILE_LIST))))
SOURCE:=${HERE}/data

foo:
	cp -f ${SOURCE}/foo $@
bar:
	cp -f ${SOURCE}/bar $@
dirlink:
	mkdir -p dirlink/subdir
