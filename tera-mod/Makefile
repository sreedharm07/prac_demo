dev:
	rm -rf .terraform
	terraform init -backend-config=env-dev/state.tfvars
	terraform apply -auto-approve -var-file=dev/var.tfvars

destroy:
	terraform init
	terraform destroy -auto-approve -var-file=dev/var.tfvars
