variable "ami_id" {
  type        = "string"
}
variable "instance_type" {
  type        = "string"
  description = ""
  default     = "t2.micro"
}
# variable "key_name" {
#   type        = "string"
#   description = ""
# }
variable "monitoring" {
  type        = "string"
  description = ""
  default     = false
}
variable "vol_size" {
  default = 30
}
variable "vol_type" {
  default = "gp2"
}
variable "instance_count" {
  type        = "string"
  description = ""
  default     = 1
}
variable "subnet_ids" {
  type        = "list"
}
variable "project" {
  type        = "string"
}
variable "aws_region" {
  type        = "string"
  description = ""
}
variable "environment" {
  type        = "string"
  description = ""
}
variable "vpc_id" {
  type        = "string"
  description = ""
}
variable "component" {
  default = "test"
}
variable "owner" {
  default = "test"
}
variable "ec2_security_group_ids" {
  type = "list"
}
variable "user_data" {
  default     = ""
}
variable "disable_api_termination" {
  default = false
}

# TerraTest variable
variable "instance_port" {
  default = 8080
}
variable "role" {
  type = "string"
}


