make clean
set -ex
echo '/.git_sym' >| .gitignore
git-sym check && exit 1
git-sym update
git-sym check
echo done
