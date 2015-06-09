# Example and test for git-sym
See <https://github.com/pb-cdunn/git-sym>.

## Testing
`git-sym` must be in `$PATH`.

## Basic usage
This should explain the idea.
```
$ git clone https://github.com/pb-cdunn/git-sym-test.git
$ cd git-sym-test

$ git-sym show
+ links/bar     .git_sym/bar
+ links/dirlink .git_sym/dirlink
+ links/foo     .git_sym/foo
+ links/sub/bar .git_sym/bar
+ links/sub/foo .git_sym/foo
O links/unrelated       /tmp

$ git-sym missing
links/bar
links/dirlink
links/foo
links/sub/bar
links/sub/foo

$ git-sym update

$ git-sym missing

$ git-sym show
. links/bar     .git_sym/bar
/ links/dirlink .git_sym/dirlink
. links/foo     .git_sym/foo
. links/sub/bar .git_sym/bar
. links/sub/foo .git_sym/foo
O links/unrelated       /tmp

$ ls -la .git_sym
lrwxrwxrwx 1 cdunn Group 61 Jun 10 00:37 .git_sym -> /home/cdunn/git-sym-test/.git/git_sym

$ ls -l links
lrwxrwxrwx 1 cdunn Group   15 Jun 10 00:36 bar -> ../.git_sym/bar
lrwxrwxrwx 1 cdunn Group   19 Jun 10 00:35 dirlink -> ../.git_sym/dirlink
lrwxrwxrwx 1 cdunn Group   15 Jun  9 21:31 foo -> ../.git_sym/foo
drwxr-xr-x 2 cdunn Group 4096 Jun 10 00:36 sub
lrwxrwxrwx 1 cdunn Group    4 Jun  9 21:12 unrelated -> /tmp

$ ls -l .git/git_sym/
lrwxrwxrwx 1 cdunn Group 39 Jun 10 00:38 bar -> /home/cdunn/git_sym_cache/bar
lrwxrwxrwx 1 cdunn Group 43 Jun 10 00:38 dirlink -> /home/cdunn/git_sym_cache/dirlink
lrwxrwxrwx 1 cdunn Group 39 Jun 10 00:38 foo -> /home/cdunn/git_sym_cache/foo

$ find /home/cdunn/git_sym_cache/dirlink
/home/cdunn/git_sym_cache/dirlink
/home/cdunn/git_sym_cache/dirlink/x
/home/cdunn/git_sym_cache/dirlink/subdir
/home/cdunn/git_sym_cache/dirlink/subdir/a
/home/cdunn/git_sym_cache/dirlink/subdir/b

$ find links/dirlink
links/dirlink

$ find links/dirlink/
links/dirlink/
links/dirlink/x
links/dirlink/subdir
links/dirlink/subdir/a
links/dirlink/subdir/b

$ cat .git/info/exclude
/.git_sym

```

## Adding a big file
`git-sym add` can be very convenient, if you do not need to choose your own filenames.
```
$ truncate -s 10M output.file

$ ls -l output.file
-rw-r--r-- 1 cdunn Group 10485760 Jun 10 00:53 output.file

$ git-sym add output.file
. output.file   .git_sym/sha1.6c5d4031e03408e34ae476c5053ee497a91ac37b.output.file

$ git status --short
A  output.file

$ ls -l output.file
lrwxrwxrwx 1 cdunn Group 66 Jun 10 00:53 output.file -> .git_sym/sha1.6c5d4031e03408e34ae476c5053ee497a91ac37b.output.file

$ ls -lL output.file
-r--r--r-- 1 cdunn Group 10485760 Jun 10 00:53 output.file

$ git commit
[master ???????] output.file
 1 file changed, 1 insertion(+)
  create mode 120000 output.file

$ git-sym show
. links/bar     .git_sym/bar
/ links/dirlink .git_sym/dirlink
. links/foo     .git_sym/foo
. links/sub/bar .git_sym/bar
. links/sub/foo .git_sym/foo
O links/unrelated       /tmp
. output.file   .git_sym/sha1.6c5d4031e03408e34ae476c5053ee497a91ac37b.output.file

```
As you can see, the filename is irrelevant, but including the SHA1 can be helpful
for future verification.

## Other tests
```
make
```
The tests are not complete. (E.g. `git-sym fix` is missing.)
But the symlinks here are useful for debugging.
