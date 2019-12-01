#!/bin/sh

echo "Destroying VPN"
echo "Pick it up!"

rm ~/.aws/config
echo "[default]" >> ~/.aws/config
echo "eu-west-1" >> ~/.aws/config

cd foehammer-vpn
terraform destroy -input=false -auto-approve

echo "Destroy complete"
