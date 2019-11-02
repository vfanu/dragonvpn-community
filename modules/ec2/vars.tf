variable "ec2_count" {
  default = "1"
}

variable "ami_id" {
  default = "ami-02a64f68492092de0"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "vpc_id" {
  default = "vpc-01b31e01064045874"
}

variable "ssh_key" {
  default = ""
}

variable "userdata_email" {
  default = ""
}

variable "spot_price" {
  default = ""
}

variable "request_spot" {
  default = "false"
  type = bool
}

variable "on_demand" {
  default = "true"
  type = bool
}
