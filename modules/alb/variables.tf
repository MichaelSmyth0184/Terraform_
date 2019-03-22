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
variable "web_security_group" {
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
