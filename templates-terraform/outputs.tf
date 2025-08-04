output "api_gateway_url" {
  description = "API Gateway URL for Slack integration"
  value       = module.api_gateway.api_gateway_invoke_url
}

output "api_gateway_id" {
  description = "API Gateway REST API ID"
  value       = module.api_gateway.api_gateway_id
}

output "s3_bucket_name" {
  description = "S3 bucket name for knowledge base data"
  value       = aws_s3_bucket.kb_bucket.bucket
}

output "s3_bucket_arn" {
  description = "S3 bucket ARN for knowledge base data"
  value       = aws_s3_bucket.kb_bucket.arn
}

output "knowledge_base_id" {
  description = "Bedrock Knowledge Base ID"
  value       = module.bedrock.knowledge_base_id
}

output "knowledge_base_arn" {
  description = "Bedrock Knowledge Base ARN"
  value       = module.bedrock.knowledge_base_arn
}

output "guardrail_id" {
  description = "Bedrock Guardrail ID"
  value       = module.bedrock.guardrail_id
}

output "guardrail_version" {
  description = "Bedrock Guardrail Version"
  value       = module.bedrock.guardrail_version
}

output "opensearch_collection_endpoint" {
  description = "OpenSearch Serverless collection endpoint"
  value       = module.bedrock.opensearch_collection_endpoint
}

output "lambda_function_name" {
  description = "Bedrock KB Slackbot Lambda function name"
  value       = module.lambda.bedrock_kb_slackbot_function_name
}

output "lambda_function_arn" {
  description = "Bedrock KB Slackbot Lambda function ARN"
  value       = module.lambda.bedrock_kb_slackbot_function_arn
}

output "slack_bot_token_secret_name" {
  description = "Slack bot token secret name in Secrets Manager"
  value       = aws_secretsmanager_secret.slack_bot_token.name
}

output "slack_signing_secret_name" {
  description = "Slack signing secret name in Secrets Manager"
  value       = aws_secretsmanager_secret.slack_signing_secret.name
}

output "deployment_instructions" {
  description = "Instructions for completing the deployment"
  value = <<-EOT
    Deployment completed successfully!
    
    Next steps:
    1. Configure your Slack App:
       - Request URL: ${module.api_gateway.api_gateway_invoke_url}
       - Slash Command: /xhaly
    
    2. Upload documents to S3 bucket: ${aws_s3_bucket.kb_bucket.bucket}
    
    3. Sync the Knowledge Base data source in AWS Console
    
    4. Test the Slack bot with: /xhaly <your question>
  EOT
}