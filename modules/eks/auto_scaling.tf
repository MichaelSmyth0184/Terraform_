# This data source is included for ease of sample architecture deployment
# and can be swapped out as necessary.
data "aws_region" "current" {}

# EKS currently documents this required userdata for EKS worker nodes to
# properly configure Kubernetes applications on the EC2 instance.
# We utilize a Terraform local here to simplify Base64 encoding this
# information into the AutoScaling Launch Configuration.
# More information: https://docs.aws.amazon.com/eks/latest/userguide/launch-workers.html
locals {
  eks_node_userdata = <<USERDATA
#!/bin/bash
set -o xtrace
/etc/eks/bootstrap.sh --apiserver-endpoint '${aws_eks_cluster.eks_cluster.endpoint}' --b64-cluster-ca '${aws_eks_cluster.eks_cluster.certificate_authority.0.data}' '${var.cluster_name}'
USERDATA
}

resource "aws_launch_configuration" "eks_launch_config" {
  associate_public_ip_address = true
  iam_instance_profile        = "${aws_iam_instance_profile.eks_node.name}"
  image_id                    = "${data.aws_ami.eks_worker.id}"
  instance_type               = "${var.instance_type}"
  name_prefix                 = "${var.cluster_name}"
  security_groups             = ["${aws_security_group.eks_node.id}"]
  user_data_base64            = "${base64encode(local.eks_node_userdata)}"

  lifecycle {
    create_before_destroy = true
  }
}

# Auto-Scaling Group
resource "aws_autoscaling_group" "eks_autoscaling_group" {
  desired_capacity     = "${var.desired_capacity}"
  launch_configuration = "${aws_launch_configuration.eks_launch_config.id}"
  max_size             = "${var.max_size}"
  min_size             = "${var.min_size}"
  name                 = "${var.cluster_name}"
  vpc_zone_identifier  = ["${var.subnet_ids}"]

  tag {
    key                 = "Name"
    value               = "${var.cluster_name}"
    propagate_at_launch = true
  }

  tag {
    key                 = "kubernetes.io/cluster/${var.cluster_name}"
    value               = "owned"
    propagate_at_launch = true
  }
}