module "vpc" {
  source = "../../modules/vpc"

  vpc_cidr_block           = "${var.vpc_cidr_block}"
  project                  = "${var.project}"
  environment              = "${var.environment}"
  private_domain_name      = "${var.private_domain_name}"
  aws_region               = "${var.aws_region}" 
  public_subnet_cidrs      = "${var.public_subnet_cidrs}"
  public_subnet_av_zones   = "${var.public_subnet_av_zones}"
  owner                    = "${var.owner}"
}

module "web" {
  source = "../../modules/ec2"

  instance_count           = "${var.web_instance_count}"
  ami_id                   = "${var.web_ami_id}"
  instance_type            = "${var.web_instance_type}"
  subnet_ids               = ["${module.vpc.public_subnet_id_list}"]
  environment              = "${var.environment}"
  role                     = "${var.web_role}"
  project                  = "${var.project}"
  vpc_id                   = "${module.vpc.vpc_id}"
  vol_size                 = "${var.web_vol_size}"
  owner                    = "${var.owner}"
  aws_region               = "${var.aws_region}"
  component                = "${var.web_component}"
  ec2_security_group_ids   = ["${aws_security_group.web_security_group.id}"]
  user_data                = "${var.web_user_data}"
  disable_api_termination  = "${var.disable_api_termination}"
}

module "web-api" {
   source = "../../modules/ec2"
   
  instance_count           = "${var.web_api_instance_count}"
  ami_id                   = "${var.web_api_ami_id}"
  instance_type            = "${var.web_api_instance_type}"
  subnet_ids               = ["${module.vpc.public_subnet_id_list}"]
  environment              = "${var.environment}"
  role                     = "${var.web_api_role}"
  aws_region               = "${var.aws_region}"
  project                  = "${var.project}"
  vpc_id                   = "${module.vpc.vpc_id}"
  vol_size                 = "${var.web_api_vol_size}"
  owner                    = "${var.owner}"
  component                = "${var.web_api_component}"
  ec2_security_group_ids   = ["${aws_security_group.web_api_security_group.id}"]
  user_data                = "${var.web_api_user_data}"
  disable_api_termination  = "${var.disable_api_termination}"
}

module "iam" {
    source = "../../modules/iam"

    iam_users              = ["${var.iam_users}"]
    iam_user_group_name    = "${var.iam_user_group_name}" 
    iam_policy_document    = "${data.aws_iam_policy_document.ec2_read_only.json}"
    iam_policy_name        = "${var.iam_policy_name}"
}




