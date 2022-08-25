# Cherry picking with git

![Test](https://github.com/philiprbrenan/gitCherryPicking/workflows/Test/badge.svg)

Assume that we have the following set of git branches:
```
     main  -> E3
      |
     main2 -> A1
```
We want to apply just the changes made from __main2__ to __a1__ to __e3__ but no other
changes that were made between __main__ and __main2__.

Solution:
```
  git checkout e3
  git cherry-pick main2..a1
```

You can see this solution in action by looking at the actions associated with this repo which oproduces this output:

```
perl cherryPicking.pl
Initialize git__________________________________________________________________________________________________________

hint: Using 'master' as the name for the initial branch. This default branch name
hint: is subject to change. To configure the initial branch name to use in all
hint: of your new repositories, which will suppress this warning, call:
hint:
hint: 	git config --global init.defaultBranch <name>
hint:
hint: Names commonly chosen instead of 'master' are 'main', 'trunk' and
hint: 'development'. The just-created branch can be renamed via this command:
hint:
hint: 	git branch -m <name>
Initialized empty Git repository in /home/runner/work/gitCherryPicking/gitCherryPicking/git/.git/



Create main_____________________________________________________________________________________________________________
Create main
Switched to a new branch 'main'
On branch main

No commits yet

Untracked files:
  (use "git add <file>..." to include in what will be committed)
	test.txt

nothing added to commit but untracked files present (use "git add" to track)
1 a
2 b
3 c
4 d
5 e
6 f
7 g
8 h
9 i

Commit main
[main (root-commit) 280f2c0] main
 1 file changed, 9 insertions(+)
 create mode 100644 test.txt
On branch main
nothing to commit, working tree clean
1 a
2 b
3 c
4 d
5 e
6 f
7 g
8 h
9 i

Create main->e3_________________________________________________________________________________________________________
Create e3
Switched to a new branch 'e3'
On branch e3
nothing to commit, working tree clean
1 a
2 b
3 c
4 d
5 e
6 f
7 g
8 h
9 i

Commit e3
[e3 944618c] e3
 1 file changed, 1 insertion(+), 1 deletion(-)
On branch e3
nothing to commit, working tree clean
1 a E3
2 b
3 c
4 d
5 e
6 f
7 g
8 h
9 i

Create main->main2______________________________________________________________________________________________________
Switch to main
Switched to branch 'main'
On branch main
nothing to commit, working tree clean
1 a
2 b
3 c
4 d
5 e
6 f
7 g
8 h
9 i

Commit main
[main b747ee0] main
 1 file changed, 1 insertion(+), 1 deletion(-)
On branch main
nothing to commit, working tree clean
1 a
2 b
3 c
4 d main
5 e
6 f
7 g
8 h
9 i

Create main2->a1________________________________________________________________________________________________________
Create a1
Switched to a new branch 'a1'
On branch a1
nothing to commit, working tree clean
1 a
2 b
3 c
4 d main
5 e
6 f
7 g
8 h
9 i

Commit a1
[a1 5327615] a1
 1 file changed, 1 insertion(+), 1 deletion(-)
On branch a1
nothing to commit, working tree clean
1 a
2 b
3 c
4 d main
5 e
6 f
7 g
8 h
9 i a1

Apply main2->a1 to e3___________________________________________________________________________________________________
Switch to e3
Switched to branch 'e3'
On branch e3
nothing to commit, working tree clean
1 a E3
2 b
3 c
4 d
5 e
6 f
7 g
8 h
9 i

1 a E3
2 b
3 c
4 d
5 e
6 f
7 g
8 h
9 i
Auto-merging test.txt
[e3 f3b5d80] a1
 Date: Thu Aug 25 00:54:27 2022 +0000
 1 file changed, 1 insertion(+), 1 deletion(-)
1 a E3
2 b
3 c
4 d
5 e
6 f
7 g
8 h
9 i a1

Commit main
On branch e3
nothing to commit, working tree clean
On branch e3
nothing to commit, working tree clean
1 a E3
2 b
3 c
4 d
5 e
6 f
7 g
8 h
9 i a1
```
