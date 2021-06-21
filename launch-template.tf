resource "aws_launch_template" "launch-template" {
  provider                             = aws.region-master
  name                                 = "launch-template"
  image_id                             = data.aws_ami.amzn.id
  instance_initiated_shutdown_behavior = "terminate"
  instance_type                        = "t2.micro"
  key_name                             = aws_key_pair.zetakp.key_name
}

