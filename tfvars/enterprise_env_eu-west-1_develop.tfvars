# VPC
 vpc_cidr_block         = "10.0.0.0/16"
 project                = "Enterprise Automation"
 environment            = "Development"
 private_domain_name    = ""
 region                 = "eu-west-1"
 public_subnet_cidrs    = [
  "10.0.1.0/24",
  "10.0.2.0/24"
 ]
 public_subnet_av_zones = [
    "eu-west-1a",
    "eu-west-1b"
]
 owner                  = "Expleo Digital-Labs"

# Dev envs
disable_dev_api_termination = false

# Windows Server
 win_instance_count     = 1
 win_ami_id             = "ami-0ad40268d471a7320"
 win_instance_type      = "t2.micro"
 win_vol_size           = 30
 win_dev_component      = "windows-server"
 # win_user_data          = ""
 win_dev_ingress        = [
     "37.26.72.80/29"   # Expleo Belfast Office IP
 ]
 win_dev_rdp_ingress    = [
     "37.26.72.80/29"   # Expleo Belfast Office IP"
 ]

# Linux Server
#  linux_instance_count   = 1
#  linux_ami_id           = "ami-a625b8df"
#  linux_instance_type    = "t2.micro"
#  linux_vol_size         = 30
#  linux_dev_component    = "linux-server"
#  # linux_user_data        =
#  linux_dev_ingress      = [
#      "37.26.72.80/29"   # Expleo Belfast Office IP
#  ]
#  linux_dev_ssh_ingress  = [
#      "37.26.72.80/29"   # Expleo Belfast Office IP
#  ]

# Dynamo DB
 table_name             = "ExecutionRuns"
 read_capacity          = 1
 write_capacity         = 1
 hash_key               = "ClientName"
 range_key              = "ProjectName"