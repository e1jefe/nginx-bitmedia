#!/bin/bash

# Change directory to docker/nginx
cd docker/nginx

# Start build_and_push_docker_image.sh
./build_and_push_docker_image.sh

# Change directory back to the original location
cd -

# Change directory to terraform
cd terraform

# Run Terraform commands
terraform plan
terraform init
terraform apply -auto-approve

# Wait for the completion of Terraform apply
while ! terraform output -json public_ip_server > /dev/null 2>&1; do
    sleep 10
done

# Retrieve public IP from Terraform output
public_ip=$(terraform output -raw public_ip_server)

# Change directory back to the original location
cd -

# Change directory to terraform
cd ansible

# Add public IP to inventory.ini
echo ${public_ip} >> inventory.ini

# Run Ansible playbook
ansible-playbook -i inventory.ini nginx.yml -u nginx-bitmedia