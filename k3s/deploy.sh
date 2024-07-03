#!/bin/bash

kubectl apply -f namespace.yaml
sops -d secrets.yaml | kubectl apply -f -
kubectl apply -f homepage.yaml
kubectl apply -f sillytavern.yaml
kubectl apply -f navidrome.yaml
kubectl apply -f cloudflared.yaml
