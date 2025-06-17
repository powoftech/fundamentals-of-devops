provider "aws" {
  region = "us-east-1"
}

module "instances" {
  source  = "brikis98/devops/book//modules/ec2-instances"
  version = "1.0.0"

  name          = "ec2-dns-example"
  num_instances = 3
  instance_type = "t2.micro"
  ami_name      = "sample-app-packer-*"
  http_port     = 8080
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
