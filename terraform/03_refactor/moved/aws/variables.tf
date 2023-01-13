variable "domain_name" {
    type = string
    description = <<-EOT
        Name of a pre-existing route 53 hosted zone.
        Used for TLS certificate and load balancer.
    EOT
    default = "bananalab.dev"
}

variable "host_name" {
    type = string
    description = <<-EOT
        Public name of the service.
        Will be concatenated with the domain_name to form the fqdn.
    EOT
    default = "atlantis"
}

variable "vpc_cidr" {
    type = string
    description = <<-EOT
        CIDR block for VPC
    EOT
    default = "10.0.0.0/16"
}

variable "availability_zones" {
    type = list(string)
    description = <<-EOT
        Availability zones for resources.
    EOT
    default = ["us-west-1b", "us-west-1c"]
}

variable "private_subnet_cidrs" {
    type = list(string)
    description = <<-EOT
        Private subnet CIDRS.
        Must be one for each AZ.
        Must be subnets of vpc_cidr.
    EOT
    default = ["10.0.32.0/20", "10.0.48.0/20"]
}

variable "public_subnet_cidrs" {
    type = list(string)
    description = <<-EOT
        Public subnet CIDRS.
        Must be one for each AZ.
        Must be subnets of vpc_cidr.
    EOT
    default = ["10.0.0.0/20", "10.0.16.0/20"]
}

variable "atlantis_repo_allowlist" {
    type = list(string)
    description = <<-EOT
        Format is {hostname}/{owner}/{repo}, ex. github.com/runatlantis/atlantis
    EOT
    default = [ "github.com/bananalab/*" ]
}

variable "atlantis_gh_user" {
    type = string
    description = <<-EOT
        GitHub username of API user.
    EOT
    default = null
}

variable "atlantis_gh_token_secret" {
    type = string
    description = <<-EOT
        ARN of an AWS Secrets Manager secret containing
        GitHub token
    EOT
    default = null
}