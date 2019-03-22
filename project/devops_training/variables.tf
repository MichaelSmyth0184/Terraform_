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

variable "web_instance_count" {
  type        = "string"
  default = 1
}
variable "web_api_instance_count" {
  type        = "string"
  default = 1
}
variable "web_ingress" {
  type = "list"
}
variable "web_api_ingress" {
  type = "list"
}

variable "web_ami_id" {
  type        = "string"
  description = ""
}
variable "web_api_ami_id" {
  type        = "string"
  description = ""
}
variable "web_instance_type" {
  type = "string"
  default = ""
}
variable "web_api_instance_type" {
  type = "string"
  default = ""
}
variable "web_component" {
  type = "string"
  default = ""
}
variable "web_api_component" {
  type = "string"
}
variable "aws_region" {
  type        = "string"
}
variable "disable_api_termination" {
}
variable "web_user_data" {
}
variable "web_api_user_data" {
  default = ""
} 

variable "web_vol_size" {
}
variable "web_api_vol_size" {
}
variable "web_role" {}
variable "web_api_role" {}
variable "owner" {}
variable "private_domain_name" {}
variable "iam_policy_document" {}
variable "iam_users" {
  type        = "list"
  description = "List of IAM Users"
  default     = []
}
variable "iam_user_group_name" {}
variable "iam_policy_name" {}

