#!/bin/bash
_assert_not_empty() {
  local -r arg_name="$1"
  local -r arg_value="$2"

  if [[ -z "$arg_value" ]]; then
    echo "ERROR" "The value for '$arg_name' cannot be empty"
    exit 1
  fi
}

_assert_is_installed() {
  local -r name="$1"

  if [[ ! $(command -v "$name") ]]; then
    echo "ERROR" "The binary '$name' is required by this script but is not installed or in the system's PATH."
    exit 1
  fi
}

# make sure tools are installed
  _assert_is_installed "git"
  _assert_is_installed "terraform"
  _assert_is_installed "docker"
  _assert_is_installed "ansible"

# make sure env variables are not empty
_assert_not_empty TF_VAR_do_token $TF_VAR_do_token
_assert_not_empty TF_VAR_ssh_key_fingerprint $TF_VAR_ssh_key_fingerprint
_assert_not_empty DOCKERHUB_ACCESS_TOKEN $DOCKERHUB_ACCESS_TOKEN
_assert_not_empty DOCKERHUB_USERNAME $DOCKERHUB_USERNAME
# Change directory to docker/nginx
cd docker/nginx

# Start build_and_push_docker_image.sh
./build_and_push_docker_image.sh

# Change directory back to the original location
cd -

# Change directory to terraform
cd terraform

# Run Terraform commands
terraform init
terraform plan
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
