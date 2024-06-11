#!/bin/bash

echo 'debconf debconf/frontend select Noninteractive' | sudo debconf-set-selections

echo 'Installing samba server'
sudo apt-get install samba -y
sudo mkdir -p /shares/configs /shares/download /shares/repos /shares/media /shares/logs
sudo adduser --system --group $SAMBA_USERNAME
sudo chmod 775 -R /shares
sudo chown $SAMBA_USERNAME:$SAMBA_USERNAME -R /shares
echo "$SAMBA_PASSWORD\n$SAMBA_PASSWORD" | sudo smbpasswd -a -s $SAMBA_USERNAME
sudo mv /etc/samba/smb.conf /etc/samba/smb.conf.old
sudo mv /tmp/smb.conf /etc/samba/smb.conf"
