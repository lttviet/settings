.PHONY: deploy-k3s
deploy-k3s:
		ANSIBLE_HOST_KEY_CHECKING=False \
			ansible-playbook -i inventory.yaml playbook.yaml
