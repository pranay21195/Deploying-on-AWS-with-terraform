resource "aws_launch_template" "lc" {
  provider                             = aws.region-master
  name                                 = "lc"
  image_id                             = data.aws_ami.amzn.id
  instance_initiated_shutdown_behavior = "terminate"
  instance_type                        = "t2.micro"
  key_name                             = aws_key_pair.mastercard11.key_name
  user_data = <<-EOF
    #!/bin/bash
    sudo yum update -y
    sudo yum install httpd -y
    sudo systemctl enable httpd
    sudo systemctl start httpd
    echo "<html><body><div>Hello, world!</div></body></html>" > /var/www/html/index.html
    EOF

}

