output "ec2_security_group_id" {
  value = "${aws_security_group.ec2_security_group.id}"
}
output "ec2_ids" {
  value = "${aws_instance.ec2.*.id}"
}

output "instance_url" {
  value = "http://${aws_instance.ec2.0.public_ip}:${var.instance_port}"
}
