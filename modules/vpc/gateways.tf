resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = "${aws_vpc.vpc.id}"

  tags {
    "Name"    = "${var.project}-${var.environment}-ig"
    "VPC"     = "${var.project}-${var.environment}-vpc"
    "Project" = "${var.project}"
    "Region"  = "${var.aws_region}"
  }
}
