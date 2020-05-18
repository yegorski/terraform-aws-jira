resource "aws_security_group" "alb" {
  name        = "${var.app_name}-alb"
  description = "Allows ingress from the internet on ports 80 and 443 and egress to the internet."
  vpc_id      = "${var.vpc_id}"

  ingress {
    protocol    = "TCP"
    from_port   = "80"
    to_port     = "80"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    protocol    = "TCP"
    from_port   = "443"
    to_port     = "443"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = "${var.tags}"
}

resource "aws_security_group" "ec2" {
  name        = "${var.app_name}-ec2"
  description = "Allows ingress from load balancer and egress to the internet."
  vpc_id      = "${var.vpc_id}"

  ingress {
    protocol        = "-1"
    from_port       = "0"
    to_port         = "0"
    security_groups = ["${aws_security_group.alb.id}"]
  }

  ingress {
    protocol  = "TCP"
    from_port = "22"
    to_port   = "22"

    cidr_blocks = [
      "10.0.0.0/8",
      "${var.ssh_ip}/32",
    ]
  }

  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = "${var.tags}"
}

resource "aws_security_group" "rds" {
  name        = "${var.app_name}-rds"
  description = "Allows port 5432 ingress and egress from/to the Jira server."
  vpc_id      = "${var.vpc_id}"

  ingress {
    protocol        = "TCP"
    from_port       = "5432"
    to_port         = "5432"
    security_groups = ["${aws_security_group.ec2.id}"]
  }

  egress {
    protocol        = "TCP"
    from_port       = "5432"
    to_port         = "5432"
    security_groups = ["${aws_security_group.ec2.id}"]
  }

  tags = "${var.tags}"
}
