resource "aws_eip" "nat_gateway_eip" {
  provider = aws.region-master
  vpc      = true
}

resource "aws_nat_gateway" "nat_gateway" {
  provider      = aws.region-master
  allocation_id = aws_eip.nat_gateway_eip.id
  subnet_id     = aws_subnet.subnet_1.id
  tags = {
    "Name" = "NatGateway"
  }
}

resource "aws_route_table" "nat_gateway_rt" {
  provider = aws.region-master
  vpc_id   = aws_vpc.vpc_master.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gateway.id
  }
  tags = {
    Name = "Route Table for NAT Gateway"
  }

}
output "nat_gateway_ip" {
  value = aws_eip.nat_gateway_eip.public_ip
}

