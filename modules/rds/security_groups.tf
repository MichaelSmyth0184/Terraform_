resource "aws_security_group" "rds_sg" {
  name        = "${var.project}-${var.environment}-${var.rds_component}-SG}"
  description = "SG for ${var.project}-${var.environment}-${var.rds_component}-rds"
  vpc_id      = "${var.vpc_id}"

  tags {
    Name                    = "${var.project}-${var.environment}-${var.rds_component}-SG"
    environment             = "${var.environment}"
    owner                   = "${var.owner}"
    project                 = "${var.project}"
    role                    = "security group for rds"
    region                  = "${var.sqs_region}"
  }
}

resource "aws_security_group_rule" "rds_ingress_web_1433" {
  description              = "Allow TCP/1433 from web sg"
  type                     = "ingress"
  from_port                = 1433
  to_port                  = 1433
  protocol                 = "tcp"
  security_group_id        = "${aws_security_group.rds_sg.id}"
  source_security_group_id = "${var.source_security_group_id}"
}

resource "aws_security_group_rule" "rds_db_ingress_1433" {
  description              = "Allow TCP/1433 from Whitelisted IPs"
  type                     = "ingress"
  from_port                = 1433
  to_port                  = 1433
  protocol                 = "tcp"
  security_group_id        = "${aws_security_group.rds_sg.id}"

  cidr_blocks = [
    "${var.rds_db_ingress}"
  ]
}

resource "aws_security_group_rule" "rds_db_egress_all_https" {
  description       = "Allow All traffic to Internet"
  type              = "egress"
  from_port         = 0
  to_port           = 65535
  protocol          = "-1"
  security_group_id = "${aws_security_group.rds_sg.id}"

  cidr_blocks = [
    "0.0.0.0/0",
  ]
}
