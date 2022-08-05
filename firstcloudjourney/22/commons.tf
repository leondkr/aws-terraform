terraform {
  backend "s3" {
    region  = "ap-southeast-1"
    profile = "binhnguyen"
    key     = "firstcloudjourney/22.tfstate"
    bucket  = "binhnguyen-s3-terraform"
  }
}

provider "aws" {
  region  = "ap-southeast-1"
  profile = "binhnguyen"
}
