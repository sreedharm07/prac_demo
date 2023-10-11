devd:
	rm -rf .terraform
	terraform init -backend=dev/state.tfvars
	terraform apply -auto-approve -var-file=dev/var.tfvars

destroyd:
	terraform init
	terraform destroy -auto-approve -var-file=dev/var.tfvars

prodp:
	git pull
	rm -rf .terraform
	terraform init -backend-config=prod/state.tfvars
	terraform apply -auto-approve -var-file=prod/var.tfvars

destroyp:
	terraform destroy auto-approve -var/file=prod/var.tfvars