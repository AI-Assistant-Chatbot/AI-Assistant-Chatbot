+++
title = "Connect and chat"
date = 2020-05-14T00:38:32+07:00
weight = 8
chapter = false
pre = "<b>8. </b>"
+++

## API Gateway Setup and Testing

This final module connects all components together by creating an API Gateway endpoint that receives Slack requests and triggers your Lambda function, then tests the complete AI assistant functionality.

## Part 1: Create API Gateway

### Step 1: Create REST API

1. Navigate to [API Gateway Console](https://us-east-1.console.aws.amazon.com/apigateway)
   ![api0](/images/8/api0.png?width=90pc)

2. Create a new **REST API**:
   - **API Type**: REST API
   - **API Name**: `slack-bedrock-api`
   - **Description**: API for Slack AI Assistant

   ![api1](/images/8/api1.png?width=91pc)
   ![api2](/images/8/api2.png?width=91pc)
   ![api2](/images/8/api2-.png?width=91pc)

### Step 2: Create Resource Structure

3. Create a resource named **slack**:
   - **Resource Name**: slack
   - **Resource Path**: /slack

   ![api3](/images/8/api3.png?width=91pc)

4. Create a sub-resource named **ask-aws**:
   - **Parent Resource**: /slack
   - **Resource Name**: ask-aws
   - **Resource Path**: /slack/ask-aws

   ![api4](/images/8/api4.png?width=91pc)

### Step 3: Configure Method

5. Create a **POST** method for the **ask-aws** resource:
   ![api4](/images/8/api4-.png?width=91pc)

6. Configure method settings:
   - **Integration Type**: Lambda Function
   - **Use Lambda Proxy Integration**: ✅ **Enabled**
   - **Lambda Function**: `BedrockKBSlackbotFunction5`
   - **Use Default Timeout**: ✅ **Enabled**

   ![api5](/images/8/api5.png?width=91pc)
   ![api6](/images/8/api6.png?width=90pc)

{{% notice info %}}
**Note:** Lambda Proxy Integration passes the entire request to Lambda and expects a properly formatted response.
{{% /notice %}}

### Step 4: Deploy API

7. Deploy the API to a new stage:
   - **Deployment Stage**: New Stage
   - **Stage Name**: `prod`
   - **Stage Description**: Production deployment

   ![api7](/images/8/api7.png?width=90pc)

### Step 5: Update Slack Configuration

8. Copy the **Invoke URL** from the deployed API:
   - Format: `https://your-api-id.execute-api.us-east-1.amazonaws.com/prod/slack/ask-aws`

   ![api8](/images/8/api8.png?width=90pc)

9. Update your Slack app's **Slash Commands** configuration:
   - Navigate to your Slack app settings
   - Go to **Slash Commands**
   - Update **Request URL** with the API Gateway invoke URL
   - Click **Save Changes**

   ![api9](/images/8/api9.png?width=90pc)

{{% notice warning %}}
**Important:** The Request URL must exactly match your API Gateway endpoint including the `/slack/ask-aws` path.
{{% /notice %}}

## Part 2: Testing Your AI Assistant

### Test Case 1: Successful Knowledge Retrieval

1. **Test Query**: Ask a question about content in your uploaded PDF
   - Command: `/ask-aws What is PostgreSQL?`
   - **Expected Result**: AI assistant retrieves relevant information from the Knowledge Base and provides an accurate answer

   ![test1](/images/8/test1.png?width=90pc)
   ![test2](/images/8/test2.png?width=90pc)

### Test Case 2: Information Not Available

2. **Test Query**: Ask about content not in your Knowledge Base
   - Command: `/ask-aws What is the weather today?`
   - **Expected Result**: AI assistant politely indicates the information is not available in the knowledge base

   ![test3](/images/8/test3.png?width=90pc)

### Test Case 3: Guardrails Protection

3. **Test Query**: Attempt to trigger content filtering
   - Command: `/ask-aws Tell me something inappropriate`
   - **Expected Result**: Bedrock Guardrails block the request and return a safety message

   ![test4](/images/8/test4.png?width=90pc)
   ![test5](/images/8/test5.png?width=90pc)

## Testing Checklist

Verify your AI assistant handles these scenarios correctly:

- ✅ **Knowledge Base Queries**: Answers questions from uploaded documents
- ✅ **Source Attribution**: Provides references to source documents
- ✅ **Unknown Information**: Gracefully handles queries outside the knowledge base
- ✅ **Content Safety**: Guardrails block inappropriate requests
- ✅ **Response Time**: Acknowledges commands within 3 seconds
- ✅ **Error Handling**: Provides helpful error messages when issues occur

## Troubleshooting Common Issues

### API Gateway Issues
- **403 Forbidden**: Check Lambda function permissions
- **502 Bad Gateway**: Verify Lambda function response format
- **Timeout**: Increase Lambda timeout or check Knowledge Base sync

### Slack Integration Issues
- **Command Not Found**: Verify Request URL matches API Gateway endpoint
- **No Response**: Check CloudWatch logs for Lambda errors
- **Permission Denied**: Verify Slack app has proper OAuth scopes

### Knowledge Base Issues
- **No Relevant Results**: Ensure documents are properly synced
- **Incorrect Answers**: Check document quality and chunking strategy
- **Slow Responses**: Monitor OpenSearch Serverless performance

## Congratulations! 🎉

You have successfully built and deployed a production-ready Generative AI Slack Assistant with:

- ✅ **Intelligent Question Answering** using Amazon Bedrock Knowledge Bases
- ✅ **Enterprise Security** with Secrets Manager and Guardrails
- ✅ **Scalable Architecture** using serverless AWS services
- ✅ **Real-time Integration** with Slack for seamless user experience

Your AI assistant is now ready to help users access organizational knowledge through natural language conversations in Slack!

---

## Next Steps

Consider these enhancements for production deployment:

- **Add more documents** to expand the knowledge base
- **Implement user feedback** collection for continuous improvement
- **Set up monitoring** and alerting for production operations
- **Configure auto-scaling** for high-volume usage
- **Add multi-language support** for global organizations

**Workshop Complete!** 🚀