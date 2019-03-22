output "web_security_group_id" {
  value = "${aws_security_group.ec2_security_group.id}"
}
output "web_ec2_ids" {
  value = "${aws_instance.ec2.*.id}"
}
output "public_ips" {
  value = "${aws_instance.ec2.*.public_ip}"
}
output "web_ec2_arns" {
  value = "${aws_instance.ec2.*.arn}"
}
output "alb_id" {
  value = "${aws_alb.alb.id}"
}
output "alb_sg_id" {
  value = "${aws_security_group.alb_sg.id}"
}
