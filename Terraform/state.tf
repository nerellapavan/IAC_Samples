terraform {
  backend "s3" {
    bucket = "sethfloydjr-terraform"
    key    = "tfstate/terraform.tfstate"
    region = "us-east-1"
  }
}
