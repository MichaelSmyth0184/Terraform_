# VPC
project                                      = "Qallisto"
owner                                        = "Michael"
region                                   = "Belfast Offices"
environment                                  = "test"
component                                    = "test"
aws_region                                   = "eu-west-1"
vpc_cidr_block                               = "172.30.0.0/16"
private_domain_name                          = "qallisto.test.aws"
public_subnet_cidrs = [
  "172.32.0.0/24",
  "172.32.1.0/24",
  "172.30.2.0/24"
]
public_subnet_av_zones = [
    "eu-west-1a",
    "eu-west-1b",
    "eu-west-1c"
]
private_subnet_cidrs = [
]
private_subnet_av_zones = [   
]


# EC2 - web
# ami_id                                       = "ami-0f387dd397dd2373c"  # Windows with IIS preconfigured
ami_id                                       = "ami-0b2744e066ace793d"
instance_type                                = "t2.micro"
ebs_optimized                                = false
ec2_component                                = "web"
vol_size                                     = 30
key_name                                     = "Qallisto"
web_instance_count                           = 4
web_ingress                                  = [
  "80.76.207.49/32",       # Belfast
]


vpc_id                                       = "vpc-00110abd61f023bff"

# Application LB - web
alb_internal                                 = false
alb_cross_zone_load_balancing                = false
alb_port                                     = "80"
alb_protocol                                 = "HTTP"
target_group_sticky                          = false
target_group_path                            = "/index.html"
target_group_port                            = "80"
priority                                     = "100"
alb_source_cidr                               = [
  "80.76.207.49/32"        # Belfast
]

# RDS - SQL Server express
rds_identifier                               = "qallisto-sql-ex"
rds_allocated_storage                        = 20
rds_component                                = "backend"
rds_storage_type                             = "gp2"
# rds_engine                                   = "mysql"
rds_engine                                   = "sqlserver-ex"
rds_engine_version                           = "14.00.3035.2.v1"
rds_instance_class                           = "db.t2.micro"
# rds_name                                     = "qallisto-db"
rds_username                                 = "foo"
rds_password                                 = "foobarbaz"
rds_parameter_group_name                     = "qallisto-sql-pg"
db_family                                    = "sqlserver-ex-14.0"
rds_db_ingress                               = [
  "80.76.207.49/32",       # Belfast
  "165.225.0.0/17",        # German VM
  "185.46.212.0/24",       # German Firewall
  "81.174.139.175/32",     # Mike Home
  "103.6.167.50/32",       # India
  "172.30.0.224/32",       # Qallisto-EB-1
  "195.219.213.2/32",      # Wayne - Dev Box
  "195.219.77.64/26",      # SQS Cologne Server
  "169.0.249.238/32"       # Wayne Home
]
