#!/bin/bash

echo "Creating new AWS resources ..."
cd base_1az
terraform init -input=false
terraform apply -input=false -auto-approve

echo "Creating ssh keys ... "
cd ../foehammer-vpn/ssh
terraform init -input=false
sh create_sshkey.sh
terraform apply -input=false -auto-approve

echo "Creating security groups ..."
cd ../security-groups
terraform init -input=false
terraform apply -input=false -auto-approve

echo "Success! AWS Resources created."


