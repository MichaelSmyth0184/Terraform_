resource "aws_instance" "ec2" {
  count                  = "${var.instance_count}"
  ami                    = "${var.ami_id}"
  instance_type          = "${var.instance_type}"
  subnet_id              = "${element(var.subnet_ids, count.index)}"
  key_name               = "${var.key_name}"
  user_data              = "${data.template_file.user_data.rendered}"
  vpc_security_group_ids = ["${aws_security_group.ec2_security_group.id}"]
  
  tags {
    Name                    = "${var.project}-${var.environment}-${var.ec2_component}-ec2-${count.index}"
    environment             = "${var.environment}"
    owner                   = "${var.owner}"
    project                 = "${var.project}"
    role                    = "aws instance for public web"
    region                  = "${var.aws_region}"
  }

  root_block_device {
    delete_on_termination = true
    volume_type = "${var.vol_type}"
    volume_size = "${var.vol_size}"
  
  }
  volume_tags {
    Name                    = "${var.project}-${var.environment}-${var.ec2_component}-ec2-${count.index}"
    environment             = "${var.environment}"
    owner                   = "${var.owner}"
    project                 = "${var.project}"
    role                    = "aws instance volume for public web"
    region                  = "${var.aws_region}"
  }
}

data "template_file" "user_data" {
  template = "${file("user-data/user-data.sh")}"

  vars {
    instance_text = "${var.instance_text}"
    instance_port = "${var.instance_port}"
  }
}

