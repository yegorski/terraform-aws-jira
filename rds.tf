module "rds" {
  source = "git::https://github.com/terraform-aws-modules/terraform-aws-rds.git?ref=terraform011"

  name       = "${var.app_name}"
  identifier = "${var.app_name}"

  instance_class = "db.t2.micro"

  engine                    = "postgres"
  engine_version            = "9.6.3"
  family                    = "postgres9.6"
  major_engine_version      = "9.6"
  final_snapshot_identifier = "postgresdb"
  allocated_storage         = 5
  storage_encrypted         = false

  port     = "5432"
  username = "${var.database_username}"
  password = "${var.database_password}"

  vpc_security_group_ids = ["${aws_security_group.rds.id}"]
  subnet_ids             = ["${var.subnet_ids}"]

  maintenance_window      = "Mon:00:00-Mon:03:00"
  backup_window           = "03:00-06:00"
  backup_retention_period = 0                     # disabled
  deletion_protection     = true

  tags = "${var.tags}"
}
