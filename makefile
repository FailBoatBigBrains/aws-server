ssh:
	ssh -i ~/.ssh/conan.pem ubuntu@3.239.220.144

apply:
	terraform apply -auto-approve

plan:
	terraform plan

destroy:
	terraform destroy -auto-approve

refresh:
	terraform refresh

output:
	terraform output