# Define ECS resources.

resource "aws_ecs_cluster" "this" {
  name = "atlantis"
}

resource "aws_ecs_task_definition" "atlantis" {
  family                   = "atlantis"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = 256
  memory                   = 512
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  task_role_arn            = aws_iam_role.ecs_task_execution_role.arn
  container_definitions    = jsonencode(
    [
      {
        name      = "atlantis"
        image     = "ghcr.io/runatlantis/atlantis:v0.21.0"
        essential = true
        portMappings = [{
          protocol      = "tcp"
          containerPort = 4141
          hostPort      = 4141
        }]
        secrets = [{
          name = "ATLANTIS_GH_TOKEN"
          valueFrom = var.atlantis_gh_token_secret
        }]
        environment = [
          {
            name  = "ATLANTIS_REPO_ALLOWLIST"
            value = join(",",var.atlantis_repo_allowlist)
          },
          {
            name  = "ATLANTIS_GH_USER"
            value = var.atlantis_gh_user
          },
          {
            name = "ATLANTIS_ATLANTIS_URL"
            value = "https://${local.app_host}"
          }
        ]
        logConfiguration = {
          logDriver = "awslogs"
          options = {
            awslogs-create-group = "true"
            awslogs-group = "atlantis"
            awslogs-region = data.aws_region.current.name
            awslogs-stream-prefix = "atlantis"
          }
        }
      }
    ]
  )
}

resource "aws_iam_role" "ecs_task_execution_role" {
  name = "app-ecsTaskExecutionRole"

  assume_role_policy = <<-EOF
    {
        "Version": "2012-10-17",
        "Statement": [
          {
            "Action": "sts:AssumeRole",
            "Principal": {
              "Service": "ecs-tasks.amazonaws.com"
            },
            "Effect": "Allow",
            "Sid": ""
          }
        ]
    }
    EOF
}

resource "aws_iam_role_policy_attachment" "ecs-task-execution-role-policy-attachment" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

resource "aws_iam_role_policy_attachment" "administrator-access-policy-attachment" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

resource "aws_security_group" "service" {
  name        = "allow_lb_ports"
  description = "Allow LB ports"
  vpc_id      = aws_vpc.this.id

  ingress {
    description     = "Atlantis from LB"
    from_port       = 4141
    to_port         = 4141
    protocol        = "tcp"
    security_groups = [aws_security_group.atlantis.id]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}

resource "aws_ecs_service" "this" {
  name                               = "atlantis"
  cluster                            = aws_ecs_cluster.this.id
  task_definition                    = aws_ecs_task_definition.atlantis.arn
  desired_count                      = 1
  deployment_minimum_healthy_percent = 50
  deployment_maximum_percent         = 200
  launch_type                        = "FARGATE"
  health_check_grace_period_seconds  = 120
  scheduling_strategy                = "REPLICA"

  network_configuration {
    security_groups  = [aws_security_group.service.id]
    subnets          = [for subnet in aws_subnet.private : subnet.id]
    assign_public_ip = false
  }

  load_balancer {
    target_group_arn = aws_alb_target_group.atlantis.arn
    container_name   = "atlantis"
    container_port   = 4141
  }
}
