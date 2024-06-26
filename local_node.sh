#!/bin/bash

sudo apt update && sudo apt upgrade -y

# Basics
sudo apt-get remove needrestart -y
sudo apt install -y make jq
sudo apt install build-essential -y
sudo apt install python3-pip -y

# Rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

# Docker
sudo apt-get update
sudo apt-get install ca-certificates curl gnupg
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg

echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update

sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y

echo docker compose '$*' | sudo tee /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose 

sudo usermod -aG docker sandbox
newgrp docker
exit

# Node
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
source "$HOME/.bashrc"
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
nvm install 16
nvm use 16

# Pnpm
curl -fsSL https://get.pnpm.io/install.sh | bash
source "$HOME/.bashrc"

# Go
sudo apt update
wget https://go.dev/dl/go1.21.5.linux-amd64.tar.gz
tar xvzf go1.21.5.linux-amd64.tar.gz
sudo cp go/bin/go /usr/bin/go
sudo mv go /usr/lib
echo export GOROOT=/usr/lib/go >> ~/.bashrc
. ~/.bashrc

# Optimism
git clone https://github.com/ethereum-optimism/optimism.git
cd optimism
git submodule update --init --recursive

# Foundry
pnpm install
pnpm install:foundry


