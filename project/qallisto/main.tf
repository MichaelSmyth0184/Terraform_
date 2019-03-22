
module "vpc" {
  source = "../../modules/vpc"

  vpc_cidr_block                               = "${var.vpc_cidr_block}"
  project                                      = "${var.project}"
  environment                                  = "${var.environment}"
  private_domain_name                          = "${var.private_domain_name}"
  aws_region                                   = "${var.aws_region}"
  public_subnet_cidrs                          = "${var.public_subnet_cidrs}"
  public_subnet_av_zones                       = "${var.public_subnet_av_zones}"
  private_subnets_cidrs                        = "${var.private_subnet_cidrs}"
  private_subnet_av_zones                      = "${var.private_subnet_av_zones}"
  owner                                        = "${var.owner}"
  sqs_region                                   = "${var.sqs_region}"

}

module "web" {
  source = "../../modules/web"

  instance_count           = "${var.web_instance_count}"
  ami_id                   = "${var.ami_id}"
  instance_type            = "${var.instance_type}"
  web_subnet_ids           = ["${module.vpc.public_subnet_id_list}"]
  key_name                 = "${var.key_name}"
  environment              = "${var.environment}"
  aws_region               = "${var.aws_region}"
  source_security_group_id = "${module.alb.alb_sg_id}"
  project                  = "${var.project}"
  vpc_id                   = "${module.vpc.vpc_id}"
  vol_size                 = "${var.vol_size}"
  web_ingress              = ["${var.web_ingress}"]
  owner                    = "${var.owner}"
  sqs_region               = "${var.sqs_region}"
  ec2_component            = "${var.ec2_component}"   
}

module "alb" {
  source = "../../modules/alb"

  project                   = "${var.project}"
  environment               = "${var.environment}"
  alb_internal              = "${var.alb_internal}"
  alb_port                  = "${var.alb_port}"
  web_security_group        = "${module.web.web_security_group_id}"
  vpc_id                    = "${module.vpc.vpc_id}"
  alb_protocol              = "${var.alb_protocol}"
  aws_region                = "${var.aws_region}"
  subnet_ids                = ["${module.vpc.public_subnet_id_list}"]
  target_group_sticky       = "${var.target_group_sticky}"
  priority                  = "${var.priority}"
  target_group_path         = "${var.target_group_path}"
  target_group_port         = "${var.target_group_port}"
  target_ids                = "${module.web.web_ec2_ids}"
  aws_alb_listener_protocol = "${var.alb_protocol}"
  alb_source_cidr           = "${var.alb_source_cidr}"
  owner                     = "${var.owner}"
  sqs_region                = "${var.sqs_region}"
}

module "rds" {
  source = "../../modules/rds"

  project                  = "${var.project}"
  environment              = "${var.environment}"
  vpc_id                   = "${module.vpc.vpc_id}"
  rds_allocated_storage    = "${var.rds_allocated_storage}"
  rds_storage_type         = "${var.rds_storage_type}"
  rds_engine               = "${var.rds_engine}"
  rds_engine_version       = "${var.rds_engine_version}"
  rds_instance_class       = "${var.rds_instance_class}"
  rds_username             = "${var.rds_username}"
  rds_password             = "${var.rds_password}"
  rds_parameter_group_name = "${var.rds_parameter_group_name}"
  rds_public_subnet_ids    = ["${module.vpc.public_subnet_id_list}"]
  rds_private_subnet_ids   = ["${module.vpc.private_subnet_id_list}"]
  rds_db_ingress           = ["${var.rds_db_ingress}"]
  db_family                = "${var.db_family}"
  source_security_group_id = "${module.web.web_security_group_id}"
  aws_region               = "${var.aws_region}"
  rds_identifier           = "${var.rds_identifier}"
  owner                    = "${var.owner}"
  sqs_region               = "${var.sqs_region}"
  rds_component            = "${var.rds_component}"
}
