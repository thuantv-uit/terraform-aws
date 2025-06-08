# VPC
resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  tags = merge(var.tags, {
    Name = "${var.name_prefix}-vpc"
  })
}

# Subnets
resource "aws_subnet" "subnet1" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = cidrsubnet(aws_vpc.main.cidr_block, 8, 1)
  map_public_ip_on_launch = true
  availability_zone       = var.availability_zone_1
  tags = merge(var.tags, {
    Name = "${var.name_prefix}-subnet1"
  })
}

resource "aws_subnet" "subnet2" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = cidrsubnet(aws_vpc.main.cidr_block, 8, 2)
  map_public_ip_on_launch = true
  availability_zone       = var.availability_zone_2
  tags = merge(var.tags, {
    Name = "${var.name_prefix}-subnet2"
  })
}

# Internet Gateway
resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.main.id
  tags = merge(var.tags, {
    Name = "${var.name_prefix}-internet-gateway"
  })
}

# Route Table
resource "aws_route_table" "route_table" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gateway.id
  }
  tags = merge(var.tags, {
    Name = "${var.name_prefix}-route-table"
  })
}

resource "aws_route_table_association" "subnet1_route" {
  subnet_id      = aws_subnet.subnet1.id
  route_table_id = aws_route_table.route_table.id
}

resource "aws_route_table_association" "subnet2_route" {
  subnet_id      = aws_subnet.subnet2.id
  route_table_id = aws_route_table.route_table.id
}

# Security Group
resource "aws_security_group" "security_group" {
  name   = "${var.name_prefix}-ecs-security-group"
  vpc_id = aws_vpc.main.id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    self        = false
    cidr_blocks = ["0.0.0.0/0"]
    description = "any"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(var.tags, {
    Name = "${var.name_prefix}-ecs-security-group"
  })
}

# IAM Instance Profile
resource "aws_iam_instance_profile" "test_profile" {
  name = "${var.name_prefix}-test-profile"
  role = aws_iam_role.role.name
}

# IAM Assume Role Policy for EC2
data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
    actions = ["sts:AssumeRole"]
  }
}

# IAM Role for EC2
resource "aws_iam_role" "role" {
  name               = "${var.name_prefix}-test-role"
  path               = "/"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

# Attach ECS Policy to EC2 Role
resource "aws_iam_role_policy_attachment" "ecs_policy_attachment" {
  role       = aws_iam_role.role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
}

# IAM Assume Role Policy for ECS Tasks
data "aws_iam_policy_document" "ecs_assume_role" {
  statement {
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
    actions = ["sts:AssumeRole"]
  }
}

# ECS Task Execution Role
resource "aws_iam_role" "ecs_task_execution_role" {
  name               = "${var.name_prefix}-ecs-task-execution-role"
  path               = "/"
  assume_role_policy = data.aws_iam_policy_document.ecs_assume_role.json
}

# Attach ECS Task Execution Policy
resource "aws_iam_role_policy_attachment" "ecs_task_execution_policy_attachment" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

# ECS Task Role
resource "aws_iam_role" "ecs_task_role" {
  name               = "${var.name_prefix}-ecs-task-role"
  path               = "/"
  assume_role_policy = data.aws_iam_policy_document.ecs_assume_role.json
}

# Custom Policy for ECS Task Role (CloudWatch Logs)
resource "aws_iam_role_policy" "ecs_task_role_policy" {
  name = "${var.name_prefix}-ecs-task-role-policy"
  role = aws_iam_role.ecs_task_role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ]
        Resource = "arn:aws:logs:${var.aws_region}:*:log-group:/ecs/my-ecs-task:*"
      }
    ]
  })
}
