#!/bin/bash

path="/data/data/com.termux/files/home/storage/shared/Documents/my_github_repos"

echo -e "\033[0;31m Github repo: \e[0m "
echo -e -n "\033[0;32m Enter your github username: \e[0m" 
read user_name
echo -e -n "\033[0;32m Enter your github reponame: \e[0m"
read repo_name 

if [ -z "$user_name" ] || [ -z "$repo_name" ]
then
    echo "empty github username or repository name, Please provider proper values"
    exit 1
fi

if [[ ! -d $path ]]
then
    echo "path does not exist , creating directory"
    mkdir -p "$path"
fi

cd $path
git clone "git@github.com:$user_name/$repo_name.git"

if [ $? -eq 0 ]
then 
    echo "repo cloned successfully"
else 
    echo "Error"
fi
