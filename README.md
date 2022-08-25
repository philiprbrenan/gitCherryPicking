# Cherry picking with git

![Test](https://github.com/philiprbrenan/gitCherryPicking/workflows/Test/badge.svg)

Assume that we have the following set of git branches:
```
     main  -> E3
      |
     main2 -> A1
```
We want to apply just the changes made from main2 to a1 to e3 but no other
changes that were made between main and main2.

Solution:
```
  git checkout e3
  git cherry-pick main2..a1
```

You can see this solution in action by looking at the actions associated with this repo.
