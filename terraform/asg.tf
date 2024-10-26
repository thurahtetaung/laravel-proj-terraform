resource "aws_autoscaling_group" "web" {
  name= "${var.project_name}-asg"
  desired_capacity = 2
  max_size = 4
  min_size = 2
  target_group_arns = [aws_lb_target_group.web.arn]
  vpc_zone_identifier = aws_subnet.private[*].id
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