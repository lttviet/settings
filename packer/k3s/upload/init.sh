#!/bin/bash

echo 'Installing nfs client'
sudo apt-get install nfs-common -y

echo 'Installing k3s'
sudo curl -sfL https://get.k3s.io | sh -
