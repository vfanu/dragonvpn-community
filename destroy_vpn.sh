#!/bin/sh

echo "Destroying VPN"

echo "Pick it up!"

cd foehammer-vpn
terraform destroy -input=false -auto-approve

echo "Destroy complete"
