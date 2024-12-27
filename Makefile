.PHONY: plan
plan:
		$(MAKE) -C terraform plan

.PHONY: provision
provision:
		$(MAKE) -C terraform provision

.PHONY: deploy-k3s
deploy-k3s:
		$(MAKE) -C ansible deploy-k3s
