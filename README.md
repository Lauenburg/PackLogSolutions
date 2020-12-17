# PackLogSolutions

`data` - directory for datasets

`code` - directory for codebase

## Getting Started

Clone Repository
```
git clone https://gitlab.lrz.de/lupries/packlogsolutions.git
cd packlogsolutions
```

Make changes
(`master` is main branch, create new branch to make changes and merge)
```
git pull
git checkout -b <nameofbranch>
(make some changes, add/delete files)
git add *
git commit -m "<some text describing your changes>"
git checkout master
git merge <nameofbranch>
(if git merge fails -> :q -> resolve highlighted conflicts in files -> commit again)
git push
```
