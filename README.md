# dragonvpn-community
This repo contains everything you need to automatically generate the necessary infrastructure required to run DVPN:FoeHammer in a isolation.


## What Does It Do? ##
This repo contains two setup scripts inital_setup.sh and create_vpn.sh.

After running inital_setup.sh you will have a new VPC, Subnets, Keys and Security groups in AWS that can be used with a DVPN:FoeHammer setup. The resulting infrastructure should have zero cost at this stage as chargable things like Elastic IPs or Load Balancers are not created.

You can now run create_vpn.sh whenever you like to generate a new VPN server.

## What PreReqs Are There? ##
1) An AWS Account (https://aws.amazon.com/)
2) Install Terraform (https://www.terraform.io/downloads.html)
3) You need to subscribe to FoeHammer (https://aws.amazon.com/marketplace/pp?sku=17o427dphhoas6wr9kqcbztvo)


## How Do I Get Started ##
Once you have created an AWS account, installed Terraform and subsribed to DVPN:FoeHammer you are now ready to create your own resources in AWS.

### Inital Setup ###
This script is responsible for creating the base infrastructure needed to run DVPN:FoeHammer and its only meant to be run once per region in AWS.

For example if you want to run your DVPN:FoeHammer server in the us-east-1 AWS region then you need to change the region in the Terraform and then run:

./inital_setup.sh

Note that if it does not run then you may need to make it executable by running:

chmod +x inital_setup.sh

Once you have run this login to the AWS console and you can see its created a new VPC, subnets and other resources ready for DVPN:FoeHammer.

### Creating a VPN ###
After you have created resources in AWS you now almost ready to run create_vpn.sh whenever you need to have a DVPN:FoeHammer server.

If you want to get your connection file via email then you need to edit foehammer-vpn/main.tf to include your email address.

E.g If your email was 'user@myemailaddress.com' the you would change it from:
echo "_enter_email_address_" >> /home/ubuntu/userdata.txt
to:
echo "user@myemailaddress.com" >> /home/ubuntu/userdata.txt

or if you dont want to get this via email and would prefer to scp it from the server then delete these lines:
userdata_email = <<EOF
#!/bin/bash
echo "_enter_email_address_" >> /home/ubuntu/userdata.txt
EOF

Note you may need to chmod +x to make the create_vpn.sh executable by running:

chmod +x create_vpn.sh

After this to creating a DVPN:FoeHammer server is as easy as running:

./create_vpn.sh
