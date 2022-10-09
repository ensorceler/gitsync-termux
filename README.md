## GitSync Termux

### Why

The purpose of this whole thing is for you to enjoy convenient note taking experience (Obsidian, Logseq etc) where all your files will by synced with a remote git repo. You can access them from anywhere with any android device and make changes to the notes and they will be synced.

### What is Termux App

Termux is an Android terminal emulator and Linux environment application that works directly with no rooting or setup required. A minimal base system is installed automatically, additional packages are available using the package manager.
[Termux Wiki](https://wiki.termux.com/wiki/Main_Page)

### How to install Termux app in android

Do not install termux from google playstore, I repeat **do not install from google playstore**. Google playstore version is deprecated and no longer supported. [read why](https://www.xda-developers.com/termux-terminal-linux-google-play-updates-stopped/)
Go to the official [F-droid termux](https://f-droid.org/packages/com.termux/) website.
Look at the Download APK option below the version release card. Download and install the apk.
Link to latest [apk release file](https://f-droid.org/repo/com.termux_118.apk)

##### Known issues with termux

- if you have problems seeing the input in termux after typing, fear not I had the same problem. here's the solution that worked for me :

```bash
 cd ~
 mkdir .termux
 echo "enforce-char-based-input=true" > .termux/termux.properties
 termux-reload-settings
```

if `.termux` file already exists, then copy the last two lines and that's it.

### Instructions to setup

First of all, update the package manager.

```bash
pkg update && pkg upgrade
```

Install Git and Wget

```bash
pkg install -y git wget
```

Install cronie to execute cronjobs (we'll come to that later)

```bash
pkg install -y cronie termux-services
```

##### OpenSSH

OpenSSH is a tool used to log into other platform's UNIX shells. [read more](https://www.ssh.com/academy/ssh/openssh)

```bash
pkg install -y openssh
```

After installing, if you execute `ls -alh `, you will a folder .ssh created in the ~ (home) directory.This is where your public and private keys (SSH) are stored by default.

### File permissions

In order to have access to shared storage (/sdcard or /storage/emulated/0), Termux needs a storage access permission. It is not granted by default and is not requested on application startup since it is not necessary for normal application functioning.

Run this command in termux. There will be a modal asking if you want to allow Termux to access files on your device, Press Allow.(It is necessary)

```bash
termux-setup-storage
```

After allowing, you will see a folder in the ~ directory named `storage` . [read more](https://wiki.termux.com/wiki/Termux-setup-storage)

##### To setup SSH connection where PC terminal can access phone termux terminal.

The following will start the ssh-server in termux and the default port for SSH in termux is 8022

```bash
sshd
```

setup a password for SSH in termux and it will prompt you for a password:

```bash
passwd
```

check username in Termux:

```bash
whoami
```

check wifi IP address and note the ip address of the device (wlan, most likely):

```bash
ifconfig
```

Now from the desktop you can basically login to Termux terminal:

```bash
ssh <username=termux>@<ip-address-termux> -p 8022
```

Voila!

### Setup SSH keys with Github

[Interesting Article on how to generate SSH keys](https://kinsta.com/blog/generate-ssh-key/)

Execute out `setup_ssh.sh` script

```bash
./setup_ssh.sh <your-github-email>
```

Now the copy the last part which starts with **ssh-ed25519**

- [Log into GitHub ]](https://github.com/login) and go to the upper-right section of the page, click in your profile photo, and select \***\*Settings.\*\*** ![](https://kinsta.com/wp-content/uploads/2022/01/GitHub-settings.png)
- Then, in profile your settings, click **SSH and GPG keys**.![](https://kinsta.com/wp-content/uploads/2022/01/GitHub-ssh-gpg-keys.png)
- Click the **New SSH key** button. ![](https://kinsta.com/wp-content/uploads/2022/01/GitHub-new-ssh-key-1024x340.png)
- Give your new SSH key on GitHub a **Title** — usually, the device you’ll use that key from. And then paste the key into the **Key** area. ![](https://kinsta.com/wp-content/uploads/2022/01/title-key-field-1024x587.png)
- Add your SSH key

##### Now test your connection with github

```
ssh -T git@github.com
```

You might get a message like this:
**Hi ensorceler! You've successfully authenticated, but GitHub does not provide shell access.**

Everything is alright then.

### Creation of Git repo

1. Create a Git repo (your own) and push some code/data to the repo.
