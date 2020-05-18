output "db_endpoint" {
  description = "The RDS connection endpoint."
  value       = "${module.rds.this_db_instance_endpoint}"
}

output "db_password" {
  description = "Database password (this password may be old, because Terraform doesn't track it after initial creation)."
  value       = "${module.rds.this_db_instance_password}"
}

output "db_port" {
  description = "Database port."
  value       = "${module.rds.this_db_instance_port}"
}

output "db_username" {
  description = "Database username."
  value       = "${module.rds.this_db_instance_username}"
}

output "load_balancer_dns_name" {
  value = "${module.alb.dns_name}"
}

output "private_ip" {
  value = "${module.ec2.private_ip}"
}

output "public_ip" {
  value = "${module.ec2.public_ip}"
}
