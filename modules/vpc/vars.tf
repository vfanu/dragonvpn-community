variable "vpc_cidr" {
  default = "10.10.0.0/16"
}

variable "tenancy" {
  default = "default"
}

variable "vpc_id" {
  default = ""
}

variable "subnet_pub_cidr_a" {
  default = "10.10.0.0/20"
}

variable "subnet_priv_cidr_a" {
  default = "10.10.48.0/20"
}

variable "dns_enabled" {
  default = "true"
}

variable "dns_hostnames_enabled" {
  default = "true"
}

variable "create_nat" {
  default = "false"
  type = bool
}
