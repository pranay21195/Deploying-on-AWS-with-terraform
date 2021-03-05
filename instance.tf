resource "aws_instance" "backendserver" {
  provider      = aws.region-master
  ami           = var.webserver-ami
  count         = var.instance-count-backend
  instance_type = var.instance-type
  # VPC
  subnet_id = aws_subnet.subnet_2.id
  # Security Group
  vpc_security_group_ids = ["${aws_security_group.backend-sg.id}"]
  key_name               = aws_key_pair.mastercard11.key_name
  # root disk
  root_block_device {
    volume_size           = "8"
    volume_type           = "gp2"
    encrypted             = true
    delete_on_termination = true
  }
  # data disk
  ebs_block_device {
    device_name           = "/dev/xvda"
    volume_size           = "5"
    volume_type           = "gp2"
    encrypted             = true
    delete_on_termination = true
  }
  tags = {
    Name = "Backendserver"
  }
}

resource "aws_instance" "frontendserver" {
  provider      = aws.region-master
  ami           = var.webserver-ami
  instance_type = var.instance-type
  # VPC
  subnet_id                   = aws_subnet.subnet_1.id
  associate_public_ip_address = true
  # Security Group
  vpc_security_group_ids = ["${aws_security_group.frontend-sg.id}"]
  key_name               = aws_key_pair.mastercard11.key_name
  user_data              = <<-EOF
    #!/bin/bash
    sudo yum update -y
    sudo yum install httpd -y
    sudo systemctl enable httpd
    sudo systemctl start httpd
    echo "<html><body><div>Hello, world!</div></body></html>" > /var/www/html/index.html
    EOF

  # root disk
  root_block_device {
    volume_size           = "8"
    volume_type           = "gp2"
    encrypted             = true
    delete_on_termination = true
  }
  # data disk
  ebs_block_device {
    device_name           = "/dev/xvda"
    volume_size           = "5"
    volume_type           = "gp2"
    encrypted             = true
    delete_on_termination = true
  }

  tags = {

    Name = "Frontendserver:"
  }
}
resource "aws_key_pair" "mastercard11" {
  provider   = aws.region-master
  key_name   = "mastercard11"
  public_key = file("mastercard11.pub")
}
