#!/bin/bash

echo 'Installing k3s'
sudo curl -sfL https://get.k3s.io | sh -

echo 'Installing samba'
sudo mkdir -p /mnt/configs
echo "//$SAMBA_SERVER/configs /mnt/configs cifs credentials=/home/viet/.smbcredentials,uid=1000,gid=1000 0 0" | sudo tee -a /etc/fstab
