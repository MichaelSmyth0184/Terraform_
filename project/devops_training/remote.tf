terraform {
 backend "s3" {
   encrypt = "true"
   bucket  = "s3-remote-state-storage"
   key     = "devops-training-eu-central-1/terraform.tfstate"
   region  = "eu-central-1"
 }
}