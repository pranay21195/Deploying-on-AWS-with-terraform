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
  user_data              = <<-EOT
    #cloud-config
# update apt on boot
package_update: true
# install nginx
packages:
- nginx
write_files:
- content: |
    <!DOCTYPE html>
    <html>
    <head>
      <title>StackPath - Amazon Web Services Instance</title>
      <meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
      <style>
        html, body {
          background: #000;
          height: 100%;
          width: 100%;
          padding: 0;
          margin: 0;
          display: flex;
          justify-content: center;
          align-items: center;
          flex-flow: column;
        }
        img { width: 250px; }
        svg { padding: 0 40px; }
        p {
          color: #fff;
          font-family: 'Courier New', Courier, monospace;
          text-align: center;
          padding: 10px 30px;
        }
      </style>
    </head>
    <body>
      <p>This request was proxied from <strong>Amazon Web Services</strong></p>
    </body>
    </html>
  path: /usr/share/app/index.html
  permissions: '0644'
runcmd:
- cp /usr/share/app/index.html /usr/share/nginx/html/index.html
EOT

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
