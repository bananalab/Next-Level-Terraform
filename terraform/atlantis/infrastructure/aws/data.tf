# Place common data sources in this file.

data "aws_availability_zones" "available" {
  state = "available"
}

data "aws_caller_identity" "current" {}

data "aws_region" "current" {}

data "aws_route53_zone" "domain" {
  name = var.domain_name
}

locals {
  app_host = "${var.host_name}.${data.aws_route53_zone.domain.name}"
}
