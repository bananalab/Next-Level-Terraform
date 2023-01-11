data "terraform_remote_state" "alb" {
  backend = "local"

  config = {
    path = "../../../generated/aws/alb/terraform.tfstate"
  }
}
