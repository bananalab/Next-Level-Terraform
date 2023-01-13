output "aws_ecs_cluster_tfer--atlantis_id" {
  value = "${aws_ecs_cluster.tfer--atlantis.id}"
}

output "aws_ecs_service_tfer--atlantis_atlantis_id" {
  value = "${aws_ecs_service.tfer--atlantis_atlantis.id}"
}

output "aws_ecs_task_definition_tfer--task-definition-002F-atlantis_id" {
  value = "${aws_ecs_task_definition.tfer--task-definition-002F-atlantis.id}"
}
