default: init

.PHONY: init
init:
		tofu init

.PHONY: fmt
fmt:
		tofu fmt

.PHONY: plan
plan: fmt
		tofu plan

.PHONY: deploy
deploy: init
		tofu apply --auto-approve
		sleep 10
		ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i ansible/inventory.yaml ansible/playbook.yaml
