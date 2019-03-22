resource "aws_instance" "ec2" {
  count                     = "${var.instance_count}"
  ami                       = "${var.ami_id}"
  instance_type             = "${var.instance_type}"
  subnet_id                 = "${element(var.subnet_ids, count.index)}"
  vpc_security_group_ids    = ["${var.ec2_security_group_ids}"]
  user_data                 = "${var.user_data}"
  disable_api_termination   = "${var.disable_api_termination}"
  
  tags {
    Name                    = "${var.project}-${var.environment}-${var.component}-ec2-${count.index + 1}"
    environment             = "${var.environment}"
    owner                   = "${var.owner}"
    project                 = "${var.project}"
    role                    = "${var.role}"
    region                  = "${var.aws_region}"
  }

  root_block_device {
    delete_on_termination   = true
    volume_type             = "${var.vol_type}"
    volume_size             = "${var.vol_size}"
  
  }
  volume_tags {
    Name                    = "${var.project}-${var.environment}-${var.component}-ec2-${count.index + 1}"
    environment             = "${var.environment}"
    owner                   = "${var.owner}"
    project                 = "${var.project}"
    role                    = "${var.role}"
    region                  = "${var.aws_region}"
  }
}

