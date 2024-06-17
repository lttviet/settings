#!/bin/bash

if [ -z $SOPS_AGE_KEY_FILE ]; then
    echo "Error: SOPS_AGE_KEY_FILE is not set."
    exit 1
fi

sops -d ../docker-compose/adguard/compose.enc.yaml > ../docker-compose/adguard/compose.yaml

ansible-playbook -i hosts.yaml start-ad.yml -kK
