#Create SG for allowing TCP/80, TCP/443 from and TCP/22 from public subnet to private subnet
resource "aws_security_group" "backend-sg" {
  provider    = aws.region-master
  name        = "backend-sg"
  description = "Allow TCP/80, TCP/443 & TCP/22"
  vpc_id      = aws_vpc.vpc_master.id
  tags = {
    Name = "BackendSG"
  }
  ingress {
    description = "Allow 22 from public subnet "
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["10.0.1.0/24"]
  }
  ingress {
    description = "allow public subnet "
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["10.0.1.0/24"]
  }
  ingress {
    description = "allow public subnet "
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["10.0.1.0/24"]
  }
  ingress {
    description = "Allow 22 from public subnet "
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["10.0.3.0/24"]
  }
  ingress {
    description = "allow public subnet "
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["10.0.3.0/24"]
  }
  ingress {
    description = "allow public subnet "
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["10.0.3.0/24"]
  }

}
#Create SG for frontend, only TCP/80,TCP/443 & TCP/22 from internet
resource "aws_security_group" "frontend-sg" {
  provider    = aws.region-master
  name        = "frontend-sg"
  description = "Allow 443"
  vpc_id      = aws_vpc.vpc_master.id
  tags = {
    Name = "FrontendSG"
  }
  ingress {
    description = "Allow 443 from internet"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "Allow 80 from internet"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow 22 from internet"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}



