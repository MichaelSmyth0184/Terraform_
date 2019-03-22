// Public Routing
resource "aws_route_table" "public_route_table" {
  vpc_id = "${aws_vpc.vpc.id}"

  tags {
    Name                    = "${var.project}-${var.environment}-public-route-table"
    environment             = "${var.environment}"
    owner                   = "${var.owner}"
    project                 = "${var.project}"
    role                    = "Public route table for public subnets"
    region                  = "${var.aws_region}"
  }
}

resource "aws_route" "public_internet_gateway_route" {
  route_table_id         = "${aws_route_table.public_route_table.id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.internet_gateway.id}"
}

resource "aws_route_table_association" "public_subnet_route_table_association" {
  count          = "${aws_subnet.public_subnet_list.count}"
  subnet_id      = "${element(aws_subnet.public_subnet_list.*.id, count.index)}"
  route_table_id = "${aws_route_table.public_route_table.id}"
}

//Private Routing
resource "aws_route_table" "private_route_table" {
  vpc_id = "${aws_vpc.vpc.id}"

  tags {
    Name                    = "${var.project}-${var.environment}-private-route-table"
    environment             = "${var.environment}"
    owner                   = "${var.owner}"
    project                 = "${var.project}"
    role                    = "Private route table for private subnets"
    region                  = "${var.aws_region}"
  }
}
