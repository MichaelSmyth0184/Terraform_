resource "aws_security_group" "alb_sg" {
  name        = "${var.project}-${var.environment}-alb-SG"
  description = "SG for ${var.project}-${var.environment}-alb"
  vpc_id      = "${var.vpc_id}"

  tags {
    Name                    = "${var.project}-${var.environment}-alb-SG"
    environment             = "${var.environment}"
    owner                   = "${var.owner}"
    project                 = "${var.project}"
    role                    = "SG for application loadbalancer"
    sqs_region              = "${var.sqs_region}"
  }
}

resource "aws_security_group_rule" "alb_egress_web_80" {
  description              = "Allow TCP/80 to Web"
  type                     = "egress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  security_group_id        = "${aws_security_group.alb_sg.id}"
  source_security_group_id = "${var.web_security_group}"
}

resource "aws_security_group_rule" "alb_egress_web_443" {
  description              = "Allow TCP/80 to Web"
  type                     = "egress"
  from_port                = 443
  to_port                  = 443
  protocol                 = "tcp"
  security_group_id        = "${aws_security_group.alb_sg.id}"
  source_security_group_id = "${var.web_security_group}"
}

resource "aws_security_group_rule" "alb_ingress_80" {
  description              = "Allow TCP/80 to ALB"
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  security_group_id        = "${aws_security_group.alb_sg.id}"
  cidr_blocks              = ["${var.alb_source_cidr}"]
}
resource "aws_security_group_rule" "alb_ingress_443" {
  description              = "Allow TCP/80 to ALB"
  type                     = "ingress"
  from_port                = 443
  to_port                  = 443
  protocol                 = "tcp"
  security_group_id        = "${aws_security_group.alb_sg.id}"
  cidr_blocks              = ["${var.alb_source_cidr}"]
}

resource "aws_security_group_rule" "ping_ingress_icmp" {
  description              = "Allow ICMP/IPv4 access from Whitelisted IPs"
  type                     = "ingress"
  from_port                = 8
  to_port                  = -1
  protocol                 = "icmp"
  security_group_id        = "${aws_security_group.alb_sg.id}"
  cidr_blocks              = ["${var.alb_source_cidr}"]
}
