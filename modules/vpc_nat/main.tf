resource "aws_vpc" "vpc" {
  cidr_block           = "${var.vpc_cidr_block}"
  enable_dns_hostnames = true
  enable_dns_support   = true
  instance_tenancy     = "default"
  lifecycle = {
    
  }

  tags {
    Name                    = "${var.project}-${var.environment}-vpc"
    environment             = "${var.environment}"
    owner                   = "${var.owner}"
    project                 = "${var.project}"
    role                    = "virtual private cloud"
    region                  = "${var.aws_region}"
  }
}

resource "aws_vpc_dhcp_options" "vpc_dhcp_options" {
  domain_name         = "${var.environment}.${var.private_domain_name}"
  domain_name_servers = ["AmazonProvidedDNS"]

  tags = {
    Name                    = "${var.project}-${var.environment}-dhcp"
    environment             = "${var.environment}"
    owner                   = "${var.owner}"
    project                 = "${var.project}"
    role                    = "dynamic host configuration protocol"
    region                  = "${var.aws_region}"
  }
}

resource "aws_vpc_dhcp_options_association" "vpc_dhcp_options_association" {
  vpc_id          = "${aws_vpc.vpc.id}"
  dhcp_options_id = "${aws_vpc_dhcp_options.vpc_dhcp_options.id}"
}

data "template_file" "vpc_tags" {
  template        = "${lookup(aws_vpc.vpc.tags, "Name")}"
}
