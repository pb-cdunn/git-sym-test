GIT_SYM_CACHE_DIR:=CACHE
DOT_GIT_DIR=$(shell git rev-parse --git-dir)

test:
	bash test-foo.sh
	bash test-add.sh
clean:
	mkdir -p ${GIT_SYM_CACHE_DIR}
	rm -fr ${GIT_SYM_CACHE_DIR}
	rm -rf ${DOT_GIT_DIR}/git_sym
	rm -f .git_sym
	#git clean -xdf
	#git reset --hard
