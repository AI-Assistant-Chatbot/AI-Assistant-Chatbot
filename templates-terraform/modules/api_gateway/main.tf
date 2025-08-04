# API Gateway module variables
variable "lambda_function_arn" {
  description = "Lambda function ARN"
  type        = string
}

variable "lambda_function_name" {
  description = "Lambda function name"
  type        = string
}

variable "lambda_function_invoke_arn" {
  description = "Lambda function invoke ARN"
  type        = string
}

# CloudWatch Log Group for API Gateway
resource "aws_cloudwatch_log_group" "api_gateway_logs" {
  name              = "/aws/apigateway/BedrockKbSlackbotApi"
  retention_in_days = 14
}

# API Gateway REST API
resource "aws_api_gateway_rest_api" "bedrock_kb_slackbot_api" {
  name        = "BedrockKbSlackbotApi"
  description = "API Gateway for Bedrock KB Slackbot"

  endpoint_configuration {
    types = ["REGIONAL"]
  }
}

# API Gateway Resource - /slack
resource "aws_api_gateway_resource" "slack_resource" {
  rest_api_id = aws_api_gateway_rest_api.bedrock_kb_slackbot_api.id
  parent_id   = aws_api_gateway_rest_api.bedrock_kb_slackbot_api.root_resource_id
  path_part   = "slack"
}

# API Gateway Resource - /slack/xhaly
resource "aws_api_gateway_resource" "xhaly_resource" {
  rest_api_id = aws_api_gateway_rest_api.bedrock_kb_slackbot_api.id
  parent_id   = aws_api_gateway_resource.slack_resource.id
  path_part   = "xhaly"
}

# API Gateway Method - POST /slack/xhaly
resource "aws_api_gateway_method" "xhaly_post" {
  rest_api_id   = aws_api_gateway_rest_api.bedrock_kb_slackbot_api.id
  resource_id   = aws_api_gateway_resource.xhaly_resource.id
  http_method   = "POST"
  authorization = "NONE"
}

# API Gateway Integration
resource "aws_api_gateway_integration" "lambda_integration" {
  rest_api_id = aws_api_gateway_rest_api.bedrock_kb_slackbot_api.id
  resource_id = aws_api_gateway_resource.xhaly_resource.id
  http_method = aws_api_gateway_method.xhaly_post.http_method

  integration_http_method = "POST"
  type                   = "AWS_PROXY"
  uri                    = var.lambda_function_invoke_arn
}

# Lambda permission for API Gateway
resource "aws_lambda_permission" "api_gateway_lambda" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = var.lambda_function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.bedrock_kb_slackbot_api.execution_arn}/*/*"
}

# API Gateway Deployment
resource "aws_api_gateway_deployment" "api_deployment" {
  depends_on = [
    aws_api_gateway_method.xhaly_post,
    aws_api_gateway_integration.lambda_integration,
  ]

  rest_api_id = aws_api_gateway_rest_api.bedrock_kb_slackbot_api.id

  triggers = {
    redeployment = sha1(jsonencode([
      aws_api_gateway_resource.slack_resource.id,
      aws_api_gateway_resource.xhaly_resource.id,
      aws_api_gateway_method.xhaly_post.id,
      aws_api_gateway_integration.lambda_integration.id,
    ]))
  }

  lifecycle {
    create_before_destroy = true
  }
}

# API Gateway Stage
resource "aws_api_gateway_stage" "api_stage" {
  deployment_id = aws_api_gateway_deployment.api_deployment.id
  rest_api_id   = aws_api_gateway_rest_api.bedrock_kb_slackbot_api.id
  stage_name    = "prod"

  access_log_settings {
    destination_arn = aws_cloudwatch_log_group.api_gateway_logs.arn
    format = jsonencode({
      requestId      = "$context.requestId"
      ip             = "$context.identity.sourceIp"
      caller         = "$context.identity.caller"
      user           = "$context.identity.user"
      requestTime    = "$context.requestTime"
      httpMethod     = "$context.httpMethod"
      resourcePath   = "$context.resourcePath"
      status         = "$context.status"
      protocol       = "$context.protocol"
      responseLength = "$context.responseLength"
    })
  }

  depends_on = [aws_api_gateway_account.api_gateway_account]
}

# API Gateway Account (for CloudWatch logging)
resource "aws_api_gateway_account" "api_gateway_account" {
  cloudwatch_role_arn = aws_iam_role.api_gateway_cloudwatch_role.arn
}

# IAM Role for API Gateway CloudWatch logging
resource "aws_iam_role" "api_gateway_cloudwatch_role" {
  name = "api_gateway_cloudwatch_global"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "apigateway.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy" "api_gateway_cloudwatch_policy" {
  name = "default"
  role = aws_iam_role.api_gateway_cloudwatch_role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:DescribeLogGroups",
          "logs:DescribeLogStreams",
          "logs:PutLogEvents",
          "logs:GetLogEvents",
          "logs:FilterLogEvents"
        ]
        Resource = "*"
      }
    ]
  })
}

# Outputs
output "api_gateway_url" {
  description = "API Gateway URL"
  value       = "${aws_api_gateway_rest_api.bedrock_kb_slackbot_api.execution_arn}/prod/slack/xhaly"
}

output "api_gateway_invoke_url" {
  description = "API Gateway invoke URL"
  value       = "https://${aws_api_gateway_rest_api.bedrock_kb_slackbot_api.id}.execute-api.${data.aws_region.current.name}.amazonaws.com/prod/slack/xhaly"
}

output "api_gateway_id" {
  description = "API Gateway REST API ID"
  value       = aws_api_gateway_rest_api.bedrock_kb_slackbot_api.id
}

data "aws_region" "current" {}