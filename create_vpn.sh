#!/bin/bash

echo "Creating VPN"
cd foehammer-vpn
terraform init -input=false
terraform apply -input=false -auto-approve

echo "Create complete"
