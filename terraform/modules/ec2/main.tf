resource "aws_launch_template" "app_lt" {
  name_prefix   = "${var.app_name}-lt-"
  image_id      = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name
  user_data     = base64encode(var.user_data)

  iam_instance_profile {
    name = var.iam_instance_profile
  }

  vpc_security_group_ids = var.security_group_ids
}

resource "aws_autoscaling_group" "app_asg" {
  desired_capacity     = 1
  max_size             = 2
  min_size             = 1
  vpc_zone_identifier  = var.subnet_ids
  health_check_type    = "EC2"

  launch_template {
    id      = aws_launch_template.app_lt.id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = "${var.app_name}-ec2"
    propagate_at_launch = true
  }
}
