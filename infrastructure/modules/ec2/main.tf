resource "aws_launch_template" "ecs_lt" {
  name_prefix            = "${var.name_prefix}-ecs-template"
  image_id               = var.ami_id
  instance_type          = var.instance_type
  key_name               = var.key_name
  vpc_security_group_ids = [var.security_group_id]
  iam_instance_profile {
    name = var.iam_instance_profile_name
  }

  block_device_mappings {
    device_name = "/dev/xvda"
    ebs {
      volume_size = var.ebs_volume_size
      volume_type = "gp2"
    }
  }

  tag_specifications {
    resource_type = "instance"
    tags = merge(var.tags, {
      Name = "${var.name_prefix}-ecs-instance"
    })
  }

  user_data = filebase64("${path.module}/ecs.sh")
}

resource "aws_autoscaling_group" "ecs_asg" {
  vpc_zone_identifier = [var.subnet1_id, var.subnet2_id]
  desired_capacity    = var.asg_desired_capacity
  max_size            = var.asg_max_size
  min_size            = var.asg_min_size

  launch_template {
    id      = aws_launch_template.ecs_lt.id
    version = "$Latest"
  }

  tag {
    key                 = "AmazonECSManaged"
    value               = true
    propagate_at_launch = true
  }

  tag {
    key                 = "Name"
    value               = "${var.name_prefix}-ecs-asg"
    propagate_at_launch = true
  }
}

resource "aws_lb" "ecs_alb" {
  name               = "${var.name_prefix}-ecs-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.security_group_id]
  subnets            = [var.subnet1_id, var.subnet2_id]

  tags = merge(var.tags, {
    Name = "${var.name_prefix}-ecs-alb"
  })
}

resource "aws_lb_target_group" "ecs_tg" {
  name        = "${var.name_prefix}-ecs-target-group"
  port        = 80
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = var.vpc_id

  health_check {
    path = "/"
  }

  tags = merge(var.tags, {
    Name = "${var.name_prefix}-ecs-target-group"
  })
}

resource "aws_lb_listener" "ecs_alb_listener" {
  load_balancer_arn = aws_lb.ecs_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.ecs_tg.arn
  }
}
