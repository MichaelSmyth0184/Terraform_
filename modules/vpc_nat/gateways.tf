resource "aws_nat_gateway" "nat_gateway" {
  count         = "${aws_subnet.public_subnet_list.count}"
  allocation_id = "${element(aws_eip.nat_eip.*.id, count.index)}"
  subnet_id     = "${element(aws_subnet.public_subnet_list.*.id, count.index)}"
  depends_on    = ["aws_internet_gateway.internet_gateway"]

  tags {
    "Name"    = "${var.project}-${var.environment}-nat-gateway"
    "VPC"     = "${var.project}-${var.environment}-vpc"
    "Project" = "${var.project}"
    "Region"  = "${var.aws_region}"
  }
}

resource "aws_eip" "nat_eip" {
  count = "${length(keys(var.private_subnet_av_zones))}"
  vpc   = true
}
resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = "${aws_vpc.vpc.id}"

  tags {
    "Name"    = "${var.project}-${var.environment}-ig"
    "VPC"     = "${var.project}-${var.environment}-vpc"
    "Project" = "${var.project}"
    "Region"  = "${var.aws_region}"
  }
}
