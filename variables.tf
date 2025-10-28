variable "instance_type" {
  description = "Type of EC2 instance to provision"
  default     = "t3.micro"
}

variable "bitnami_ami_owner" {
  description = "Owner of the Bitnami AMI"
  default     = "979382823631"
}

variable "AWS_SECRET_ACCESS_KEY" {
  description = "AWS Secret Access Key"
  type = string
  sensitive = true
}

variable "AWS_ACCESS_KEY_ID" {
  description = "AWS Access Key ID"
  type = string
  sensitive = true
}