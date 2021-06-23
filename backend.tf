terraform {
  required_version = ">=1.0.0"
  backend "s3" {
    region  = "ap-south-1"
    profile = "default"
    key     = "terraform.tfstate"
    bucket  = "ecs2021"
  }
}

