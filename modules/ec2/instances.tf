
data "aws_vpc" "dvpn_vpc" {
  tags = {
    App = "DVPN:FoeHammer"
  }
}

data "aws_subnet_ids" "public" {
  #vpc_id = "${data.aws_vpc.dvpn_vpc.id}"
  #count = "${length(data.aws_vpc.dvpn_vpc.ids)}"
  vpc_id = "${data.aws_vpc.dvpn_vpc.id}"
  tags = {
    Subnet_Type = "public"
  }
}

data "aws_security_group" "dvpn" {
  tags = {
    Name = "DVPN"
  }
}


resource "aws_instance" "vpn" {
  #count = "${length(data.aws_subnet_ids.public.ids)}"
  #subnet_id    = "${tolist(data.aws_subnet_ids.public.ids)[count.index]}"
  count = "${var.on_demand ? 1 : 0}"

  subnet_id    = "${tolist(data.aws_subnet_ids.public.ids)[0]}"
  vpc_security_group_ids = ["${tostring(data.aws_security_group.dvpn.id)}"]
  #vpc_security_group_ids = "${tolist(data.aws_security_group.dvpn.ids)[sec_group_count.index]}"
  ami           = "${var.ami_id}"
  instance_type = "${var.instance_type}"
  user_data     = "${var.userdata_email}"
  key_name      = "${var.ssh_key}"
  associate_public_ip_address = true

  tags = {
    Name = "DVPN"
    Type = "On Demand"
  }
}

resource "aws_spot_instance_request" "spot_vpn" {
  count = "${var.request_spot ? 1 : 0}"

  subnet_id    = "${tolist(data.aws_subnet_ids.public.ids)[0]}"
  vpc_security_group_ids = ["${tostring(data.aws_security_group.dvpn.id)}"]
  #vpc_security_group_ids = "${tolist(data.aws_security_group.dvpn.ids)[sec_group_count.index]}"
  ami           = "${var.ami_id}"
  instance_type = "${var.instance_type}"
  user_data     = "${var.userdata_email}"
  key_name      = "${var.ssh_key}"
  spot_price    = "${var.spot_price}"
  associate_public_ip_address = true

  tags = {
    Name = "DVPN"
    Type = "Spot"
  }
}

output "subnets" {
  value = ["${data.aws_subnet_ids.public.ids}"]
}
