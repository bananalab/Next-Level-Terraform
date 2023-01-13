resource "aws_ecs_cluster" "tfer--atlantis" {
  name = "atlantis"

  setting {
    name  = "containerInsights"
    value = "disabled"
  }
}
