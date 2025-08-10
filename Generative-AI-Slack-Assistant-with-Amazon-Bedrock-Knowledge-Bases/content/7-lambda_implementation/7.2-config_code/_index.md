---
title: "Create and Configure Lambda Function"
date: "`r Sys.Date()`"
weight: 2
chapter: false
pre: " <b> 7.2 </b> "
---

This section guides you through creating the Lambda function and configuring it with the necessary code, settings, and environment variables.

#### Create Lambda Function

**Basic Function Setup**

1. Create a new Lambda function named **BedrockKBSlackbotFunction5**:

   - **Runtime**: Python 3.12
   - **Architecture**: x86_64

   ![lambda5](/images/7/lambda5.png?width=90pc)

**Attach IAM Role**

2. Attach the IAM role **BedrockExecutionRole8888** (created in section 7.1) and click **Create**:
   ![lambda6](/images/7/lambda6-.png?width=90pc)

#### Upload Function Code

**Deploy Code Package**

3. Upload the Lambda deployment package:

   - Download: [BedrockKBSlackbotFunction.zip](https://github.com/honganh29122002/lambda_code_zip)
   - Go to **Code** tab → **Upload from** → **.zip file**
   - Select and upload the downloaded zip file

   ![lambda7](/images/7/lambda7-.png?width=90pc)

   - Select **Save**
     ![lambda8](/images/7/lambda8.png?width=90pc)
   - Upload successfully
     ![lambda9](/images/7/lambda9-.png?width=90pc)

{{% notice info %}}
**Note:** The zip file contains the Slack Bolt framework and all necessary dependencies for the bot functionality.
{{% /notice %}}

#### Configure Function Settings

**Update Handler**

4. Change the **Handler** to match your code entry point:

   - **Handler**: `index.handler`

   ![lambda11](/images/7/lambda11-.png?width=91pc)

**Adjust Performance Settings**

5. Configure **Memory** and **Timeout** for optimal performance:

   - **Memory**: 512 MB (recommended for Bedrock API calls)
   - **Timeout**: 5 minutes (allows time for Knowledge Base queries)

   ![lambda13](/images/7/lambda13-.png?width=90pc)

#### Environment Variables

**Add Configuration Variables**

6. Add the following **Environment variables**:

   | Key                              | Value                                     | Purpose                                 |
   | -------------------------------- | ----------------------------------------- | --------------------------------------- |
   | `KNOWLEDGE_BASE_ID`              | `your-kb-id-from-module-6`                | References your Knowledge Base          |
   | `MODEL_ID`                       | `anthropic.claude-3-sonnet-20240229-v1:0` | Specifies text generation model         |
   | `SLACK_BOT_TOKEN_PARAMETER`      | `/slack/bot-token5/parameter5`            | Parameter Store path for bot token      |
   | `SLACK_SIGNING_SECRET_PARAMETER` | `/slack-bot/signing-secret5/parameter5`   | Parameter Store path for signing secret |
   | `AWS_REGION`                     | `us-east-1`                               | AWS region for service calls            |
   | `GUARDRAIL_ID`                   | `your-guardrail-id `                      | References your guardrail               |
   | `SLACK_SLASH_COMMAND`            | `/ask-ai`                                 | slash command created at the beginning  |

   ![lambda14](/images/7/lambda14-.png?width=90pc)
   ![lambda15](/images/7/lambda15-.png?width=90pc)

**Required Values**

Replace these placeholder values with your actual configuration:

- **KNOWLEDGE_BASE_ID**: Copy from your Bedrock Knowledge Base (Module 6.3)
- **MODEL_ID**: Use the exact Claude 3 Sonnet model ID shown above
- **Parameter paths**: Must match your Parameter Store configuration (Module 4.2)

{{% notice warning %}}
**Important:** Ensure all environment variable values match your actual AWS resources. Incorrect values will cause runtime errors.
{{% /notice %}}

#### Function Configuration Summary

**1. Runtime Settings**

- ✅ **Function name**: BedrockKBSlackbotFunction5
- ✅ **Runtime**: Python 3.12
- ✅ **Handler**: lambda_function.lambda_handler
- ✅ **Memory**: 512 MB
- ✅ **Timeout**: 5 minutes

**2. Security Settings**

- ✅ **Execution role**: BedrockExecutionRole8888
- ✅ **Environment variables**: Configured with proper values
- ✅ **Code package**: Uploaded with dependencies

#### What's Next

Your Lambda function is now configured and ready to process Slack commands. Next, we'll create the API Gateway that will receive requests from Slack and trigger your Lambda function.

---

**Continue to**: [8. API Gateway Integration and Complete Testing](../../8-api_gateway/)
