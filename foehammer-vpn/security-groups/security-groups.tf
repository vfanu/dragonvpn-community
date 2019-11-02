provider "aws" {
  region = "eu-west-1"
}

module "aws_security_group" {
  source = "../../modules/security-groups"
  vpc_id = ""
}
