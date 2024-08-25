#!/bin/bash

if [ -z $SOPS_AGE_KEY_FILE ]; then
    echo "Error: SOPS_AGE_KEY_FILE is not set."
    exit 1
fi

sops -d ../docker-compose/adguard/compose2.enc.yaml > ../docker-compose/adguard/compose2.yaml

ansible-playbook -i hosts.yaml start-ad2.yml -kK
