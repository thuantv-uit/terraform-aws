resource "aws_ecs_cluster" "ecs_cluster" {
  name = "${var.name_prefix}-ecs-cluster"
  tags = merge(var.tags, {
    Name = "${var.name_prefix}-ecs-cluster"
  })
}

resource "aws_ecs_capacity_provider" "ecs_capacity_provider" {
  name = "${var.name_prefix}-ecs-capacity-provider"

  auto_scaling_group_provider {
    auto_scaling_group_arn = var.ecs_asg_arn

    managed_scaling {
      maximum_scaling_step_size = 1000
      minimum_scaling_step_size = 1
      status                    = "ENABLED"
      target_capacity           = var.target_capacity
    }
  }
}

resource "aws_ecs_cluster_capacity_providers" "example" {
  cluster_name = aws_ecs_cluster.ecs_cluster.name

  capacity_providers = [aws_ecs_capacity_provider.ecs_capacity_provider.name]

  default_capacity_provider_strategy {
    base              = 1
    weight            = 100
    capacity_provider = aws_ecs_capacity_provider.ecs_capacity_provider.name
  }
}

resource "aws_ecs_task_definition" "ecs_task_definition" {
  family             = "${var.name_prefix}-ecs-task"
  network_mode       = "awsvpc"
  execution_role_arn = var.execution_role_arn
  task_role_arn      = var.task_role_arn
  cpu                = var.task_cpu
  memory             = var.task_memory
  runtime_platform {
    operating_system_family = "LINUX"
    cpu_architecture        = "X86_64"
  }
  container_definitions = jsonencode([
    {
      name      = "${var.name_prefix}-container"
      image     = var.image
      cpu       = var.container_cpu
      memory    = var.container_memory
      essential = true
      portMappings = [
        {
          containerPort = var.container_port
          hostPort      = var.container_port
          protocol      = "tcp"
        }
      ]
    }
  ])

  tags = merge(var.tags, {
    Name = "${var.name_prefix}-ecs-task"
  })
}

resource "aws_ecs_service" "ecs_service" {
  name            = "${var.name_prefix}-ecs-service"
  cluster         = aws_ecs_cluster.ecs_cluster.id
  task_definition = aws_ecs_task_definition.ecs_task_definition.arn
  desired_count   = var.desired_count

  network_configuration {
    subnets         = [var.subnet1_id, var.subnet2_id]
    security_groups = [var.security_group_id]
  }

  force_new_deployment = true
  placement_constraints {
    type = "distinctInstance"
  }

  triggers = {
    redeployment = timestamp()
  }

  capacity_provider_strategy {
    capacity_provider = aws_ecs_capacity_provider.ecs_capacity_provider.name
    weight            = 100
  }

  load_balancer {
    target_group_arn = var.target_group_arn
    container_name   = "${var.name_prefix}-container"
    container_port   = var.container_port
  }

  depends_on = [aws_ecs_capacity_provider.ecs_capacity_provider]

  tags = merge(var.tags, {
    Name = "${var.name_prefix}-ecs-service"
  })
}
