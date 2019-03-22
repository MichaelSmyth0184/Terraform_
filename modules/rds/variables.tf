variable "rds_allocated_storage" {}
variable "rds_storage_type" {}
variable "rds_engine" {}
variable "rds_engine_version" {}
variable "rds_instance_class" {}
variable "rds_username" {}
variable "rds_password" {}
variable "rds_component" {}
variable "rds_parameter_group_name" {}
variable "rds_public_subnet_ids" {
  type = "list"
}
variable "rds_private_subnet_ids" {
  type = "list"
}
variable "rds_db_ingress" {
  type = "list"
}
variable "db_family" {}
variable "source_security_group_id" {}
variable "project" {}
variable "environment" {}
variable "aws_region" {}
variable "vpc_id" {}
variable "rds_identifier" {}
variable "owner" {}
variable "sqs_region" {}