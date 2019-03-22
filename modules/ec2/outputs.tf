output "web_ec2_ids" {
  value = "${aws_instance.ec2.*.id}"
}
output "elastic_ips" {
  value = "${aws_eip.eip.*.public_ip}"
}
output "web_ec2_arns" {
  value = "${aws_instance.ec2.*.arn}"
}
output "private_ips" {
  value = "${aws_instance.ec2.*.private_ip}"
}
output "instance_url" {
  value = "http://${aws_eip.eip.0.public_ip}:${var.instance_port}"
}
