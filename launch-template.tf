resource "aws_launch_template" "launch-template" {
  provider                             = aws.region-master
  name                                 = "launch-template"
  image_id                             = data.aws_ami.amzn.id
  instance_initiated_shutdown_behavior = "terminate"
  instance_type                        = var.instance-type
  key_name                             = aws_key_pair.ecskp.key_name

  user_data = filebase64("script.sh")
network_interfaces {
   associate_public_ip_address = true
    delete_on_termination       = true
    security_groups             = ["${aws_security_group.frontend-sg.id}"]
  } 
tags = {
    Name = "test"
  }
}
