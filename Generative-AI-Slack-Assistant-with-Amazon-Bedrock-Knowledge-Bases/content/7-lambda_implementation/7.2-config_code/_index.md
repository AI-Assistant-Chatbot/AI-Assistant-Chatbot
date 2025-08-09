+++
title = "Create and Configure Lambda Function"
date = 2024-05-14T00:38:32+07:00
weight = 8
chapter = false
pre = "<b>7.2 </b>"
+++

This section guides you through creating the Lambda function and configuring it with the necessary code, settings, and environment variables.

## Step 1: Create Lambda Function

### 1.1 Basic Function Setup

1. Create a new Lambda function named **BedrockKBSlackbotFunction5**:

   - **Runtime**: Python 3.12
   - **Architecture**: x86_64

   ![lambda5](/images/7/lambda5.png?width=90pc)

### 1.2 Attach IAM Role

2. Attach the IAM role **BedrockExecutionRole8888** (created in section 7.1) and click **Create**:
   ![lambda6](/images/7/lambda6-.png?width=90pc)

## Step 2: Upload Function Code

### 2.1 Deploy Code Package

3. Upload the Lambda deployment package:

   - Download: [BedrockKBSlackbotFunction.zip](https://github.com/honganh29122002/lambda_code_zip)
   - Go to **Code** tab → **Upload from** → **.zip file**
   - Select and upload the downloaded zip file

   ![lambda7](/images/7/lambda7-.png?width=90pc)
   ![lambda8](/images/7/lambda8.png?width=90pc)
   ![lambda9](/images/7/lambda9-.png?width=90pc)

{{% notice info %}}
**Note:** The zip file contains the Slack Bolt framework and all necessary dependencies for the bot functionality.
{{% /notice %}}

## Step 3: Configure Function Settings

### 3.1 Update Handler

4. Change the **Handler** to match your code entry point:

   - **Handler**: `lambda_function.lambda_handler`

   ![lambda11](/images/7/lambda11-.png?width=91pc)

### 3.2 Adjust Performance Settings

5. Configure **Memory** and **Timeout** for optimal performance:

   - **Memory**: 512 MB (recommended for Bedrock API calls)
   - **Timeout**: 5 minutes (allows time for Knowledge Base queries)

   ![lambda13](/images/7/lambda13-.png?width=90pc)

## Step 4: Environment Variables

### 4.1 Add Configuration Variables

6. Add the following **Environment variables**:

   | Key                          | Value                                     | Purpose                                 |
   | ---------------------------- | ----------------------------------------- | --------------------------------------- |
   | `KNOWLEDGE_BASE_ID`          | `your-kb-id-from-module-6`                | References your Knowledge Base          |
   | `MODEL_ID`                   | `anthropic.claude-3-sonnet-20240229-v1:0` | Specifies text generation model         |
   | `SLACK_BOT_TOKEN_PARAM`      | `/slack-bot/token`                        | Parameter Store path for bot token      |
   | `SLACK_SIGNING_SECRET_PARAM` | `/slack-bot/signing-secret`               | Parameter Store path for signing secret |
   | `AWS_REGION`                 | `us-east-1`                               | AWS region for service calls            |

   ![lambda14](/images/7/lambda14-.png?width=90pc)
   ![lambda15](/images/7/lambda15-.png?width=90pc)

### 4.2 Required Values

Replace these placeholder values with your actual configuration:

- **KNOWLEDGE_BASE_ID**: Copy from your Bedrock Knowledge Base (Module 6.3)
- **MODEL_ID**: Use the exact Claude 3 Sonnet model ID shown above
- **Parameter paths**: Must match your Parameter Store configuration (Module 4.2)

{{% notice warning %}}
**Important:** Ensure all environment variable values match your actual AWS resources. Incorrect values will cause runtime errors.
{{% /notice %}}

## Function Configuration Summary

### Runtime Settings

- ✅ **Function name**: BedrockKBSlackbotFunction5
- ✅ **Runtime**: Python 3.12
- ✅ **Handler**: lambda_function.lambda_handler
- ✅ **Memory**: 512 MB
- ✅ **Timeout**: 5 minutes

### Security Settings

- ✅ **Execution role**: BedrockExecutionRole8888
- ✅ **Environment variables**: Configured with proper values
- ✅ **Code package**: Uploaded with dependencies

## What's Next

Your Lambda function is now configured and ready to process Slack commands. Next, we'll create the API Gateway that will receive requests from Slack and trigger your Lambda function.

---

**Continue to**: [Module 8 - API Gateway Setup](../../8-api-gateway/)
