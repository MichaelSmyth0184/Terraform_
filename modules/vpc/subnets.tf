resource "aws_subnet" "public_subnet_list" {
  count                   = "${length(var.public_subnet_cidrs)}"
  vpc_id                  = "${aws_vpc.vpc.id}"
  availability_zone       = "${element(var.public_subnet_av_zones, count.index)}"
  cidr_block              = "${element(var.public_subnet_cidrs, count.index)}"
  map_public_ip_on_launch = true

  tags {
    Name                    = "${var.project}-${var.environment}-public-subnet-list-${count.index + 1}"
    environment             = "${var.environment}"
    owner                   = "${var.owner}"
    project                 = "${var.project}"
    role                    = "Public subnet list"
    aws_region              = "${var.aws_region}"
  }
}

