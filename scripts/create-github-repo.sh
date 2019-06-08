#! /usr/bin/env bash

echo -n "Enter name of repository:  "
read REPO

echo -n "Enter name of user: "
read USERNAME

mkdir $REPO
cd $REPO
git init 
echo init > README.md
git add .
git commit -m "init"

eval "curl -u '$USERNAME' https://api.github.com/user/repos -d '{\"name\":\"$REPO\"}'"

git remote add origin git@github.com:$USERNAME/$REPO.git
git push --set-upstream origin master
