resource "aws_security_group" "atlantis" {
  name        = "allow_atlantis_ports"
  description = "Allow atlantis ports"
  vpc_id      = aws_vpc.this.id

  ingress {
    description      = "HTTPS from github"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    #cidr_blocks      = local.hook_ips_v4
    #ipv6_cidr_blocks = local.hook_ips_v6
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}

resource "aws_lb" "this" {
  name               = "atlantis"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.atlantis.id]
  subnets            = [for subnet in aws_subnet.public : subnet.id]

  enable_deletion_protection = false
}

resource "aws_alb_target_group" "atlantis" {
  name        = "atlantis"
  port        = 4141
  protocol    = "HTTP"
  vpc_id      = aws_vpc.this.id
  target_type = "ip"

  health_check {
    healthy_threshold   = "3"
    interval            = "30"
    protocol            = "HTTP"
    matcher             = "200"
    timeout             = "3"
    path                = "/"
    unhealthy_threshold = "2"
  }
}

resource "aws_alb_listener" "atlantis_https" {
  load_balancer_arn = aws_lb.this.id
  port              = 443
  protocol          = "HTTPS"
  certificate_arn   = aws_acm_certificate_validation.this.certificate_arn

  default_action {
    type = "forward"
    forward {
      target_group {
        arn = aws_alb_target_group.atlantis.id
      }
    }
  }
}

resource "aws_route53_record" "atlantis" {
  zone_id = data.aws_route53_zone.domain.zone_id
  name    = local.app_host
  type    = "A"

  alias {
    name                   = aws_lb.this.dns_name
    zone_id                = aws_lb.this.zone_id
    evaluate_target_health = true
  }
}
