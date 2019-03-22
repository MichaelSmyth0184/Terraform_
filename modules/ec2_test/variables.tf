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
  default     = 1
}
variable "subnet_ids" {
  type        = "list"
  default     = ["subnet-2f91f767"] 
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
variable "web_ingress" {
  type    = "list"
  default = [
    "80.76.207.49/32",
    "63.32.98.54/32",
    "81.103.71.82/32",       # Michael's Home IP
    "34.249.208.82/32",      # Ubuntu terratest box
    "0.0.0.0/0"
    ] 
}

variable "ec2_component" {}
variable "owner" {}

variable "instance_port" {
  description = "The port the EC2 Instance should listen on for HTTP requests."
  default     = 8080
}

variable "instance_text" {
  description = "The text the EC2 Instance should return when it gets an HTTP request."
  default     = "Hello, World!"
}
