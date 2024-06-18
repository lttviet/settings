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

echo 'Installing nfs client'
sudo apt-get install nfs-common autofs -y
echo '/nfs   /etc/auto.nfs' | sudo tee -a /etc/auto.master
sudo mv /tmp/auto.nfs /etc/auto.nfs

echo 'Installing ansible'
sudo apt-get install ansible-core sshpass python3-venv -y

echo 'Installing kubectl'
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
rm kubectl

# echo 'Installing helm'
# curl https://baltocdn.com/helm/signing.asc | gpg --dearmor | sudo tee /usr/share/keyrings/helm.gpg > /dev/null
# sudo apt-get install apt-transport-https -y
# echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/helm.gpg] https://baltocdn.com/helm/stable/debian/ all main" | sudo tee /etc/apt/sources.list.d/helm-stable-debian.list
# sudo apt-get update
# sudo apt-get install helm
