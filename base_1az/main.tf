provider "aws" {
  region = "eu-west-1"
}

module "myvpc" {
  source      = "../modules/vpc"
  vpc_cidr    = "10.10.0.0/16"
  tenancy     = "default"
  vpc_id      = "${module.myvpc.vpc_id}"
  dns_enabled = "true"
  dns_hostnames_enabled = "true"
  subnet_pub_cidr_a = "10.10.0.0/20"
  subnet_priv_cidr_a = "10.10.48.0/20"
  create_nat = "false"
}
