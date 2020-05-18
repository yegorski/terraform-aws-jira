module "alb" {
  source = "git::https://github.com/yegorski/terraform-aws-alb.git?ref=master"

  name     = "${var.app_name}"
  app_port = 8080

  load_balancer_interal = false
  security_group_id     = "${aws_security_group.alb.id}"
  subnet_ids            = "${var.subnet_ids}"
  vpc_id                = "${var.vpc_id}"
  region                = "${var.region}"

  tags = "${var.tags}"
}

resource "aws_lb_target_group_attachment" "tg_attachment" {
  target_group_arn = "${ module.alb.tg_arn }"
  target_id        = "${ module.ec2.instance_id }"
  port             = 8080
}
