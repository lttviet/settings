.PHONY: plan
plan:
		$(MAKE) -C terraform plan

.PHONY: provision
provision:
		$(MAKE) -C terraform provision
