#!/bin/bash

if [ -z $SOPS_AGE_KEY_FILE ]; then
    echo "Error: SOPS_AGE_KEY_FILE is not set."
    exit 1
fi

sops -d variables.json > plaintext.json
packer build -var-file="plaintext.json" .
