resource "aws_key_pair" "key" {
  key_name   = "${var.app_name}"
  public_key = "${var.public_key}"
}

module "ec2" {
  source = "git::https://github.com/yegorski/terraform-aws-ec2.git?ref=master"

  name        = "${var.app_name}"
  size        = "t3.large"        # 2 CPU, 8 GB, for example
  volume_size = "50"

  aws_account_id    = "${var.aws_account_id}"
  ami_lookup_filter = "Amazon Linux 2 Jira AMI*"

  vpc_id            = "${var.vpc_id}"
  subnet_id         = "${var.subnet_ids[0]}"
  security_group_id = "${aws_security_group.ec2.id}"
  region            = "${var.region}"

  associate_public_ip_address = true

  ssh_ip = "${var.ssh_ip}"

  ssh_key_name = "${aws_key_pair.key.key_name}"

  tags = "${var.tags}"
}
