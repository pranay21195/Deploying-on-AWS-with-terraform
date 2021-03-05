data "aws_availability_zones" "all" {
  provider = aws.region-master
  state    = "available"
}

data "aws_ami" "amzn" {
  provider    = aws.region-master
  most_recent = true # get the latest version

  filter {
    name = "name"
    values = [
    "amzn2-ami-hvm-*"] #
  }

  filter {
    name = "virtualization-type"
    values = [
    "hvm"]
  }

  owners = [
    "amazon" # Only official images
  ]
}

