#!/bin/bash

sudo apt-get update

# Install git
sudo apt-get install -q -y git

# Install vim
sudo apt install vim -y

# Remove lines 4-9 from .bashrc
sed -i '4,9d' "$HOME/.bashrc"


