
data "aws_vpc" "dvpn_vpc" {
  tags = {
    App = "DVPN:FoeHammer"
  }
}

resource "aws_security_group" "allow_dvpb" {
  name        = "dvpn ports"
  description = "Allow VPN inbound traffic"
  vpc_id = "${data.aws_vpc.dvpn_vpc.id}"

  ingress {
    # TLS (change to whatever ports you need)
    from_port   = 1194
    to_port     = 1194
    protocol    = "udp"
    # Please restrict your ingress to only necessary IPs and ports.
    # Opening to 0.0.0.0/0 can lead to security vulnerabilities.
    cidr_blocks = ["0.0.0.0/0"]# add your IP address here
  }

  ingress {
    # TLS (change to whatever ports you need)
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    # Please restrict your ingress to only necessary IPs and ports.
    # Opening to 0.0.0.0/0 can lead to security vulnerabilities.
    cidr_blocks = ["0.0.0.0/0"]# add your IP address here
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "DVPN"
  }
}
