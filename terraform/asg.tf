resource "aws_autoscaling_group" "web" {
  name= "${var.project_name}-asg"
  desired_capacity = 2
  max_size = 6
  min_size = 2
  target_group_arns = [aws_lb_target_group.web.arn]
  vpc_zone_identifier = aws_subnet.public[*].id
  health_check_type = "ELB"
  health_check_grace_period = 120
  launch_template {
    id = aws_launch_template.web.id
    version = "$Latest"
  }
  tag {
    key = "Name"
    value = "${var.project_name}-web"
    propagate_at_launch = true
  }
}

// dynamic autoscaling policy based on CPU utilization
resource "aws_autoscaling_policy" "web_cpu_policy" {
  name = "${var.project_name}-web-cpu-policy"
  policy_type = "TargetTrackingScaling"
  autoscaling_group_name = aws_autoscaling_group.web.name
  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }
    target_value = 50.0
  }
}