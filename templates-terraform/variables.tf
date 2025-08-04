variable "aws_region" {
  description = "AWS region where resources will be created"
  type        = string
  default     = "us-east-1"
  
  validation {
    condition = can(regex("^[a-z0-9-]+$", var.aws_region))
    error_message = "AWS region must be a valid region name."
  }
}

variable "slack_bot_token" {
  description = "Slack Bot User OAuth Token (starts with xoxb-)"
  type        = string
  sensitive   = true
  
  validation {
    condition = can(regex("^xoxb-", var.slack_bot_token))
    error_message = "Slack bot token must start with 'xoxb-'."
  }
}

variable "slack_signing_secret" {
  description = "Slack App Signing Secret"
  type        = string
  sensitive   = true
  
  validation {
    condition = length(var.slack_signing_secret) > 0
    error_message = "Slack signing secret cannot be empty."
  }
}

variable "project_name" {
  description = "Name of the project (used for resource naming)"
  type        = string
  default     = "bedrock-slack-bot"
  
  validation {
    condition = can(regex("^[a-z0-9-]+$", var.project_name))
    error_message = "Project name must contain only lowercase letters, numbers, and hyphens."
  }
}

variable "environment" {
  description = "Environment name (dev, staging, prod)"
  type        = string
  default     = "dev"
  
  validation {
    condition = contains(["dev", "staging", "prod"], var.environment)
    error_message = "Environment must be one of: dev, staging, prod."
  }
}

variable "tags" {
  description = "Common tags to apply to all resources"
  type        = map(string)
  default = {
    Project     = "Amazon Bedrock Knowledge Base Slack Bot"
    Environment = "dev"
    ManagedBy   = "Terraform"
  }
}