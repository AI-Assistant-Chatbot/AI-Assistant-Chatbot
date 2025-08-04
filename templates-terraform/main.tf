

provider "aws" {
  region = var.aws_region
}

# Data sources
data "aws_caller_identity" "current" {}
data "aws_region" "current" {}



# Constants
locals {
  rag_model_id         = "anthropic.claude-3-sonnet-20240229-v1:0"
  embedding_model      = "amazon.titan-embed-text-v2:0"
  slack_slash_command  = "/xhaly"
  collection_name      = "slack-bedrock-vector-db"
  vector_index_name    = "slack-bedrock-os-index"
  bedrock_kb_name      = "slack-bedrock-kb"
  bedrock_kb_data_source = "slack-bedrock-kb-ds"
  lambda_memory_size   = 265
  account_id          = data.aws_caller_identity.current.account_id
  region              = data.aws_region.current.name
}

# S3 Bucket for Knowledge Base data
resource "aws_s3_bucket" "kb_bucket" {
  bucket        = "bedrock-kb-bucket-${random_id.bucket_suffix.hex}"
  force_destroy = true
}

resource "random_id" "bucket_suffix" {
  byte_length = 8
}

resource "aws_s3_bucket_public_access_block" "kb_bucket_pab" {
  bucket = aws_s3_bucket.kb_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_server_side_encryption_configuration" "kb_bucket_encryption" {
  bucket = aws_s3_bucket.kb_bucket.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

# Secrets Manager
resource "aws_secretsmanager_secret" "slack_bot_token" {
  name        = "/slack/bot-token"
  description = "Slack Bot User OAuth Token"
}

resource "aws_secretsmanager_secret_version" "slack_bot_token" {
  secret_id = aws_secretsmanager_secret.slack_bot_token.id
  secret_string = jsonencode({
    token = var.slack_bot_token
  })
}

resource "aws_secretsmanager_secret" "slack_signing_secret" {
  name        = "/slack/signing-secret"
  description = "Slack Signing Secret"
}

resource "aws_secretsmanager_secret_version" "slack_signing_secret" {
  secret_id = aws_secretsmanager_secret.slack_signing_secret.id
  secret_string = jsonencode({
    secret = var.slack_signing_secret
  })
}

# SSM Parameters
resource "aws_ssm_parameter" "slack_bot_token" {
  name  = "/slack/bot-token/parameter"
  type  = "String"
  value = "{{resolve:secretsmanager:${aws_secretsmanager_secret.slack_bot_token.name}}}"
  description = "Reference to Slack Bot Token in Secrets Manager"
}

resource "aws_ssm_parameter" "slack_signing_secret" {
  name  = "/slack/signing-secret/parameter"
  type  = "String"
  value = "{{resolve:secretsmanager:${aws_secretsmanager_secret.slack_signing_secret.name}}}"
  description = "Reference to Slack Signing Secret in Secrets Manager"
}

# Include other modules
module "bedrock" {
  source = "./modules/bedrock"
  
  s3_bucket_arn           = aws_s3_bucket.kb_bucket.arn
  account_id              = local.account_id
  region                  = local.region
  embedding_model         = local.embedding_model
  bedrock_kb_name         = local.bedrock_kb_name
  bedrock_kb_data_source  = local.bedrock_kb_data_source
  collection_name         = local.collection_name
  vector_index_name       = local.vector_index_name
}

module "lambda" {
  source = "./modules/lambda"
  
  rag_model_id                    = local.rag_model_id
  slack_slash_command             = local.slack_slash_command
  knowledge_base_id               = module.bedrock.knowledge_base_id
  slack_bot_token_parameter       = aws_ssm_parameter.slack_bot_token.name
  slack_signing_secret_parameter  = aws_ssm_parameter.slack_signing_secret.name
  guard_rail_id                   = module.bedrock.guardrail_id
  guard_rail_version              = module.bedrock.guardrail_version
  lambda_memory_size              = local.lambda_memory_size
  account_id                      = local.account_id
  region                          = local.region
  slack_bot_token_secret_arn      = aws_secretsmanager_secret.slack_bot_token.arn
  slack_signing_secret_arn        = aws_secretsmanager_secret.slack_signing_secret.arn
  opensearch_collection_endpoint  = module.bedrock.opensearch_collection_endpoint
  vector_index_name               = local.vector_index_name
}

module "api_gateway" {
  source = "./modules/api_gateway"
  
  lambda_function_arn         = module.lambda.bedrock_kb_slackbot_function_arn
  lambda_function_name        = module.lambda.bedrock_kb_slackbot_function_name
  lambda_function_invoke_arn  = module.lambda.bedrock_kb_slackbot_function_invoke_arn
}

