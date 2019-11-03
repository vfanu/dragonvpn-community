# dragonvpn-community
This repo contains everything you need to automatically generate the necessary infrastructure required to run DVPN:FoeHammer in a isolation.


## What Does It Do? ##
This repo contains two setup scripts inital_setup.sh and create_vpn.sh.

After running inital_setup.sh you will have a new VPC, Subnets, Keys and Security groups in AWS that can be used with a DVPN:FoeHammer setup. The resulting infrastructure should have zero cost at this stage as chargable things like Elastic IPs or Load Balancers are not created. 

You can now run create_vpn.sh however and whenever you like to generate a new VPN server.

## What PreReqs Are There? ##
1) An AWS Account (https://aws.amazon.com/) 
2) Install Terraform (https://www.terraform.io/downloads.html)
3) You need to subscribe to FoeHammer (https://aws.amazon.com/marketplace/pp?sku=17o427dphhoas6wr9kqcbztvo)
