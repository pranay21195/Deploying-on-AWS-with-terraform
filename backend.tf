terraform {
  required_version = ">=0.12.0"
  backend "s3" {
    region  = "ap-south-1"
    profile = "default"
    key     = "terraformstatefile"
    bucket  = "zetatf"
  }
}

