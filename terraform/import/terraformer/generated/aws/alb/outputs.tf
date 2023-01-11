output "aws_lb_listener_tfer--arn-003A-aws-003A-elasticloadbalancing-003A-us-west-1-003A-202151242785-003A-listener-002F-app-002F-atlantis-002F-9007ec1cdc1d530d-002F-74f7bd69610b7c86_id" {
  value = "${aws_lb_listener.tfer--arn-003A-aws-003A-elasticloadbalancing-003A-us-west-1-003A-202151242785-003A-listener-002F-app-002F-atlantis-002F-9007ec1cdc1d530d-002F-74f7bd69610b7c86.id}"
}

output "aws_lb_target_group_attachment_tfer--arn-003A-aws-003A-elasticloadbalancing-003A-us-west-1-003A-202151242785-003A-targetgroup-002F-atlantis-002F-6080ff0c8220006c-10-002E-0-002E-52-002E-241_id" {
  value = "${aws_lb_target_group_attachment.tfer--arn-003A-aws-003A-elasticloadbalancing-003A-us-west-1-003A-202151242785-003A-targetgroup-002F-atlantis-002F-6080ff0c8220006c-10-002E-0-002E-52-002E-241.id}"
}

output "aws_lb_target_group_tfer--atlantis_id" {
  value = "${aws_lb_target_group.tfer--atlantis.id}"
}

output "aws_lb_tfer--atlantis_id" {
  value = "${aws_lb.tfer--atlantis.id}"
}
