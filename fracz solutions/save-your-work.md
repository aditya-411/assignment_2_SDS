# Solution to save your work
We need to stash our current work, then fix the bug, commit it, then unstash our work, finish it and commit it

# Steps
1) git stash
2) remove the bug line from bug.txt
3) git add bug.txt
4) git commit
5) git stash pop
6) add the finishing line in bug.txt
7) git add bug.txt
8) git commit
9) git verify