resource "aws_ecs_task_definition" "tfer--task-definition-002F-atlantis" {
  container_definitions    = "[{\"cpu\":0,\"environment\":[{\"name\":\"ATLANTIS_ATLANTIS_URL\",\"value\":\"https://atlantis.bananalab.dev\"},{\"name\":\"ATLANTIS_GH_USER\",\"value\":\"rojopolis\"},{\"name\":\"ATLANTIS_REPO_ALLOWLIST\",\"value\":\"github.com/bananalab/*\"}],\"essential\":true,\"image\":\"ghcr.io/runatlantis/atlantis:v0.21.0\",\"logConfiguration\":{\"logDriver\":\"awslogs\",\"options\":{\"awslogs-create-group\":\"true\",\"awslogs-group\":\"atlantis\",\"awslogs-region\":\"us-west-1\",\"awslogs-stream-prefix\":\"atlantis\"}},\"mountPoints\":[],\"name\":\"atlantis\",\"portMappings\":[{\"containerPort\":4141,\"hostPort\":4141,\"protocol\":\"tcp\"}],\"secrets\":[{\"name\":\"ATLANTIS_GH_TOKEN\",\"valueFrom\":\"arn:aws:secretsmanager:us-west-1:202151242785:secret:atlantis/gh_token-V8M4FD:ATLANTIS_GH_TOKEN::\"}],\"volumesFrom\":[]}]"
  cpu                      = "256"
  execution_role_arn       = "arn:aws:iam::202151242785:role/app-ecsTaskExecutionRole"
  family                   = "atlantis"
  memory                   = "512"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  task_role_arn            = "arn:aws:iam::202151242785:role/app-ecsTaskExecutionRole"
}
