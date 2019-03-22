resource "aws_dynamodb_table" "dynamodb_table" {
  name           = "${var.table_name}"
  billing_mode   = "PROVISIONED"
  read_capacity  = "${var.read_capacity}"
  write_capacity = "${var.write_capacity}"
  # hash_key is used as the hash (Partition) key.
  hash_key       = "${var.hash_key}"
  # range key is used as the range (Sort) key.
  range_key      = "${var.range_key}"

  attribute {
      name = "${var.hash_key}"
      type = "S"
  }

  attribute {
      name = "${var.range_key}"
      type = "S"
  }

  tags = {
    Name        = "${var.table_name}"
    Environment = "${var.environment}"
  }
}