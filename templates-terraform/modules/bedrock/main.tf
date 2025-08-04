# Bedrock module variables
variable "s3_bucket_arn" {
  description = "S3 bucket ARN for knowledge base data"
  type        = string
}

variable "account_id" {
  description = "AWS account ID"
  type        = string
}

variable "region" {
  description = "AWS region"
  type        = string
}

variable "embedding_model" {
  description = "Bedrock embedding model"
  type        = string
}

variable "bedrock_kb_name" {
  description = "Bedrock knowledge base name"
  type        = string
}

variable "bedrock_kb_data_source" {
  description = "Bedrock knowledge base data source name"
  type        = string
}

variable "collection_name" {
  description = "OpenSearch collection name"
  type        = string
}

variable "vector_index_name" {
  description = "Vector index name"
  type        = string
}

# Bedrock Execution Role
resource "aws_iam_role" "bedrock_execution_role" {
  name = "BedrockExecutionRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "bedrock.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy" "bedrock_execution_policy" {
  name = "BedrockExecutionPolicy"
  role = aws_iam_role.bedrock_execution_role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = ["bedrock:InvokeModel"]
        Resource = "arn:aws:bedrock:${var.region}::foundation-model/${var.embedding_model}"
      },
      {
        Effect = "Allow"
        Action = ["bedrock:Delete*"]
        Resource = "arn:aws:bedrock:${var.region}:${var.account_id}:knowledge-base/*"
      },
      {
        Effect = "Allow"
        Action = [
          "aoss:APIAccessAll",
          "aoss:DeleteAccessPolicy",
          "aoss:DeleteCollection",
          "aoss:DeleteLifecyclePolicy",
          "aoss:DeleteSecurityConfig",
          "aoss:DeleteSecurityPolicy"
        ]
        Resource = "arn:aws:aoss:${var.region}:${var.account_id}:collection/*"
      },
      {
        Effect = "Allow"
        Action = ["s3:ListBucket"]
        Resource = var.s3_bucket_arn
        Condition = {
          StringEquals = {
            "aws:ResourceAccount" = var.account_id
          }
        }
      },
      {
        Effect = "Allow"
        Action = ["s3:GetObject", "s3:Delete*"]
        Resource = "${var.s3_bucket_arn}/*"
        Condition = {
          StringEquals = {
            "aws:ResourceAccount" = var.account_id
          }
        }
      }
    ]
  })
}

# Bedrock Guardrail
resource "aws_bedrock_guardrail" "slack_guardrail" {
  name                      = "slack-bedrock-guardrail"
  description              = "Bedrock Guardrails for Slack bedrock bot"
  blocked_input_messaging  = "Sorry, the Ask AWS Well Architected slack bot cannot provide a response for this question"
  blocked_outputs_messaging = "Sorry, the Ask AWS Well Architected slack bot cannot provide a response for this question"

  content_policy_config {
    filters_config {
      input_strength  = "HIGH"
      output_strength = "HIGH"
      type           = "SEXUAL"
    }
    filters_config {
      input_strength  = "HIGH"
      output_strength = "HIGH"
      type           = "VIOLENCE"
    }
    filters_config {
      input_strength  = "HIGH"
      output_strength = "HIGH"
      type           = "HATE"
    }
    filters_config {
      input_strength  = "HIGH"
      output_strength = "HIGH"
      type           = "INSULTS"
    }
    filters_config {
      input_strength  = "HIGH"
      output_strength = "HIGH"
      type           = "MISCONDUCT"
    }
    filters_config {
      input_strength  = "HIGH"
      output_strength = "NONE"
      type           = "PROMPT_ATTACK"
    }
  }

  sensitive_information_policy_config {
    pii_entities_config {
      action = "ANONYMIZE"
      type   = "EMAIL"
    }
    pii_entities_config {
      action = "ANONYMIZE"
      type   = "PHONE"
    }
    pii_entities_config {
      action = "ANONYMIZE"
      type   = "NAME"
    }
    pii_entities_config {
      action = "BLOCK"
      type   = "CREDIT_DEBIT_CARD_NUMBER"
    }
  }

  word_policy_config {
    managed_word_lists_config {
      type = "PROFANITY"
    }
  }
}

resource "aws_bedrock_guardrail_version" "slack_guardrail_version" {
  guardrail_arn = aws_bedrock_guardrail.slack_guardrail.guardrail_arn
  description   = "v1.0"
}

# OpenSearch Serverless Collection
resource "aws_opensearchserverless_security_policy" "encryption_policy" {
  name = "bedrock-kb-encryption-policy"
  type = "encryption"
  policy = jsonencode({
    Rules = [
      {
        ResourceType = "collection"
        Resource     = ["collection/${var.collection_name}"]
      }
    ]
    AWSOwnedKey = true
  })
}

resource "aws_opensearchserverless_security_policy" "network_policy" {
  name = "bedrock-kb-network-policy"
  type = "network"
  policy = jsonencode([
    {
      Rules = [
        {
          ResourceType = "collection"
          Resource     = ["collection/${var.collection_name}"]
        },
        {
          ResourceType = "dashboard"
          Resource     = ["collection/${var.collection_name}"]
        }
      ]
      AllowFromPublic = true
    }
  ])
}

resource "aws_opensearchserverless_collection" "vector_collection" {
  name = var.collection_name
  type = "VECTORSEARCH"
  description = "Slack bedrock vector db"

  depends_on = [
    aws_opensearchserverless_security_policy.encryption_policy,
    aws_opensearchserverless_security_policy.network_policy
  ]
}

# Create Index Lambda Function
resource "aws_iam_role" "create_index_function_role" {
  name = "CreateIndexFunctionRole"

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

resource "aws_iam_role_policy_attachment" "create_index_function_basic" {
  role       = aws_iam_role.create_index_function_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_iam_role_policy" "create_index_function_policy" {
  name = "CreateIndexFunctionPolicy"
  role = aws_iam_role.create_index_function_role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "aoss:APIAccessAll",
          "aoss:DescribeIndex",
          "aoss:ReadDocument",
          "aoss:CreateIndex",
          "aoss:DeleteIndex",
          "aoss:UpdateIndex",
          "aoss:WriteDocument",
          "aoss:CreateCollectionItems",
          "aoss:DeleteCollectionItems",
          "aoss:UpdateCollectionItems",
          "aoss:DescribeCollectionItems"
        ]
        Resource = [
          "arn:aws:aoss:${var.region}:${var.account_id}:collection/*",
          "arn:aws:aoss:${var.region}:${var.account_id}:index/*"
        ]
      }
    ]
  })
}

data "archive_file" "create_index_lambda_zip" {
  type        = "zip"
  source_dir  = "../lambda/CreateIndexFunction"
  output_path = "create_index_function.zip"
}

resource "aws_lambda_function" "create_index_function" {
  filename         = data.archive_file.create_index_lambda_zip.output_path
  function_name    = "CreateIndexFunction"
  role            = aws_iam_role.create_index_function_role.arn
  handler         = "index.handler"
  runtime         = "python3.12"
  timeout         = 60
  source_code_hash = data.archive_file.create_index_lambda_zip.output_base64sha256

  environment {
    variables = {
      INDEX_NAME = aws_opensearchserverless_collection.vector_collection.id
    }
  }
}

# OpenSearch Access Policy
resource "aws_opensearchserverless_access_policy" "access_policy" {
  name = "bedrock-kb-access-policy"
  type = "data"
  policy = jsonencode([
    {
      Rules = [
        {
          ResourceType = "collection"
          Resource     = ["collection/*"]
          Permission   = ["aoss:*"]
        },
        {
          ResourceType = "index"
          Resource     = ["index/*/*"]
          Permission   = ["aoss:*"]
        }
      ]
      Principal = [
        aws_iam_role.bedrock_execution_role.arn,
        aws_iam_role.create_index_function_role.arn,
        "arn:aws:iam::${var.account_id}:root"
      ]
    }
  ])

  depends_on = [aws_opensearchserverless_collection.vector_collection]
}

# Custom resource to create vector index
resource "aws_lambda_invocation" "create_vector_index" {
  function_name = aws_lambda_function.create_index_function.function_name

  input = jsonencode({
    RequestType    = "Create"
    CollectionName = aws_opensearchserverless_collection.vector_collection.name
    IndexName      = var.vector_index_name
    Endpoint       = "${aws_opensearchserverless_collection.vector_collection.id}.${var.region}.aoss.amazonaws.com"
  })

  depends_on = [
    aws_opensearchserverless_collection.vector_collection,
    aws_opensearchserverless_access_policy.access_policy
  ]
}

# Bedrock Knowledge Base using CloudFormation
resource "aws_cloudformation_stack" "bedrock_kb" {
  name = "bedrock-knowledge-base-stack"
  
  template_body = jsonencode({
    AWSTemplateFormatVersion = "2010-09-09"
    Resources = {
      BedrockKnowledgeBase = {
        Type = "AWS::Bedrock::KnowledgeBase"
        Properties = {
          Name = var.bedrock_kb_name
          Description = "Bedrock knowledge base for AWS"
          RoleArn = aws_iam_role.bedrock_execution_role.arn
          KnowledgeBaseConfiguration = {
            Type = "VECTOR"
            VectorKnowledgeBaseConfiguration = {
              EmbeddingModelArn = "arn:aws:bedrock:${var.region}::foundation-model/${var.embedding_model}"
            }
          }
          StorageConfiguration = {
            Type = "OPENSEARCH_SERVERLESS"
            OpensearchServerlessConfiguration = {
              CollectionArn = aws_opensearchserverless_collection.vector_collection.arn
              FieldMapping = {
                VectorField = "bedrock-knowledge-base-default-vector"
                TextField = "AMAZON_BEDROCK_TEXT_CHUNK"
                MetadataField = "AMAZON_BEDROCK_METADATA"
              }
              VectorIndexName = var.vector_index_name
            }
          }
        }
      }
      BedrockDataSource = {
        Type = "AWS::Bedrock::DataSource"
        Properties = {
          Name = var.bedrock_kb_data_source
          KnowledgeBaseId = { Ref = "BedrockKnowledgeBase" }
          DataSourceConfiguration = {
            Type = "S3"
            S3Configuration = {
              BucketArn = var.s3_bucket_arn
            }
          }
        }
      }
    }
    Outputs = {
      KnowledgeBaseId = {
        Value = { Ref = "BedrockKnowledgeBase" }
      }
      KnowledgeBaseArn = {
        Value = { "Fn::GetAtt" = ["BedrockKnowledgeBase", "KnowledgeBaseArn"] }
      }
    }
  })
  
  depends_on = [
    aws_lambda_invocation.create_vector_index,
    aws_iam_role.bedrock_execution_role
  ]
}

# Outputs
output "knowledge_base_id" {
  description = "Bedrock Knowledge Base ID"
  value       = aws_cloudformation_stack.bedrock_kb.outputs["KnowledgeBaseId"]
}

output "knowledge_base_arn" {
  description = "Bedrock Knowledge Base ARN"
  value       = aws_cloudformation_stack.bedrock_kb.outputs["KnowledgeBaseArn"]
}

output "guardrail_id" {
  description = "Bedrock Guardrail ID"
  value       = aws_bedrock_guardrail.slack_guardrail.guardrail_id
}

output "guardrail_version" {
  description = "Bedrock Guardrail Version"
  value       = aws_bedrock_guardrail_version.slack_guardrail_version.version
}

output "opensearch_collection_endpoint" {
  description = "OpenSearch collection endpoint"
  value       = "${aws_opensearchserverless_collection.vector_collection.id}.${var.region}.aoss.amazonaws.com"
}