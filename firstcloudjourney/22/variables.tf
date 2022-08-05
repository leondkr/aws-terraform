variable "vpc_id" {
  description = "VPC network ID"
  type        = string
}

variable "vpc_subnet_id" {
  description = "Single VPC subnet ID"
  type        = string
}

variable "ec2_key_pair_name" {
  description = "EC2 key pair"
  type        = string
}

variable "slack_webhook_url" {
  description = "Slack webhook URL for notifications"
  type        = string
}
