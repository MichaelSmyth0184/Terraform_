# Web Security Groups
resource "aws_security_group" "web_security_group" {
  name        = "${var.project}-${var.environment}-${var.web_component}-SG"
  description = "security group for ${var.project}-${var.environment}-${var.web_component}"
  vpc_id      = "${module.vpc.vpc_id}"

  tags {
    Name                    = "${var.project}-${var.environment}-${var.web_component}-SG"
    environment             = "${var.environment}"
    owner                   = "${var.owner}"
    project                 = "${var.project}"
    role                    = "aws instance for public web"
    region                  = "${var.aws_region}"
  }
}
resource "aws_security_group_rule" "web_ingress_81" {
  description              = "Allow TCP/81 access from Whitelisted IPs"
  type                     = "ingress"
  from_port                = 81
  to_port                  = 81
  protocol                 = "tcp"
  security_group_id        = "${aws_security_group.web_security_group.id}"

  cidr_blocks = [
    "${var.web_ingress}"
  ]
}
resource "aws_security_group_rule" "web_ingress_8080" {
  description              = "Allow TCP/8080 access from Whitelisted IPs"
  type                     = "ingress"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "tcp"
  security_group_id        = "${aws_security_group.web_security_group.id}"

  cidr_blocks = [
    "${var.web_ingress}"
  ]
}


resource "aws_security_group_rule" "web_ingress_9000" {
  description              = "Allow TCP/9000 access from Whitelisted IPs"
  type                     = "ingress"
  from_port                = 9000
  to_port                  = 9000
  protocol                 = "tcp"
  security_group_id        = "${aws_security_group.web_security_group.id}"

  cidr_blocks = [
    "${var.web_ingress}",
    "${formatlist("%s/32", module.web-api.private_ips)}"
    ]
}
resource "aws_security_group_rule" "web_ingress_3306" {
  description              = "Allow TCP/3306 access from Whitelisted IPs"
  type                     = "ingress"
  from_port                = 3306
  to_port                  = 3306
  protocol                 = "tcp"
  security_group_id        = "${aws_security_group.web_security_group.id}"

  cidr_blocks = [
    "${var.web_ingress}"
  ]
}
resource "aws_security_group_rule" "web_ingress_22" {
  description              = "Allow SSH(tcp)/22 access from Whitelisted IPs"
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  security_group_id        = "${aws_security_group.web_security_group.id}"

  cidr_blocks = [
    "${var.web_ingress}"
  ]
}
resource "aws_security_group_rule" "web_egress_all" {
  description       = "Allow All traffic to Internet"
  type              = "egress"
  from_port         = 0
  to_port           = 65535
  protocol          = "-1"
  security_group_id = "${aws_security_group.web_security_group.id}"

  cidr_blocks = [
    "0.0.0.0/0",
  ]
}

# Web API Security Groups

resource "aws_security_group" "web_api_security_group" {
  name        = "${var.project}-${var.environment}-${var.web_api_component}-SG"
  description = "security group for ${var.project}-${var.environment}-${var.web_api_component}"
  vpc_id      = "${module.vpc.vpc_id}"

  tags {
    Name                    = "${var.project}-${var.environment}-${var.web_api_component}-SG"
    environment             = "${var.environment}"
    owner                   = "${var.owner}"
    project                 = "${var.project}"
    role                    = "aws instance for public web api"
    region                  = "${var.aws_region}"
  }
}
resource "aws_security_group_rule" "web_api_ingress_80" {
  description              = "Allow TCP/80 access from Whitelisted IPs"
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  security_group_id        = "${aws_security_group.web_api_security_group.id}"

  cidr_blocks = [
    "${var.web_api_ingress}"
  ]
}
resource "aws_security_group_rule" "web_api_ingress_443" {
  description              = "Allow TCP/443 access from Whitelisted IPs"
  type                     = "ingress"
  from_port                = 443
  to_port                  = 443
  protocol                 = "tcp"
  security_group_id        = "${aws_security_group.web_api_security_group.id}"

  cidr_blocks = [
    "${var.web_api_ingress}"
  ]
}
resource "aws_security_group_rule" "web_api_ingress_3389" {
  description              = "Allow TCP/3389 access from Whitelisted IPs"
  type                     = "ingress"
  from_port                = 3389
  to_port                  = 3389
  protocol                 = "tcp"
  security_group_id        = "${aws_security_group.web_api_security_group.id}"

  cidr_blocks = [
    "${var.web_api_ingress}"
  ]
}
resource "aws_security_group_rule" "web_api_ingress_9000" {
  description              = "Allow TCP/9000 access from Whitelisted IPs"
  type                     = "ingress"
  from_port                = 9000
  to_port                  = 9000
  protocol                 = "tcp"
  security_group_id        = "${aws_security_group.web_api_security_group.id}"

  cidr_blocks = [
    "${var.web_api_ingress}",
  ]
}
resource "aws_security_group_rule" "web_api_ingress_8080" {
  description              = "Allow TCP/8080 access from Whitelisted IPs"
  type                     = "ingress"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "tcp"
  security_group_id        = "${aws_security_group.web_api_security_group.id}"

  cidr_blocks = [
    "${var.web_api_ingress}"
  ]
}
resource "aws_security_group_rule" "web_api_ingress_8172" {
  description              = "Allow TCP/8172 access from Whitelisted IPs"
  type                     = "ingress"
  from_port                = 8172
  to_port                  = 8172
  protocol                 = "tcp"
  security_group_id        = "${aws_security_group.web_api_security_group.id}"

  cidr_blocks = [
    "${var.web_api_ingress}"
  ]
}
resource "aws_security_group_rule" "web_api_egress_all" {
  description       = "Allow All traffic to Internet"
  type              = "egress"
  from_port         = 0
  to_port           = 65535
  protocol          = "-1"
  security_group_id = "${aws_security_group.web_api_security_group.id}"

  cidr_blocks = [
    "0.0.0.0/0",
  ]
}
