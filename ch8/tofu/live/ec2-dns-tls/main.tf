provider "aws" {
  region = "us-east-1"
}

module "instances" {
  source  = "brikis98/devops/book//modules/ec2-instances"
  version = "1.0.0"

  name          = "ec2-dns-example"
  num_instances = 3
  instance_type = "t2.micro"
  ami_name      = "sample-app-tls-packer-*"
  http_port     = 443
  user_data     = file("${path.module}/user-data.sh")
}

data "aws_route53_zone" "zone" {
  name = "connector.rocks"
}

resource "aws_route53_record" "www" {
  zone_id = data.aws_route53_zone.zone.id
  # TODO: fill in your own domain name!
  name    = "www.connector.rocks"
  type    = "A"
  records = module.instances.public_ips
  ttl     = 300
}

resource "aws_iam_role_policy" "tls_cert_access" {
  role   = module.instances.iam_role_name
  policy = data.aws_iam_policy_document.tls_cert_access.json
}

data "aws_secretsmanager_secret" "certificate" {
  name = "certificate"
}

data "aws_iam_policy_document" "tls_cert_access" {
  statement {
    effect    = "Allow"
    actions   = ["secretsmanager:GetSecretValue"]
    resources = [data.aws_secretsmanager_secret.certificate.arn]
  }
}
