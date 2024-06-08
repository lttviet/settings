#!/bin/bash

echo 'debconf debconf/frontend select Noninteractive' | sudo debconf-set-selections

echo 'Installing sops'
curl -LO https://github.com/getsops/sops/releases/download/v3.8.1/sops-v3.8.1.linux.amd64
sudo mv sops-v3.8.1.linux.amd64 /usr/local/bin/sops
sudo chmod +x /usr/local/bin/sops

echo 'Installing age'
sudo apt-get install age -y

echo 'Installing HashiCorp Packer'
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main" -y
sudo apt-get update && sudo apt-get install packer -y

sudo mkdir -p /mnt/configs /mnt/repos

echo 'export SOPS_AGE_KEY_FILE=/home/viet/key.txt' | tee -a /home/viet/.profile
