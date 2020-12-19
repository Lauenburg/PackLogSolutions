# PackLogSolutions

`data` - directory for datasets

`backend` - directory for python backend

`frontend` - directory for flutter ui

## Getting Started

### Requirements

* [Install Anaconda](https://docs.anaconda.com/anaconda/install/)

### Installation

1. Clone Repository
```
git clone https://gitlab.lrz.de/lupries/packlogsolutions.git
cd packlogsolutions
```

2. Setup Virtual Python Environment
```
conda update conda
conda create --name packlog python=3.8
conda activate packlog
conda install --file requirements.txt
```
after you have installed new python packages, update requirements.txt file:
```
conda list --explicit > requirements.txt
```

### How to make changes
(`master` is main branch, create new branch to make changes and merge)
```
git pull
git checkout -b <nameofbranch>
git push --set-upstream origin <nameofbranch>
(make some changes, add/delete files)
git add *
git commit -m "<some text describing your changes>"
git checkout master
git merge <nameofbranch>
(if git merge fails -> exit popup ':q' -> resolve highlighted conflicts in files -> commit again)
git push
```

