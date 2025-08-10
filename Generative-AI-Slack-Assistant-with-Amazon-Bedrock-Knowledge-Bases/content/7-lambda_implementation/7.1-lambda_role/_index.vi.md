---
title: "Tạo Lambda Execution Role"
date: "`r Sys.Date()`"
weight: 1
chapter: false
pre: " <b> 7.1 </b> "
---

Phần này hướng dẫn bạn tạo IAM role với các quyền cần thiết cho Lambda function tương tác với Bedrock, Secrets Manager và các AWS services khác.

#### Tạo IAM Role

**Tạo Base Role**

1. Tạo IAM role mới tên **BedrockExecutionRole8888**:

   - **Trusted entity**: AWS Lambda
   - **Use case**: Lambda
   - Attach **AWSLambdaBasicExecutionRole** managed policy

   ![lambda1](/images/7/lambda1-.png?width=90pc)

#### Thêm Custom Policy

**Tạo BedrockExecutionPolicy**

2. Thêm custom inline policy tên **BedrockExecutionPolicy**:

   ![lambda2](/images/7/lambda2-.png?width=90pc)

**Cấu hình Policy JSON**

3. Sử dụng JSON policy sau (thay thế placeholder values bằng ARNs thực tế của bạn):

   ```json
   {
     "Version": "2012-10-17",
     "Statement": [
       {
         "Action": ["bedrock:InvokeModel"],
         "Effect": "Allow",
         "Resource": "arn:aws:bedrock:us-east-1::foundation-model/anthropic.claude-3-sonnet-20240229-v1:0"
       },
       {
         "Action": ["bedrock:Retrieve", "bedrock:RetrieveAndGenerate"],
         "Effect": "Allow",
         "Resource": "arn:aws:bedrock:us-east-1:YOUR-ACCOUNT-ID:knowledge-base/YOUR-KB-ID"
       },
       {
         "Action": ["ssm:GetParameter"],
         "Effect": "Allow",
         "Resource": [
           "arn:aws:ssm:us-east-1:YOUR-ACCOUNT-ID:parameter/slack-bot/token",
           "arn:aws:ssm:us-east-1:YOUR-ACCOUNT-ID:parameter/slack-bot/signing-secret"
         ]
       },
       {
         "Action": ["lambda:InvokeFunction"],
         "Effect": "Allow",
         "Resource": "arn:aws:lambda:us-east-1:YOUR-ACCOUNT-ID:function:slack-bedrock-bot"
       },
       {
         "Action": ["bedrock:ApplyGuardrail"],
         "Effect": "Allow",
         "Resource": "arn:aws:bedrock:us-east-1:YOUR-ACCOUNT-ID:guardrail/*"
       },
       {
         "Action": ["secretsmanager:GetSecretValue"],
         "Effect": "Allow",
         "Resource": [
           "arn:aws:secretsmanager:us-east-1:YOUR-ACCOUNT-ID:secret:bot-token5-*",
           "arn:aws:secretsmanager:us-east-1:YOUR-ACCOUNT-ID:secret:signing-secret5-*"
         ]
       }
     ]
   }
   ```

   ![lambda3](/images/7/lambda3.png?width=90pc)
   ![lambda4](/images/7/lambda2.png?width=91pc)

#### Giải thích Policy Permissions

**1. Core Permissions**

| Permission                        | Mục đích                 | Resource             |
| --------------------------------- | ------------------------ | -------------------- |
| **bedrock:InvokeModel**           | Gọi Claude 3 Sonnet      | Foundation model ARN |
| **bedrock:Retrieve**              | Query Knowledge Base     | Knowledge Base ARN   |
| **bedrock:RetrieveAndGenerate**   | Full RAG workflow        | Knowledge Base ARN   |
| **ssm:GetParameter**              | Truy cập configuration   | Parameter Store ARNs |
| **lambda:InvokeFunction**         | Self-invocation          | Lambda function ARN  |
| **bedrock:ApplyGuardrail**        | Content filtering        | Guardrail ARNs       |
| **secretsmanager:GetSecretValue** | Truy cập Slack credentials | Secrets Manager ARNs |

**2. Required Replacements**

Trước khi sử dụng policy, thay thế các placeholders này:

- `YOUR-ACCOUNT-ID`: AWS account ID của bạn
- `YOUR-KB-ID`: Knowledge Base ID của bạn từ Module 6
- Cập nhật secret ARNs để khớp với tên secret thực tế của bạn

{{% notice warning %}}
**Quan trọng:** Thay thế tất cả placeholder values bằng ARNs thực tế của bạn trước khi tạo policy. ARNs không chính xác sẽ gây ra permission errors.
{{% /notice %}}

#### Tiếp theo là gì

Lambda execution role của bạn hiện đã được cấu hình với các quyền cần thiết. Tiếp theo, chúng ta sẽ tạo Lambda function sẽ sử dụng role này.

---

**Tiếp tục đến**: [7.2 Tạo và Cấu hình Lambda Function](../7.2-config_code/)