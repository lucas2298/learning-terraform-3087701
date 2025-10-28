data "aws_ami" "app_ami" {
  count       = var.enable_web ? 1 : 0
  most_recent = true

  filter {
    name   = "name"
    values = ["bitnami-tomcat-*-x86_64-hvm-ebs-nami"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = [var.bitnami_ami_owner] # Bitnami
}

data "aws_vpc" "default" {
  default = true
}

resource "aws_instance" "web" {
  count         = var.enable_web ? 1 : 0
  ami           = data.aws_ami.app_ami[0].id
  instance_type = var.instance_type

  vpc_security_group_ids = [module.security_group[0].security_group_id]

  tags = {
    Name = "HelloWorld"
  }
}

module "security_group" {
  count = var.enable_web ? 1 : 0
  source = "terraform-aws-modules/security-group/aws"
  version = "4.13.0"
  name = "web_new"

  vpc_id = data.aws_vpc.default.id
  ingress_rules = ["http-80-tcp", "https-443-tcp"]
  ingress_cidr_blocks = ["0.0.0.0/0"]

  egress_rules = ["all-all"]
  egress_cidr_blocks = ["0.0.0.0/0"]
}