#!/bin/bash
git config --global --add safe.directory '*'

# use environment variables in cronjob

# setup environment variable $REPO_NAME

echo $REPO_NAME

if [[ -z "$REPO_NAME" ]]
then 
    echo "Cannot proceed with empty repo name"
    exit 1
fi

path="/data/data/com.termux/files/home/storage/shared/Documents/my_github_repos"

cd "$path/$REPO_NAME"

if [ $? != 0 ]
then 
    echo "Error exiting"
    exit 1
fi

git pull 

changes_exist="$(git status --porcelain | wc -l)"

if [ "$changes_exist" -eq 0 ]
then 
    exit 0
fi

device_maf=$(termux-info | awk '/Device manufacturer:/{getline; print}')
device_model=$(termux-info | awk '/Device model:/{getline; print}')

git pull

git add . 

git commit -q -m "Last Sync: $(date +"%Y-%m-%d %H:%M:%S") from device $device_maf $device_model"

git push -q