resource "aws_security_group" "ec2_security_group" {
  name        = "${var.project}-${var.environment}-${var.ec2_component}-SG"
  description = "security group for ${var.project}-${var.environment}-${var.ec2_component}"
  vpc_id      = "${var.vpc_id}"

  tags {
    Name                    = "${var.project}-${var.environment}-${var.ec2_component}-SG"
    environment             = "${var.environment}"
    owner                   = "${var.owner}"
    project                 = "${var.project}"
    role                    = "aws instance for public web"
    region                  = "${var.aws_region}"
  }
}

resource "aws_security_group_rule" "ec2_ingress_elb_80" {
  description              = "Allow TCP/80 from ELB"
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  security_group_id        = "${aws_security_group.web_security_group.id}"
  source_security_group_id = "${var.source_security_group_id}"
}

resource "aws_security_group_rule" "web_ingress_elb_443" {
  description              = "Allow TCP/80 from ELB"
  type                     = "ingress"
  from_port                = 443
  to_port                  = 443
  protocol                 = "tcp"
  security_group_id        = "${aws_security_group.web_security_group.id}"
  source_security_group_id = "${var.source_security_group_id}"
}


resource "aws_security_group_rule" "web_ingress_3389" {
  description              = "Allow (RDP)TCP/3389 access from Whitelisted IPs"
  type                     = "ingress"
  from_port                = 3389
  to_port                  = 3389
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

resource "aws_security_group_rule" "web_egress_all_https" {
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
