# VPC
project                                      = "DevOps"
owner                                        = "SQS DigitalLabs"
aws_region                                       = "eu-central-1"
environment                                  = "training"
vpc_cidr_block                               = "10.0.0.0/16"
private_domain_name                          = "devOpsTraining"
public_subnet_cidrs = [
  "10.0.1.0/24",
  "10.0.2.0/24",
  "10.0.3.0/24",
  "10.0.4.0/24",
  "10.0.5.0/24",
  "10.0.6.0/24",
  "10.0.7.0/24",
  "10.0.8.0/24"
]
public_subnet_av_zones = [
    "eu-central-1a",
    "eu-central-1b",
    "eu-central-1c",
]

disable_api_termination = false

# EC2 - web
web_instance_count                           = 1
web_ami_id                                   = "ami-04080ec905d224de6"
web_instance_type                            = "t2.large"
ebs_optimized                                = false
web_component                                = "web"
web_role                                     = "linux-webserver"
web_vol_size                                 = 30

web_ingress                               = [
  "37.26.72.80/29",       # Belfast SQS Office
]

web_user_data                                = <<EOF
#!/bin/bash
# This script is meant to be run in the User Data of an EC2 Instance while it's booting.
sudo -s
PUBLIC_IP=`wget http://ipecho.net/plain -O - -q ; echo`
echo "update ps_shop_url set domain = '$PUBLIC_IP:81', domain_ssl = '$PUBLIC_IP:81' where id_shop_url = 1;" | mysql prestashop --user='root' --password='hK1n0IuOoLjr'
EOF

# EC2 - web-api
web_api_instance_count                       = 1
web_api_ami_id                               = "ami-07d9a048763b6f8aa"
web_api_instance_type                        = "t2.micro"
ebs_optimized                                = false
web_api_component                            = "web-api"
web_api_role                                 = "windows-webserver"
web_api_vol_size                             = 60

web_api_ingress                         = [
  "37.26.72.80/29",       # Belfast SQS Office"
]


# IAM
iam_policy_name                              = "EC2ReadOnly"
iam_policy_document                          = "arn:aws:iam::aws:policy/AmazonEC2ReadOnlyAccess"
iam_user_group_name                          = "DevOpsTraining"
iam_users = [
  "devOpsTraining-user",
]


