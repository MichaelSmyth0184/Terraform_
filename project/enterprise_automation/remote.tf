terraform {
 backend "s3" {
   encrypt = "true"
   bucket  = "s3-remote-state-storage-eu-west-1"
   key     = "enterprise-automation-eu-west-1/terraform.tfstate"
   region  = "eu-west-1"
 }
}