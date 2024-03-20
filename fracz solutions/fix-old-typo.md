# Solution to fix old typo
In this exercise we need to rebase to a previous commit, then modify the last commit, then rebase back to the latest commit.
# Steps
1) git rebase -i
2) change the top commit to edit in the file that opened in text editor then close the file
3) update file.txt
4) git add file.txt
5) git commit --amend
6) git add file.txt
6) git commit
7) git rebase --continue
8) git verify

and done :)