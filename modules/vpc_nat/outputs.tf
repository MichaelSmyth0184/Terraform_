output "vpc_id" {
  value = "${aws_vpc.vpc.id}"
}
output "private_subnet_id_list" {
  value = "${aws_subnet.private_subnet_list.*.id}"
}
output "public_subnet_id_list" {
  value = "${aws_subnet.public_subnet_list.*.id}"
}

# Terratest outputs
output "vpc_cidr_block" {
  value = "${aws_vpc.vpc.cidr_block}"
}
output "vpc_tag_name" {
  value = "${data.template_file.vpc_tags.*.rendered}"
}
output "public_subnet_cidr_block" {
  value = "${aws_subnet.public_subnet_list.0.cidr_block}"
}
output "private_subnet_cidr_block" {
  value = "${aws_subnet.private_subnet_list.0.cidr_block}"
}