#!/bin/bash

echo 'debconf debconf/frontend select Noninteractive' | sudo debconf-set-selections

sudo mkdir -p /mnt/configs /mnt/repos
echo "//$SAMBA_SERVER/configs /mnt/configs cifs credentials=/home/viet/.smbcredentials,uid=1000,gid=1000 0 0" | sudo tee -a /etc/fstab
echo "//$SAMBA_SERVER/repos /mnt/repos cifs credentials=/home/viet/.smbcredentials,uid=1000,gid=1000 0 0" | sudo tee -a /etc/fstab

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
