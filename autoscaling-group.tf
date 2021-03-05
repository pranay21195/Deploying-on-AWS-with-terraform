resource "aws_autoscaling_group" "asg" {
  provider                  = aws.region-master
  name                      = "launch-instance-${aws_launch_template.lc.latest_version}"
  health_check_type         = "EC2"
  health_check_grace_period = 120
  termination_policies      = ["OldestInstance"]
  launch_template {
    id      = aws_launch_template.lc.id
    version = aws_launch_template.lc.latest_version
  }
  min_size = 1
  max_size = 5

  lifecycle {
    create_before_destroy = true
  }
  target_group_arns = [aws_lb_target_group.svc.arn]

}
# scailing policy

resource "aws_autoscaling_policy" "agents-scale-up" {
  provider               = aws.region-master
  name                   = "agents-scale-up"
  scaling_adjustment     = 1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.asg.name
}

resource "aws_autoscaling_policy" "agents-scale-down" {
  provider               = aws.region-master
  name                   = "agents-scale-down"
  scaling_adjustment     = -1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.asg.name

}

# cloudwatch alarm
resource "aws_cloudwatch_metric_alarm" "cpu_high_alarm" {
  provider            = aws.region-master
  alarm_name          = "high-alarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "60"
  statistic           = "Average"
  threshold           = "80"
  actions_enabled     = true
  alarm_actions       = ["${aws_autoscaling_policy.cpu_high.arn}"]
  dimensions = {
    "AutoScalingGroupName" = "${aws_autoscaling_group.asg.name}"
  }
}
resource "aws_cloudwatch_metric_alarm" "cpu_low_alarm" {
  provider            = aws.region-master
  alarm_name          = "low-alarm"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "60"
  statistic           = "Average"
  threshold           = "10"
  actions_enabled     = true
  alarm_actions       = ["${aws_autoscaling_policy.cpu_low.arn}"]
  dimensions = {
    "AutoScalingGroupName" = "${aws_autoscaling_group.asg.name}"
  }
}
