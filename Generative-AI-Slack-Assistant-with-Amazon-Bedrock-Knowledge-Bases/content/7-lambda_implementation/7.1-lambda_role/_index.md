---
title: "Create Lambda Execution Role"
date: "`r Sys.Date()`"
weight: 1
chapter: false
pre: " <b> 7.1 </b> "
---

This section guides you through creating an IAM role with the necessary permissions for your Lambda function to interact with Bedrock, Secrets Manager, and other AWS services.

#### Create IAM Role

**Create Base Role**

1. Create a new IAM role named **BedrockExecutionRole8888**:

   - **Trusted entity**: AWS Lambda
   - **Use case**: Lambda
   - Attach **AWSLambdaBasicExecutionRole** managed policy

   ![lambda1](/images/7/lambda1-.png?width=90pc)

#### Add Custom Policy

**Create BedrockExecutionPolicy**

2. Add a custom inline policy named **BedrockExecutionPolicy**:

   ![lambda2](/images/7/lambda2-.png?width=90pc)

**Policy JSON Configuration**

3. Use the following JSON policy (replace placeholder values with your actual ARNs):

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

#### Policy Permissions Explained

**1. Core Permissions**

| Permission                        | Purpose                  | Resource             |
| --------------------------------- | ------------------------ | -------------------- |
| **bedrock:InvokeModel**           | Call Claude 3 Sonnet     | Foundation model ARN |
| **bedrock:Retrieve**              | Query Knowledge Base     | Knowledge Base ARN   |
| **bedrock:RetrieveAndGenerate**   | Full RAG workflow        | Knowledge Base ARN   |
| **ssm:GetParameter**              | Access configuration     | Parameter Store ARNs |
| **lambda:InvokeFunction**         | Self-invocation          | Lambda function ARN  |
| **bedrock:ApplyGuardrail**        | Content filtering        | Guardrail ARNs       |
| **secretsmanager:GetSecretValue** | Access Slack credentials | Secrets Manager ARNs |

**2. Required Replacements**

Before using the policy, replace these placeholders:

- `YOUR-ACCOUNT-ID`: Your AWS account ID
- `YOUR-KB-ID`: Your Knowledge Base ID from Module 6
- Update secret ARNs to match your actual secret names

{{% notice warning %}}
**Important:** Replace all placeholder values with your actual ARNs before creating the policy. Incorrect ARNs will cause permission errors.
{{% /notice %}}

#### What's Next

Your Lambda execution role is now configured with the necessary permissions. Next, we'll create the Lambda function that will use this role.

---

**Continue to**: [7.2 Create and Configure Lambda Function](../7.2-config_code/)
