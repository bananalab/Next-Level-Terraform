data "http" "github_meta" {
  url = "https://api.github.com/meta"
  request_headers = {
    Accept = "application/json"
  }
}

locals {
    hook_ips = jsondecode(data.http.github_meta.response_body).hooks
    hook_ips_v4 = [ for ip in local.hook_ips : ip if can(regex("\\d{1,3}\\.\\d{1,3}\\.\\d{1,3}\\.\\d{1,3}\\/\\d{1,3}", ip))]
    hook_ips_v6 = [ for ip in local.hook_ips : ip if !contains(local.hook_ips_v4, ip)]
}
