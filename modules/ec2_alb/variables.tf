variable "ami_id" {
  type        = "string"
  description = "Default Ubuntu server AMI for terratest"
  default     = "ami-00035f41c82244dab"
}
variable "instance_type" {
  type        = "string"
  description = ""
  default     = "t2.micro"
}
variable "key_name" {
  type        = "string"
  description = ""
  default     = "Terratest_key"
}
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
  default     = 2
}
variable "project" {
  type        = "string"
  description = "test"
}
variable "aws_region" {
  type        = "string"
  description = ""
  default     = "eu-west-1"
}
variable "environment" {
  type        = "string"
  description = ""
  default     = "test"
}
variable "vpc_id" {
  type        = "string"
  description = ""
  default     = "vpc-73e8cd15"
}
variable "source_security_group_id" {
  type    = "string"
  default = "sg-0a65a4454bdbe47df"
}
variable "ec2_ingress" {
  type    = "list"
  default = [
    "80.76.207.49/32",
    "81.103.71.82/32",       # Michael's Home IP
    "34.249.208.82/32"       # Ubuntu terratest box
    ] 
}

variable "ec2_component" {}
variable "role" {
  type = "string"
}
variable "owner" {}

variable "instance_port" {
  description = "The port the EC2 Instance should listen on for HTTP requests."
  default     = 8080
}

variable "instance_text" {
  description = "The text the EC2 Instance should return when it gets an HTTP request."
  default     = "Hello, World!"
}
variable "project" {
  type         = "string"
  description = ""
}
variable "environment" {
  type         = "string"
  description = ""
}
variable "owner"{}
variable "sqs_region"{}


variable "alb_internal" {
  type        = "string"
  description = ""
}
variable "alb_idle_timeout" {
  type        = "string"
  description = ""
  default     = 60
}
variable "alb_connection_draining" {
  type        = "string"
  description = ""
  default     = true
}
variable "alb_connection_draining_timeout" {
  type        = "string"
  description = ""
  default     = 60
}
variable "alb_cross_zone_load_balancing" {
  type        = "string"
  description = ""
  default     = true
}
variable "alb_port" {
  type        = "string"
  description = ""
}
variable "alb_protocol" {
  type        = "string"
  description = ""
}
variable "alb_healthy_threshold" {
  type        = "string"
  description = ""
  default     = 3
}
variable "alb_unhealthy_threshold" {
  type        = "string"
  description = ""
  default     = 2
}
variable "alb_healthcheck_timeout" {
  type        = "string"
  description = ""
  default     = 10
}
variable "alb_healthcheck_interval" {
  type        = "string"
  description = ""
  default     = 15
}
variable "ec2_security_group" {
  type         = "string"
  description = ""
}
variable "vpc_id" {
  type = "string"
  default = ""
}
variable "aws_region" {
  type = "string"
}
variable "subnet_ids" {
  type = "list"
}
variable "target_ids" {
  type = "list"
}
variable "priority" {
  type = "string"
}
variable "target_group_sticky" {

}
variable "target_group_path" {

}
variable "target_group_port" {
  default = ""
}
variable "target_group_name" {
  default = ""
}
variable "aws_alb_listener_protocol" {

}
# variable "alb_path" {}

variable "alb_source_cidr" {
  type = "list"
}
