default: init

.PHONY: init
init:
		tofu init

.PHONY: plan
plan:
		tofu fmt
		tofu plan

.PHONY: provision
provision: init
		tofu apply --auto-approve

.PHONY: deploy-k3s
deploy-k3s:
		ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i ansible/inventory.yaml ansible/playbook.yaml
