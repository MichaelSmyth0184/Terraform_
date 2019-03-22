resource "aws_eip" "eip" {
  vpc = true

  count                     = "${var.instance_count}"
  instance                  = "${element(aws_instance.ec2.*.id, count.index)}"
#   depends_on                = ["aws_internet_gateway.gw"]
}
