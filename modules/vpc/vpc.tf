resource "aws_vpc" "main" {
  cidr_block       = "${var.vpc_cidr}"
  enable_dns_support = "${var.dns_enabled}"
  enable_dns_hostnames = "${var.dns_hostnames_enabled}"
  tags = {
    App = "DVPN:FoeHammer"
  }
}

resource "aws_subnet" "public_main" {
  vpc_id     = "${aws_vpc.main.id}"
  cidr_block = "${var.subnet_pub_cidr_a}"

  tags = {
    App = "DVPN:FoeHammer"
    Subnet_Type = "public"
  }
}

resource "aws_subnet" "private_main" {
  vpc_id     = "${aws_vpc.main.id}"
  cidr_block = "${var.subnet_priv_cidr_a}"

  tags = {
    App = "DVPN:FoeHammer"
    Subnet_Type = "private"
  }
}

resource "aws_eip" "nat_ip" {
  count = "${var.create_nat ? 1 : 0}"
  vpc = true
  tags = {
    Name = "DVPN:FoeHammer"
  }
}

resource "aws_nat_gateway" "nat" {
  count = "${var.create_nat ? 1 : 0}"

  subnet_id = "${aws_subnet.private_main.id}"
  allocation_id = "${aws_eip.nat_ip[count.index].id}"
  tags = {
    App = "DVPN:FoeHammer"
    Name = "NAT Gateway"
  }
}

resource "aws_internet_gateway" "inet-gateway" {
  vpc_id = "${aws_vpc.main.id}"

  tags = {
    App = "DVPN:FoeHammer"
    Name = "INET Gateway"
  }

}

resource "aws_route_table" "priv_snet_a_route_table" {
  vpc_id = "${aws_vpc.main.id}"
  tags = {
    App = "DVPN:FoeHammer"
    Name = "Internal snet"
  }
}

resource "aws_route_table" "public_snet_a_route_table" {
  vpc_id = "${aws_vpc.main.id}"
  tags = {
    App = "DVPN:FoeHammer"
    Name = "External snet"
  }
}

resource "aws_route" "public_internet_gateway" {

  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.inet-gateway.id}"
  route_table_id         = "${aws_route_table.public_snet_a_route_table.id}"

  timeouts {
    create = "5m"
  }

}

resource "aws_route" "nat_gateway_route" {
  count = "${var.create_nat ? 1 : 0}"

  destination_cidr_block = "0.0.0.0/0"
  route_table_id = "${aws_route_table.priv_snet_a_route_table.id}"
  nat_gateway_id = "${aws_nat_gateway.nat[count.index].id}"

  timeouts {
    create = "5m"
  }
}

resource "aws_route_table_association" "public" {

  subnet_id = "${aws_subnet.public_main.id}"
  route_table_id = "${aws_route_table.public_snet_a_route_table.id}"

}

resource "aws_route_table_association" "private" {

  subnet_id = "${aws_subnet.private_main.id}"
  route_table_id = "${aws_route_table.priv_snet_a_route_table.id}"
}

output "vpc_id" {
  value = "${aws_vpc.main.id}"
}

output "public_subnet_a_id" {
  value = "${aws_subnet.public_main.id}"
}

output "private_subnet_a_id" {
  value = "${aws_subnet.private_main.id}"
}
