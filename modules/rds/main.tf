resource "aws_db_instance" "rds_db" {
  identifier           = "${var.rds_identifier}"
  allocated_storage    = "${var.rds_allocated_storage}"
  storage_type         = "${var.rds_storage_type}"
  engine               = "${var.rds_engine}"
  engine_version       = "${var.rds_engine_version}"
  instance_class       = "${var.rds_instance_class}"
  username             = "${var.rds_username}"
  password             = "${var.rds_password}"
  parameter_group_name = "${aws_db_parameter_group.rds_db_parameter_group.name}"
  skip_final_snapshot  = true
  db_subnet_group_name = "${aws_db_subnet_group.rds_db_subnet_group.name}"
  vpc_security_group_ids = ["${aws_security_group.rds_sg.id}"]
}

resource "aws_db_subnet_group" "rds_db_subnet_group" {
  name       = "main"
  subnet_ids = ["${var.rds_public_subnet_ids}", "${var.rds_private_subnet_ids}"]

  tags {
    Name                    = "${var.project}-${var.environment}-${var.rds_component}-rds-subnet-group"
    environment             = "${var.environment}"
    owner                   = "${var.owner}"
    project                 = "${var.project}"
    role                    = "subnet group for rds database"
    region                  = "${var.sqs_region}"
  }
}

resource "aws_db_parameter_group" "rds_db_parameter_group" {
  name   = "${var.rds_parameter_group_name}"
  family = "${var.db_family}"

}
