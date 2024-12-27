default: init

.PHONY: init
init:
		tofu init

.PHONY: plan
plan: init
		tofu fmt
		tofu plan

.PHONY: provision
provision: init
		tofu apply --auto-approve
