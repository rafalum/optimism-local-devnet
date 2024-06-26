#!/bin/bash

sudo apt-get update

# Install git
sudo apt-get install -q -y git

# Install vim
sudo apt install vim -y

# Allow sandbox user to poweroff and reboot without password
TMP_FILE=$(mktemp)
trap 'rm -f $TMP_FILE' EXIT
echo "sandbox ALL=(ALL) NOPASSWD: /sbin/poweroff, /sbin/reboot" >> $TMP_FILE
sudo EDITOR="cat $TMP_FILE >>" visudo

# Remove lines 4-9 from .bashrc
sed -i '4,9d' "$HOME/.bashrc"


