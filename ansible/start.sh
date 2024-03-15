#!/bin/bash
ansible-playbook -i hosts.yaml start-behind.yml -k
# ansible-playbook -i hosts.yaml start-cf.yml -k
# ansible-playbook -i hosts.yaml start-log-collector.yml -k
# ansible-playbook -i hosts.yaml start-wg.yml -k
