# Introduction
we log into bandit wargame using `ssh banditX@bandit.labs.overthewire.org -p2220` where X is the level number and we need the password from previous level to log into any level.

## Level 0
The password for this level is already provided to us and is `bandit0`. Once logged in, we need to check the files in directory using `ls` and we see a `readme` file and on reading it using `cat readme` we get the password for level 1 which is `NH2SXQwcBdpmTEzi3bvBHMM9H66vVXjL`.

## Level 1
In this level when we check the files using `ls`, we come across a file named `-` and we can't read this file using `cat -` so we need to pass `cat ./-` command to read this file. We get the password for level 2 as `rRGizSaX8Mk1RTb1CNQoXTcYZWU6lgzi` from this.

## Level 2
On checking the files in this level, we find `spaces in this filename` file and since it has spaces in its name, we need to write the name between `" "` to read it. We pass the command `cat "spaces in this filename"` to read this file and find the password for level 3 which is `aBZ0W5EmUfAf7kHTQeOwd8bauFJ2lAiG`.

## Level 3
In this level, we find a directory named `inhere` so we go in the directory using `cd inhere` and then we use `ls` and find no files so we check for hidden files using `ls -a` and find that there is a file named `.hidden` and on reading it we find the password for level 4 which is `2EW7BBsr6aMMoJ2HjW067dm8EgX26xNe`.

## Level 4
In this level we again find the inhere directory and in that we find a lot of files. We can brute force reading these files to find the password since there are only 10 files but the better way is to check the file type of files because on reading file `-file00` we get some weird output so we check data type of all files using `file ./-*` here the `*` means we check for all files which fit the pattern(i.e. start with `./-`). We see that `./-file07` is ASCII text while rest are data type so we simply read `./-file07` and get the password for level 5 which is `lrIWWI6bB37kxfiCQZqUdOIYfr6eEeqR`.

## Level 5
In problem statement it is provided that the file must satisfy 3 conditions. On checking for files satisfying the size condition using `find -size 1033c` we get only 1 file so there is no point in checking other parameters because we are left with only one file which is `./inhere/maybehere07/.file2` so we can read that to get the password for level 6 which is `P4L4vucdmLnm8I7Vl7jG1ApGSfjYKqJU`

## Level 6
We need to use find function again like last level but with more conditions as per question this time. The command will be `find -size 33c -user bandit7 -group bandit6` and we find the file with password and on reading it we get the password `z7WtoNQU2XfjmMtWA8u5rN4vzqu4v99S`

## Level 7
In this level we have one file with a lot of lines of text and we are told that the password is next to the word millionth somewhere so we can simply pipe the content of this file into grep to search for the word millionth and print the line with that word using -n flag. `grep -n "millionth" data.txt` is the command that will print the line with password and we get the password which is `TESKZC0XvTetK0S9xNwm25STk5iWrBvP`

## Level 8
In this level we have data.txt and the solution is the line which occurs only once. To find that line we can run `sort data.txt | uniq -u` which sorts the lines in data.txt then pipes it to uniq cmd with -u flag which shows only the lines which are unique (have no duplicates). We get the flag as `EN632PlfYiZbn3PhVK3XOGSlNInNE00t`

## Level 9
In this level we again have data.txt but the data is binary so we use strings command to get readable data from it then pipe it to grep to get lines which start with "====" as question says the password is precedeed by a lot of = so the command `strings data.txt | grep -n "===="` gives output
```
13:x]T========== theG)"
63:========== passwordk^
93:========== is
220:========== G7w8LIi6J3kTb8A7j9LgrywtEUlyyp6s
```

so the password for next level is `G7w8LIi6J3kTb8A7j9LgrywtEUlyyp6s`

## Level 10 
We need to base64 decode data.txt in this level which can be done with the command `cat data.txt | base64 -d` giving us the password for next level as `6zPeziLdR2RKNdNYFNb6nVCKzphlXHBM`

## Level 11
We need to rotate the contents in the file by 13 characters to decode it so we run the command `cat data.txt | tr [n-za-mN-ZA-M] [a-zA-Z]` and get the password for next level as `JVNBBFSmZwKKOP0XbFXOoW8chDz5yVRv`

## Level 12
This level was just decrypting a lot of encryptions again and again so I'll just list out the steps that led me to the answer:
1) mkdir /tmp/maverick
2) cd /tmp/maverick
3) cp ~/data.txt data.txt
4) xxd -r data.txt data
5) file data
6) mv data data.gz
7) gzip -d data.gz
8) file data
9) mv data data.bz2
10) bzip2 -d data.bz2
11) file data
12) mv data data.gz
13) gzip -d data.gz
14) file data
15) mv data data.tar
16) tar -x -f data.tar
17) ls
18) file data5.bin
19) mv data5.bin data5.tar
20) tar -x -f data5.tar
21) ls
22) file data6.bin
23) mv data6.bin data6.bz2
24) bzip2 -d data6.bz2
25) file data6
26) mv data6 data6.tar
27) tar -x -f data6.tar
28) ls
29) file data8.bin
30) gzip -d data8.gz
31) file data8
32) cat data8

This led to output `The password is wbWdlBxEir4CaE8LaPhauuOo6pwRmrDw` so the password for next level is `wbWdlBxEir4CaE8LaPhauuOo6pwRmrDw`

## Level 13
In this level we don't get password but instead the ssh key which we can use to log into next level. On using `ls` we find the file with private key with filename `sshkey.private` so to log into next level we can use it using `ssh -i sshkey.private bandit14@localhost -p2220 ` and we'll have logged into next level

## Level 14
In the previous level we were told the location of password to current level which is in `/etc/bandit_pass/bandit14` so on reading that file we get password to current level which is `fGrHPx402xGC7U7rXKDaxiWFTOiF0ENq`. Now for password of next level, we need to submit this password to localhost on port 30000 for which we can use netcat. We use the command `nc localhost 30000` then enter the current password and get the following output:
```
Correct!
jN2kgmIXJ6fShzhT2avhotn4Zcka6tnt
```
So the password to next level is `jN2kgmIXJ6fShzhT2avhotn4Zcka6tnt`

## Level 15
We can connect to localhost using ssl encryption with `openssl s_client -connect localhost:30001` and this will connect us to the host where we submit the current level's password to get next level's password which is `JQttfApK4SeyHwDlI9SXGR50qclOAil1`

## Level 16
we can scan the ports using nmap in this level because brute forcing so many ports isn't feasible. `nmap -sV localhost -p 31000-32000` returned 5 ports of which only 1 port was not echo port (port 31790) and this ran in 98 seconds. Now we can SSL connect to this port and get ssh key to log into next level

## Level 17
We log into this level using the ssh key that we got in previous level. Now there are 2 files and we need to find the line which is different in both and the password is that line's version in the passwords.new file. To achieve that we run and get output:
```
42c42
< p6ggwdNHncnmCNxuAt0KtKVq185ZU7AW
---
> hga5tuuCLF6fFzUpnagiMN8ssu9LFrdg
```
In this the second password is the password that we need since that is the line in `passwords.new`. So the password for next level is `hga5tuuCLF6fFzUpnagiMN8ssu9LFrdg`

## Level 18
To solve this level, we can simply pass the cat command during the login command so it will run before we log out. `ssh bandit18@bandit.labs.overthewire.org -p 2220 "cat readme"` and then entering level password to log in will give us the password to next level and log us out. The password to next level is `awhqfNnAbc1naukrpqDYcF95h7HoMTrC`

## Level 19
In this level we are provided a binary file which we don't know much about but are told to run it without arguments to find out what it does. On running `./bandit20-do` we get output
```
Run a command as another user.
  Example: ./bandit20-do id
```
This means we can read files as bandit20 user and we know the location of password files from before (also mentioned in this problem as well) so we can simply run `./bandit20-do cat /etc/bandit_pass/bandit20` to get the password which is `VxCazJaVykI6W36BkBU0mJTCM8rR95XT`

## Level 20
In this level the binary file which we can run listens to whatever the localhost gives it on port of our choice so we can just start a local server which echos the current password using the command `echo -n VxCazJaVykI6W36BkBU0mJTCM8rR95XT | nc -l -p 6900 &` and this will run in background on port 6900 then we can run `./suconnect 6900` and get the output:
```
Read: VxCazJaVykI6W36BkBU0mJTCM8rR95XT
Password matches, sending next password
NvEJF7oVjkddltPSrdKEFOllh9V1IBcq
[3]+  Done                    echo -n VxCazJaVykI6W36BkBU0mJTCM8rR95XT | nc -l -p 6900
```
and hence this level is also solved and the password to next level is  `NvEJF7oVjkddltPSrdKEFOllh9V1IBcq`
