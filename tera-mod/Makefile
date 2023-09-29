dev:
	rm -rf .terraform
	terraform init
	terraform apply -auto-approve -var-file=dev/var.tfvars

destroy:
	terraform init
	terraform destroy -auto-approve -var-file=dev/var.tfvars

prod:
	rm -rf .terraform
	terraform init
	terraform apply -auto-approve -var-file=prod/var.tfvars

destroy_prod:
	terraform init
	terraform destroy -auto-approve -var-file=prod/var.tfvars