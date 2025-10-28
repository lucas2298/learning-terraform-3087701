variable "instance_type" {
  description = "Type of EC2 instance to provision"
  default     = "t3.micro"
}

variable "bitnami_ami_owner" {
  description = "Owner of the Bitnami AMI"
  default     = "979382823631"
}