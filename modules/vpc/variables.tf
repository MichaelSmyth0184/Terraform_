variable "vpc_cidr_block" {
  type         = "string"
  description = ""
}
variable "project" {
  type        = "string"
  description = ""
}
variable "owner" {
  type        = "string"
  description = ""
}
variable "environment" {
  type        = "string"
  description = ""
}
variable "aws_region" {
  type        = "string"
  description = ""
}
variable "private_domain_name" {
  type        = "string"
  description = ""
}
variable "public_subnet_cidrs" {
  type        = "list"
  description = ""
}
variable "public_subnet_av_zones" {
  type        = "list"
  description = ""
}
