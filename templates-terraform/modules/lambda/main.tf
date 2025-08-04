# Lambda module variables
variable "rag_model_id" {
  description = "RAG model ID"
  type        = string
}

variable "slack_slash_command" {
  description = "Slack slash command"
  type        = string
}

variable "knowledge_base_id" {
  description = "Bedrock Knowledge Base ID"
  type        = string
}

variable "slack_bot_token_parameter" {
  description = "SSM parameter name for Slack bot token"
  type        = string
}

variable "slack_signing_secret_parameter" {
  description = "SSM parameter name for Slack signing secret"
  type        = string
}

variable "guard_rail_id" {
  description = "Bedrock Guardrail ID"
  type        = string
}

variable "guard_rail_version" {
  description = "Bedrock Guardrail version"
  type        = string
}

variable "lambda_memory_size" {
  description = "Lambda memory size"
  type        = number
}

variable "account_id" {
  description = "AWS account ID"
  type        = string
}

variable "region" {
  description = "AWS region"
  type        = string
}

variable "slack_bot_token_secret_arn" {
  description = "Slack bot token secret ARN"
  type        = string
}

variable "slack_signing_secret_arn" {
  description = "Slack signing secret ARN"
  type        = string
}

variable "opensearch_collection_endpoint" {
  description = "OpenSearch collection endpoint"
  type        = string
}

variable "vector_index_name" {
  description = "Vector index name"
  type        = string
}

# Lambda execution role for Bedrock KB Slackbot
resource "aws_iam_role" "bedrock_kb_slackbot_role" {
  name = "BedrockKbSlackbotRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "bedrock_kb_slackbot_basic" {
  role       = aws_iam_role.bedrock_kb_slackbot_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_iam_role_policy" "bedrock_kb_slackbot_policy" {
  name = "BedrockKbSlackbotPolicy"
  role = aws_iam_role.bedrock_kb_slackbot_role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = ["bedrock:InvokeModel"]
        Resource = "arn:aws:bedrock:${var.region}::foundation-model/${var.rag_model_id}"
      },
      {
        Effect = "Allow"
        Action = [
          "bedrock:Retrieve",
          "bedrock:RetrieveAndGenerate"
        ]
        Resource = "arn:aws:bedrock:${var.region}:${var.account_id}:knowledge-base/${var.knowledge_base_id}"
      },
      {
        Effect = "Allow"
        Action = ["ssm:GetParameter"]
        Resource = [
          "arn:aws:ssm:${var.region}:${var.account_id}:parameter${var.slack_bot_token_parameter}",
          "arn:aws:ssm:${var.region}:${var.account_id}:parameter${var.slack_signing_secret_parameter}"
        ]
      },
      {
        Effect = "Allow"
        Action = ["lambda:InvokeFunction"]
        Resource = "arn:aws:lambda:${var.region}:${var.account_id}:function:AmazonBedrock*"
      },
      {
        Effect = "Allow"
        Action = ["bedrock:ApplyGuardrail"]
        Resource = "arn:aws:bedrock:${var.region}:${var.account_id}:guardrail/*"
      },
      {
        Effect = "Allow"
        Action = [
          "secretsmanager:GetSecretValue"
        ]
        Resource = [
          var.slack_bot_token_secret_arn,
          var.slack_signing_secret_arn
        ]
      }
    ]
  })
}

# Package Lambda function
data "archive_file" "bedrock_kb_slackbot_zip" {
  type        = "zip"
  source_dir  = "../lambda/BedrockKbSlackbotFunction"
  output_path = "bedrock_kb_slackbot_function.zip"
}

# Bedrock KB Slackbot Lambda Function
resource "aws_lambda_function" "bedrock_kb_slackbot" {
  filename         = data.archive_file.bedrock_kb_slackbot_zip.output_path
  function_name    = "BedrockKbSlackbotFunction"
  role            = aws_iam_role.bedrock_kb_slackbot_role.arn
  handler         = "index.handler"
  runtime         = "python3.12"
  memory_size     = var.lambda_memory_size
  timeout         = 300
  source_code_hash = data.archive_file.bedrock_kb_slackbot_zip.output_base64sha256

  environment {
    variables = {
      RAG_MODEL_ID                   = var.rag_model_id
      SLACK_SLASH_COMMAND           = var.slack_slash_command
      KNOWLEDGEBASE_ID              = var.knowledge_base_id
      SLACK_BOT_TOKEN_PARAMETER     = var.slack_bot_token_parameter
      SLACK_SIGNING_SECRET_PARAMETER = var.slack_signing_secret_parameter
      GUARD_RAIL_ID                 = var.guard_rail_id
      GUARD_RAIL_VERSION            = var.guard_rail_version
    }
  }
}

# Outputs
output "bedrock_kb_slackbot_function_arn" {
  description = "Bedrock KB Slackbot Lambda function ARN"
  value       = aws_lambda_function.bedrock_kb_slackbot.arn
}

output "bedrock_kb_slackbot_function_name" {
  description = "Bedrock KB Slackbot Lambda function name"
  value       = aws_lambda_function.bedrock_kb_slackbot.function_name
}

output "bedrock_kb_slackbot_function_invoke_arn" {
  description = "Bedrock KB Slackbot Lambda function invoke ARN"
  value       = aws_lambda_function.bedrock_kb_slackbot.invoke_arn
}