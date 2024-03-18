# Solution for ignore-them
We need to create a .gitignore file to ignore certain files as listed in the README file.

## Solution
1) touch .gitignore       (to create the file)
2) In the file, type the following:
    *.exe
    *.o
    *.jar
    libraries/

    This ignored all files with .exe, .o and .jar extensions along with all files in libraries directory.

3) git add .gitignore          (add gitignore to staging)
4) git commit
5) git verify