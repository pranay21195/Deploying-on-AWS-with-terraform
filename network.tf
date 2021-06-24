#create VPC in ap-south-1
resource "aws_vpc" "vpc_master" {
  provider             = aws.region-master
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "ecs-vpc"
  }
}

#create IGW in ap-south-1
resource "aws_internet_gateway" "igw" {
  provider = aws.region-master
  vpc_id   = aws_vpc.vpc_master.id
  tags = {
    Name = "Internet gateway"
  }
}

#Get all available AZ's in VPC for mster region
data "aws_availability_zones" "azs" {
  provider = aws.region-master
  state    = "available"
}
#create subnet #1 in ap-south-1
resource "aws_subnet" "subnet_1" {
  provider          = aws.region-master
  availability_zone = element(data.aws_availability_zones.azs.names, 0)
  vpc_id            = aws_vpc.vpc_master.id
  cidr_block        = "10.0.1.0/24"
  tags = {
    Name = "Public-subnet-1"
  }
}

#create subnet #2 in ap-south-1
resource "aws_subnet" "subnet_3" {
  provider          = aws.region-master
  availability_zone = element(data.aws_availability_zones.azs.names, 0)
  vpc_id            = aws_vpc.vpc_master.id
  cidr_block        = "10.0.3.0/24"
  tags = {
    Name = "Private-subnet"
  }
}
#create subnet #1 in ap-south-1
resource "aws_subnet" "subnet_2" {
  provider          = aws.region-master
  availability_zone = element(data.aws_availability_zones.azs.names, 1)
  vpc_id            = aws_vpc.vpc_master.id
  cidr_block        = "10.0.2.0/24"
  tags = {
    Name = "Public-subnet-2"
  }
}

resource "aws_route_table" "prod-public-crt" {
  provider = aws.region-master
  vpc_id   = aws_vpc.vpc_master.id

  route {
    //associated subnet can reach everywhere
    cidr_block = "0.0.0.0/0"
    //CRT uses this IGW to reach internet
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "prod-public-crt"
  }
}
resource "aws_route_table_association" "prod-crta-public-subnet-1" {
  provider       = aws.region-master
  subnet_id      = aws_subnet.subnet_1.id
  route_table_id = aws_route_table.prod-public-crt.id
}
resource "aws_route_table_association" "prod-crta-public-subnet-11" {
  provider       = aws.region-master
  subnet_id      = aws_subnet.subnet_2.id
  route_table_id = aws_route_table.prod-public-crt.id
}
resource "aws_route_table_association" "prod-crta-private-subnet-1" {
  provider       = aws.region-master
  subnet_id      = aws_subnet.subnet_3.id
  route_table_id = aws_route_table.nat_gateway_rt.id
}


