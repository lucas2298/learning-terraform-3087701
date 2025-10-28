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

  vpc_security_group_ids = [aws_security_group.web[0].id]

  tags = {
    Name = "HelloWorld"
  }
}

resource "aws_security_group" "web" {
  count = var.enable_web ? 1 : 0
  name = "web"
  description = "Allow HTTP and HTTPs in. Allow everything out."

  vpc_id = data.aws_vpc.default.id
}

resource "aws_security_group_rule" "web_http_ingress" {
  count = var.enable_web ? 1 : 0
  type = "ingress"
  from_port = 80
  to_port = 80
  protocol = "tcp"
  cidr_blocks = ["0.0.0.0/0"]

  security_group_id = aws_security_group.web[0].id
}

resource "aws_security_group_rule" "web_egress" {
  count = var.enable_web ? 1 : 0
  type = "egress"
  from_port = 0
  to_port = 0
  protocol = "-1"
  cidr_blocks = ["0.0.0.0/0"]

  security_group_id = aws_security_group.web[0].id
}