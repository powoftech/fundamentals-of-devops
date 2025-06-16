provider "aws" {
  region = "us-east-1"
}

module "child_accounts" {
  source  = "brikis98/devops/book//modules/aws-organizations"
  version = "1.0.0"

  create_organization = false

  accounts = {
    development = "powoftech+dev@gmail.com"
    staging     = "powoftech+stage@gmail.com"
    production  = "powoftech+prod@gmail.com"
  }
}
