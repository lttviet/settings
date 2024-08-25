#!/bin/bash

echo 'debconf debconf/frontend select Noninteractive' | sudo debconf-set-selections

echo 'Installing common apps'
sudo apt-get install curl ca-certificates unattended-upgrades -y

echo 'Installing nfs client'
sudo apt-get install nfs-common autofs -y
echo "/nfs   /etc/auto.nfs" | sudo tee -a /etc/auto.master
echo "repos           -fstype=nfs4            $NAS_SERVER:/repos" | sudo tee -a /etc/auto.nfs
echo "configs         -fstype=nfs4            $NAS_SERVER:/configs" | sudo tee -a /etc/auto.nfs

echo 'Installing docker'
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update && sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y
sudo usermod -aG docker $SSH_USERNAME
