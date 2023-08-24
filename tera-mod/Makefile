dev:
	rm -rf .terraform
	terraform init
	terraform apply -auto-approve -var-file=mod/var.tfvars

destroy:
	terraform init
	terraform destroy -auto-approve -var-file=mod/var.tfvars