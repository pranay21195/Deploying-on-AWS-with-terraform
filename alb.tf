resource "aws_lb" "application-lb" {
  provider           = aws.region-master
  name               = "frontend-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.frontend-sg.id]
  subnets            = [aws_subnet.subnet_1.id, aws_subnet.subnet_2.id]
  tags = {
    Name = "Frontend-LB"
  }
}

resource "aws_lb_target_group" "app-lb-tg" {
  provider    = aws.region-master
  name        = "app-lb-tg"
  port        = 80
  target_type = "instance"
  vpc_id      = aws_vpc.vpc_master.id
  protocol    = "HTTP"
  health_check {
    enabled  = true
    interval = 10
    path     = "/"
    port     = 80
    protocol = "HTTP"
    matcher  = "200-299"
  }
  tags = {
    Name = "frontend-target-group"
  }
}

resource "aws_lb_listener" "frontend-listener-http" {
  provider          = aws.region-master
  load_balancer_arn = aws_lb.application-lb.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app-lb-tg.arn
  }
}

resource "aws_lb_target_group_attachment" "frontendserver-attach" {
  provider         = aws.region-master
  target_group_arn = aws_lb_target_group.app-lb-tg.arn
  target_id        = aws_instance.frontendserver.id
  port             = 80
}
