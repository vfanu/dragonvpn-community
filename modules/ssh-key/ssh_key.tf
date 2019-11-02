resource "aws_key_pair" "terraform_ec2_key" {
  key_name = "${var.key_name}"
  public_key = "${var.key_path}"
}
