/*
HOW TO ADD PROJECT IN GITHUB FROM TERMINAL


1)first check the git version  by git --version
2)then "git status" it will tell us what files and folders will be pushed to github
    we will get several files in red meaning git was not tracking them for next snapshot yet basicall all weere unstaged (basically last update ke baad wjhatever changes u did it wont upload on github)
3) then "git add ." which tells git to take every single modified file and put them in staging area
4)then "git status" 
   we willget all files in green basically they are officialy staged

5) "git log"  it shows the commint history of the current branch

6)"git commit -m"
      saves your staged changes as a permanent snapshot in your local repository's history, with a custom description attached to it. but we wanna push this local repo to github now

  7)now go to github and make a new repo   and copyu the url for cmnd

  8) git remote add origin "url"
    remote means github add means to add there and origin is a shortened name for this giant url and giant url is the actual place

9)git remote -v  (its not necesaary for repo to add)
lists all the remote servers (like GitHub) connected to your local repository, along with their URLs.

10) git push -u origin main


TO COPY SOMEONES CODE THEN U GOTTA PULL THIS CMND

1) mkdir blahblah
make a directory

2) git clone "url"

basically in that when u click on clone u will get the url








in cmnd type "ls" to get all the files and folders present
in cmnd type "pwd" to get the path we are in rn

 */