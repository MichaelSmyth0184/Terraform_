variable "cluster_name" {
    type = "string"
    default = "terraform-eks-demo"
}
variable "vpc_id" {
    type = "string"
    default = "vpc-73e8cd15"
}
variable "subnet_ids" {
    type = "list"
    default = [
        "subnet-2f91f767",
        "subnet-dde43487"
    ]
}

variable "desired_capacity" {
    default = 2
}
variable "max_size" {
    default = 2
}
variable "min_size" {
    default = 1
}
variable "instance_type" {
    default = "t2.small"
}
variable "ingress" {
  type = "list"
  default = [
      "81.103.71.82/32",    # Michael Smyth Home IP
      "37.26.72.80/29"      # Expleo Belfast Office IP
  ]
}
variable "aws_region" {
    default = "eu-west-1"
}

