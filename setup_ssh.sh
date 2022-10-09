#!/bin/bash


echo -e -n "\033[0;35m Enter your github username: \e[0m"
read username 
echo -e -n "\033[0;35m Enter your github email: \e[0m" 
read email 



if [[ -z "$email" ]] | [[ -z "$username" ]]
then 
    echo "Cannot Proceed with empty email or username"
    exit 1
fi

git config --global user.name "$username"
git config --global user.email "$email"

: '
ssh-keygen: The command-line tool used for creating a new pair of SSH keys. You can see its flags with ssh-keygen help
-t ed25519: The -t flag is used to indicate the algorithm used to create the digital signature of the key pair. If your system supports it, ed25519 is the best algorithm you can use to create SSH key pairs.
-C “email”: The -c flag is used to provide a custom comment at the end of the public key, which usually is the email or identification of the creator of the key pair.
- N "": the -N flag is used to provide a passphrase. We are providing an empty passphrase. You can configure that to your liking.
'

ssh-keygen -t ed25519 -C "$email" -N "" -f ~/.ssh/id_25519

eval `ssh-agent -s`
ssh-add ~/.ssh/id_25519

if [ $? != 0 ]
then 
    echo "not working"
fi
echo -e "\e[31m Copy this to part to the clipboard and paste into New SSH Key\e[0m\n"

cat ~/.ssh/id_25519.pub



