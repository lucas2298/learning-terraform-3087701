output "instance_ami" {
  value       = var.enable_web ? aws_instance.web[0].ami : null
  description = "AMI ID of the web instance when enabled"
}

output "instance_arn" {
  value       = var.enable_web ? aws_instance.web[0].arn : null
  description = "ARN of the web instance when enabled"
}
