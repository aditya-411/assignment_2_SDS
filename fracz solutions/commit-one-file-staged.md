# Solution for commit one file staged
we have to commit only 1 of the 2 files, both of which are already staged. I choose to commit B.txt. 
## Solution:
1) git restore --staged A.txt            (remove A.txt from staging)
2) git status               (confirm only B.txt is in staging and will be the only file commited)
3) git commit               (commit the file)
4) git verify               (verify completion of the exercise)