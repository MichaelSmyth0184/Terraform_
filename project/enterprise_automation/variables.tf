# VPC
variable "vpc_cidr_block" {}
variable "project" {}
variable "environment" {}
variable "private_domain_name" {}
variable "region" {}
variable "public_subnet_cidrs" {
    type = "list"
}
variable "public_subnet_av_zones" {
    type = "list"
}
variable "owner" {}

# Dev Environments
variable "disable_dev_api_termination" {}

# Windows Server
variable "win_instance_count" {}
variable "win_ami_id" {}
variable "win_instance_type" {}
variable "win_vol_size" {}
variable "win_dev_component" {}
variable "win_user_data" {
    default = ""
}
variable "win_dev_ingress" {
    type = "list"
}

variable "win_dev_rdp_ingress" {
  type = "list"
}

#  Linux Server
# variable "linux_instance_count" {}
# variable "linux_ami_id" {}
# variable "linux_instance_type" {}
# variable "linux_vol_size" {}
# variable "linux_dev_component" {}
# variable "linux_user_data" {
#     default = ""
# }
# variable "linux_dev_ingress" {
#     type = "list"
# }

# variable "linux_dev_ssh_ingress" {
#   type = "list"
# }

# Dynamo DB
variable "table_name" {}
variable "read_capacity" {}
variable "write_capacity" {}
variable "hash_key" {}
variable "range_key" {}