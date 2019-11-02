provider "aws" {
  region = "eu-west-1"
}

module "ssh_key" {
  source = "../../modules/ssh-key"
  key_name = "dvpn_key"
  key_path = "${file("dvpn_key.pub")}"
}
