#!/bin/bash


user=$1
repo=$2



path="/data/data/com.termux/files/home/storage/shared/Documents/my_github_repos"

if [[ ! -d $path]]
then
echo "path doesn't exist, creating directory"
mkdir -p "$path"
fi

cd $path

git clone "git@github.com:$user/$repo 
echo "repo cloned successfully"


