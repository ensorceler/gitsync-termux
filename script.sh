#!/bin/bash


user=$1
repo=$2



PATH="/data/data/com.termux/files/home/storage/shared/Documents/my_github_repos"

if [[ ! -d $PATH ]]
then
    echo "path doesn't exist, creating directory"
    mkdir -p "$PATH"
fi

cd $PATH

git clone "git@github.com:$user/$repo 
echo "repo cloned successfully"


