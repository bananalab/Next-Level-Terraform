resource "aws_ecs_service" "tfer--atlantis_atlantis" {
  cluster = "atlantis"

  deployment_circuit_breaker {
    enable   = "false"
    rollback = "false"
  }

  deployment_controller {
    type = "ECS"
  }

  deployment_maximum_percent         = "200"
  deployment_minimum_healthy_percent = "50"
  desired_count                      = "1"
  enable_ecs_managed_tags            = "false"
  enable_execute_command             = "false"
  health_check_grace_period_seconds  = "120"
  launch_type                        = "FARGATE"

  load_balancer {
    container_name   = "atlantis"
    container_port   = "4141"
    target_group_arn = "arn:aws:elasticloadbalancing:us-west-1:202151242785:targetgroup/atlantis/6080ff0c8220006c"
  }

  name = "atlantis"

  network_configuration {
    assign_public_ip = "false"
    security_groups  = ["sg-05eb24a802544f45d"]
    subnets          = ["subnet-027d86e6adcd0984f", "subnet-037d99c87480ae01e"]
  }

  platform_version    = "LATEST"
  scheduling_strategy = "REPLICA"
  task_definition     = "arn:aws:ecs:us-west-1:202151242785:task-definition/atlantis:12"
}
