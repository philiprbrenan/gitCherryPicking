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
  git cherry-pick a1
```

You can see this solution in action by looking at the actions associated with
this repo which produce the following output:

[Action Log - See section __run__](https://github.com/philiprbrenan/gitCherryPicking/runs/8007026933?check_suite_focus=true)

```
perl cherryPicking.pl
Initialize git__________________________________________________________________________________________________________

cd /home/runner/work/gitCherryPicking/gitCherryPicking/git/
git init
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

cd /home/runner/work/gitCherryPicking/gitCherryPicking/git/
git config --global user.email "you@example.com"

cd /home/runner/work/gitCherryPicking/gitCherryPicking/git/
git config --global user.name "Your Name"

Create main_____________________________________________________________________________________________________________
Create main
cd /home/runner/work/gitCherryPicking/gitCherryPicking/git/
git checkout -b main
git status
cat test.txt
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
cd /home/runner/work/gitCherryPicking/gitCherryPicking/git/
git add /home/runner/work/gitCherryPicking/gitCherryPicking/git/test.txt
git commit -m "main"
git status
cat test.txt
[main (root-commit) 0e1a6dd] main
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
cd /home/runner/work/gitCherryPicking/gitCherryPicking/git/
git checkout -b e3
git status
cat test.txt
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
cd /home/runner/work/gitCherryPicking/gitCherryPicking/git/
git add /home/runner/work/gitCherryPicking/gitCherryPicking/git/test.txt
git commit -m "e3"
git status
cat test.txt
[e3 501bff6] e3
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
cd /home/runner/work/gitCherryPicking/gitCherryPicking/git/
git checkout main
git status
cat test.txt
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
cd /home/runner/work/gitCherryPicking/gitCherryPicking/git/
git add /home/runner/work/gitCherryPicking/gitCherryPicking/git/test.txt
git commit -m "main"
git status
cat test.txt
[main 9827de8] main
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
cd /home/runner/work/gitCherryPicking/gitCherryPicking/git/
git checkout -b a1
git status
cat test.txt
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
cd /home/runner/work/gitCherryPicking/gitCherryPicking/git/
git add /home/runner/work/gitCherryPicking/gitCherryPicking/git/test.txt
git commit -m "a1"
git status
cat test.txt
[a1 6407af5] a1
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
cd /home/runner/work/gitCherryPicking/gitCherryPicking/git/
git checkout e3
git status
cat test.txt
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

cd /home/runner/work/gitCherryPicking/gitCherryPicking/git/
cat test.txt
git cherry-pick a1
cat test.txt
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
[e3 b1c8190] a1
 Date: Thu Aug 25 01:08:25 2022 +0000
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
cd /home/runner/work/gitCherryPicking/gitCherryPicking/git/
git add /home/runner/work/gitCherryPicking/gitCherryPicking/git/test.txt
git commit -m "main"
git status
cat test.txt
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

The last [file](https://en.wikipedia.org/wiki/Computer_file) shows that the one change made between __main2__ and __a1__ has
been applied to __e3__ while not applying the change made between __main__ and
__main2__.
