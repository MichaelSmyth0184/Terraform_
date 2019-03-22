module "vpc" {
  source = "../../modules/vpc"

  vpc_cidr_block           = "${var.vpc_cidr_block}"
  project                  = "${var.project}"
  environment              = "${var.environment}"
  private_domain_name      = "${var.private_domain_name}"
  aws_region               = "${var.region}" 
  public_subnet_cidrs      = "${var.public_subnet_cidrs}"
  public_subnet_av_zones   = "${var.public_subnet_av_zones}"
  owner                    = "${var.owner}"
}

module "windows_server" {
  source = "../../modules/ec2"

  instance_count           = "${var.win_instance_count}"
  ami_id                   = "${var.win_ami_id}"
  instance_type            = "${var.win_instance_type}"
  subnet_ids               = ["${module.vpc.public_subnet_id_list}"]
  environment              = "Development"
  role                     = "Application-Server"
  project                  = "${var.project}"
  vpc_id                   = "${module.vpc.vpc_id}"
  vol_size                 = "${var.win_vol_size}"
  owner                    = "${var.owner}"
  aws_region               = "${var.region}"
  component                = "${var.win_dev_component}"
  ec2_security_group_ids   = ["${aws_security_group.win_dev_security_group.id}"]
  user_data                = "${var.win_user_data}"
  disable_api_termination  = "${var.disable_dev_api_termination}"
}


# module "linux_server" {
#   source = "../../modules/ec2"

#   instance_count           = "${var.linux_instance_count}"
#   ami_id                   = "${var.linux_ami_id}"
#   instance_type            = "${var.linux_instance_type}"
#   subnet_ids               = ["${module.vpc.public_subnet_id_list}"]
#   environment              = "Develop"
#   role                     = "Application-Server"
#   project                  = "${var.project}"
#   vpc_id                   = "${module.vpc.vpc_id}"
#   vol_size                 = "${var.linux_vol_size}"
#   owner                    = "${var.owner}"
#   aws_region               = "${var.region}"
#   component                = "${var.linux_dev_component}"
#   ec2_security_group_ids   = ["${aws_security_group.linux_dev_security_group.id}"]
#   user_data                = "${var.linux_user_data}"
#   disable_api_termination  = "${var.disable_dev_api_termination}"
# }
