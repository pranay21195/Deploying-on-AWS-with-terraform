resource "aws_instance" "backendserver" {
  provider      = aws.region-master
  ami           = var.webserver-ami
  instance_type = var.instance-type
  # VPC
  subnet_id = aws_subnet.subnet_2.id
  # Security Group
  vpc_security_group_ids = ["${aws_security_group.backend-sg.id}"]
  key_name               = aws_key_pair.ecskp.key_name
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
  key_name               = aws_key_pair.ecskp.key_name
  user_data              = file("script.sh")

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
resource "aws_key_pair" "ecskp" {
  provider   = aws.region-master
  key_name   = "ecskp"
  public_key = file("ecskp.pub")
}
