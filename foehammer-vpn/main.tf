provider "aws" {
  region = "eu-west-1"
}


module "my_ec2_vpn" {
  source         = "../modules/ec2"
  ec2_count      = "1"
  ami_id         = "ami-02a64f68492092de0"
  instance_type  = "t2.micro"
  spot_price     = "0.0116"
  request_spot   = "true"
  on_demand      = "false"
  ssh_key        = "dvpn_key"
  userdata_email = <<EOF
#!/bin/bash
echo "_enter_email_address_" >> /home/ubuntu/userdata.txt
EOF
}
