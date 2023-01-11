resource "aws_lb" "tfer--atlantis" {
  desync_mitigation_mode           = "defensive"
  drop_invalid_header_fields       = "false"
  enable_cross_zone_load_balancing = "true"
  enable_deletion_protection       = "false"
  enable_http2                     = "true"
  enable_waf_fail_open             = "false"
  idle_timeout                     = "60"
  internal                         = "false"
  ip_address_type                  = "ipv4"
  load_balancer_type               = "application"
  name                             = "atlantis"
  preserve_host_header             = "false"
  security_groups                  = ["sg-0095ed36105a2ebc9"]

  subnet_mapping {
    subnet_id = "subnet-009418378f03125e4"
  }

  subnet_mapping {
    subnet_id = "subnet-0d5e2658f5131c24f"
  }

  subnets = ["subnet-009418378f03125e4", "subnet-0d5e2658f5131c24f"]
}
