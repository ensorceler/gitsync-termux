#!/bin/bash

echo -e "\033[0;31m Provide your repo name and make sure you have cloned the repo by executing ./clone_repo.sh: \e[0m "

read -p "repo name: " repo_name

if [[ -z "$repo_name" ]]
then 
    echo "Cannot proceed with empty repo name"
fi

path="/data/data/com.termux/files/home/storage/shared/Documents/my_github_repos"

cd "$path/$repo_name"

git pull 

changes_exist="$(git status --porcelain | wc -l)"

if [ "$changes_exist" -eq 0 ]
then 
    exit 0
fi

device_maf=termux-info | awk '/Device manufacturer:/{getline; print}'
device_model=termux-info | awk '/Device model:/{getline; print}'

git pull

git add . 

git commit -q -m "Last Sync: $(date +"%Y-%m-%d %H:%M:%S") from device ($device_maf $device_model)"