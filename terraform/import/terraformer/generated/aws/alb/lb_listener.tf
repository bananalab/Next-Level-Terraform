resource "aws_lb_listener" "tfer--arn-003A-aws-003A-elasticloadbalancing-003A-us-west-1-003A-202151242785-003A-listener-002F-app-002F-atlantis-002F-9007ec1cdc1d530d-002F-74f7bd69610b7c86" {
  certificate_arn = "arn:aws:acm:us-west-1:202151242785:certificate/af3285ce-516a-4248-88b4-eeb6d600217a"

  default_action {
    order            = "1"
    target_group_arn = "arn:aws:elasticloadbalancing:us-west-1:202151242785:targetgroup/atlantis/6080ff0c8220006c"
    type             = "forward"
  }

  load_balancer_arn = "${data.terraform_remote_state.alb.outputs.aws_lb_tfer--atlantis_id}"
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
}
