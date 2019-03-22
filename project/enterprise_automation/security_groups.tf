# Windows Server SG
resource "aws_security_group" "win_dev_security_group" {
  name        = "${var.project}-${var.environment}-windows-application-SG"
  description = "security group for ${var.project}-${var.environment}-${var.win_dev_component}"
  vpc_id      = "${module.vpc.vpc_id}"

  tags {
    Name                    = "${var.project}-${var.environment}-${var.win_dev_component}-SG"
    environment             = "${var.environment}"
    owner                   = "${var.owner}"
    project                 = "${var.project}"
    role                    = "aws instance for windows application"
    region                  = "${var.region}"
  }
}

# RDP Access port(3389)
resource "aws_security_group_rule" "win_dev_ingress_3389" {
  description              = "Allow TCP/3389 access from Whitelisted IPs"
  type                     = "ingress"
  from_port                = 3389
  to_port                  = 3389
  protocol                 = "tcp"
  security_group_id        = "${aws_security_group.win_dev_security_group.id}"

  cidr_blocks = [
    "${var.win_dev_rdp_ingress}"
  ]
}

resource "aws_security_group_rule" "win_dev_ingress_80" {
  description              = "Allow TCP/80 access from Whitelisted IPs"
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  security_group_id        = "${aws_security_group.win_dev_security_group.id}"

  cidr_blocks = [
    "${var.win_dev_ingress}"
  ]
}
resource "aws_security_group_rule" "win_dev_ingress_443" {
  description              = "Allow TCP/443 access from Whitelisted IPs"
  type                     = "ingress"
  from_port                = 443
  to_port                  = 443
  protocol                 = "tcp"
  security_group_id        = "${aws_security_group.win_dev_security_group.id}"

  cidr_blocks = [
    "${var.win_dev_ingress}"
  ]
}

resource "aws_security_group_rule" "win_dev_egress_all" {
  description       = "Allow All traffic to Internet"
  type              = "egress"
  from_port         = 0
  to_port           = 65535
  protocol          = "-1"
  security_group_id = "${aws_security_group.win_dev_security_group.id}"

  cidr_blocks = [
    "0.0.0.0/0",
  ]
}

# Linux Server SG
# resource "aws_security_group" "linux_dev_security_group" {
#   name        = "${var.project}-${var.environment}-linux-application-SG"
#   description = "security group for ${var.project}-${var.environment}-${var.linux_dev_component}"
#   vpc_id      = "${module.vpc.vpc_id}"

#   tags {
#     Name                    = "${var.project}-${var.environment}-${var.linux_dev_component}-SG"
#     environment             = "${var.environment}"
#     owner                   = "${var.owner}"
#     project                 = "${var.project}"
#     role                    = "aws instance for Linux application"
#     region                  = "${var.region}"
#   }
# }
# # SSH Access port(22)
# resource "aws_security_group_rule" "linux_dev_ingress_22" {
#   description              = "Allow TCP/22 access from Whitelisted IPs"
#   type                     = "ingress"
#   from_port                = 22
#   to_port                  = 22
#   protocol                 = "tcp"
#   security_group_id        = "${aws_security_group.linux_dev_security_group.id}"

#   cidr_blocks = [
#     "${var.linux_dev_ssh_ingress}"
#   ]
# }
# resource "aws_security_group_rule" "linux_dev_ingress_80" {
#   description              = "Allow TCP/80 access from Whitelisted IPs"
#   type                     = "ingress"
#   from_port                = 80
#   to_port                  = 80
#   protocol                 = "tcp"
#   security_group_id        = "${aws_security_group.linux_dev_security_group.id}"

#   cidr_blocks = [
#     "${var.linux_dev_ingress}"
#   ]
# }
# resource "aws_security_group_rule" "linux_dev_ingress_443" {
#   description              = "Allow TCP/443 access from Whitelisted IPs"
#   type                     = "ingress"
#   from_port                = 443
#   to_port                  = 443
#   protocol                 = "tcp"
#   security_group_id        = "${aws_security_group.linux_dev_security_group.id}"

#   cidr_blocks = [
#     "${var.linux_dev_ingress}"
#   ]
# }
# resource "aws_security_group_rule" "linux_dev_egress_all" {
#   description       = "Allow All traffic to Internet"
#   type              = "egress"
#   from_port         = 0
#   to_port           = 65535
#   protocol          = "-1"
#   security_group_id = "${aws_security_group.linux_dev_security_group.id}"

#   cidr_blocks = [
#     "0.0.0.0/0",
#   ]
# }