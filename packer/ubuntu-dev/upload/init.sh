#!/bin/bash

echo 'debconf debconf/frontend select Noninteractive' | sudo debconf-set-selections

echo 'Installing sops'
curl -LO https://github.com/getsops/sops/releases/download/v3.8.1/sops-v3.8.1.linux.amd64
sudo mv sops-v3.8.1.linux.amd64 /usr/local/bin/sops
sudo chmod +x /usr/local/bin/sops

echo 'Installing age'
sudo apt-get install age -y
echo 'export SOPS_AGE_KEY_FILE=/home/viet/key.txt' | tee -a /home/viet/.profile

echo 'Installing HashiCorp Packer'
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main" -y
sudo apt-get update && sudo apt-get install packer -y

echo 'Installing samba'
sudo mkdir -p /mnt/configs /mnt/repos
echo "//$SAMBA_SERVER/configs /mnt/configs cifs credentials=/home/viet/.smbcredentials,uid=1000,gid=1000 0 0" | sudo tee -a /etc/fstab
echo "//$SAMBA_SERVER/repos /mnt/repos cifs credentials=/home/viet/.smbcredentials,uid=1000,gid=1000 0 0" | sudo tee -a /etc/fstab
chmod 600 ./.smbcredentials

echo 'Installing ansible'
sudo apt-get install ansible-core sshpass python3-venv -y
