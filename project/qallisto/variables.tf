variable "vpc_cidr_block" {
  type        = "string"
  description = ""
}
variable "project" {
  type        = "string"
  description = ""
}
variable "environment" {
  type        = "string"
  description = ""
}
variable "public_subnet_cidrs" {
  type        = "list"
}
variable "public_subnet_av_zones" {
    type      = "list"
}
variable "private_subnet_cidrs" {
  type        = "list"
}
variable "private_subnet_av_zones" {
    type      = "list"
}
variable "web_instance_count" {
  type        = "string"
  description = ""
}
variable "web_ingress" {
  type = "list"
}
variable "ami_id" {
  type        = "string"
  description = ""
}
variable "private_domain_name" {
  type = "string"
  description = ""
}
variable "alb_port" {
  type = "string"
  description = ""
}
variable "instance_type" {
  type = "string"
  description = ""
}
variable "ec2_component" {

}
variable "aws_region" {
  type = "string"
  description = ""
}
variable "key_name" {
  type = "string"
  description = ""
  default = ""
}
# variable "volume_tags" {
#   type    = "map"
# }
variable "alb_internal" {
  default = ""
  type    = "string"
}
variable "alb_protocol" {
  type = "string"
  default = ""
}
# variable "av_zone_web" {}
variable "vol_size" {

}
variable "target_group_sticky"{}
variable "priority"{}
variable "target_group_path" {}
variable "target_group_port" {}
variable "alb_source_cidr" {
  type = "list"
}

# RDS
variable "rds_allocated_storage" {}
variable "rds_storage_type" {}
variable "rds_engine" {}
variable "rds_engine_version" {}
variable "rds_instance_class" {}
variable "rds_username" {}
variable "rds_password" {}
variable "rds_parameter_group_name" {}
variable "rds_db_ingress" {
  type = "list"
}
variable "rds_component" {}
variable "rds_identifier" {}
variable "db_family" {
}
variable "owner" {}
variable "sqs_region" {}