---
title: "API Gateway Integration and Complete Testing"
date: "2025-06-30"
weight: 8
chapter: false
pre: " <b> 8. </b> "
---

#### API Gateway Setup and Testing

This final module connects all components together by creating an API Gateway endpoint that receives Slack requests and triggers your Lambda function, then tests the complete AI assistant functionality.

#### Create API Gateway

**Create REST API**

1. Navigate to [API Gateway Console](https://us-east-1.console.aws.amazon.com/apigateway)
   ![api0](/images/8-api_gateway/api00a.png?width=90pc)

2. Create a new **REST API**:

   - **API Type**: REST API

   ![api1](/images/8-api_gateway/api1.png?width=90pc)

   - **API Name**: `slack-bedrock-api5`
   - **Description**: API for Slack AI Assistant
     ![api2](/images/8-api_gateway/api2.png?width=90pc)
   - Create successfully
     ![api2](/images/8-api_gateway/api2-.png?width=90pc)

**Create Resource Structure**

3. Create a resource named **slack**:

   - **Resource Name**: slack
   - **Resource Path**: /

   ![api3](/images/8-api_gateway/api3.png?width=90pc)

4. Create a sub-resource named **ask-aws**:

   - **Parent Resource**: /slack
   - **Resource Name**: ask-ai
   - **Resource Path**: /slack/ask-ai

   ![api4](/images/8-api_gateway/api4.png?width=90pc)

**Configure Method**

5. Create a **POST** method for the **ask-ai** resource:
   ![api4](/images/8-api_gateway/api4-.png?width=90pc)

6. Configure method settings:

   - **Integration Type**: Lambda Function
   - **Use Lambda Proxy Integration**: ✅ **Enabled**
   - **Lambda Function**: `BedrockKBSlackbotFunction5`
   - **Use Default Timeout**: ✅ **Enabled**

   ![api5](/images/8-api_gateway/api5.png?width=90pc)

   - Method **POST** created successfully
     ![api6](/images/8-api_gateway/api6.png?width=90pc)

{{% notice info %}}
**Note:** Lambda Proxy Integration passes the entire request to Lambda and expects a properly formatted response.
{{% /notice %}}

**Deploy API**

7. Deploy the API to a new stage:

   - **Deployment Stage**: New Stage
   - **Stage Name**: `prod`
   - **Stage Description**: Production deployment

   ![api7](/images/8-api_gateway/api7.png?width=90pc)

**Update Slack Configuration**

8. Copy the **Invoke URL** from the deployed API:

   - Format: `https://your-api-id.execute-api.us-east-1.amazonaws.com/prod/slack/ask-ai`

   ![api8](/images/8-api_gateway/api8.png?width=90pc)

9. Update your Slack app's **Slash Commands** configuration:

   - Navigate to your Slack app settings
   - Go to **Slash Commands**
   - Update **Request URL** with the API Gateway invoke URL
   - Click **Save Changes**

   ![api9](/images/8-api_gateway/api9.png?width=90pc)

{{% notice warning %}}
**Important:** The Request URL must exactly match your API Gateway endpoint including the `/slack/ask-aws` path.
{{% /notice %}}

#### Testing Your AI Assistant

**Successful Knowledge Retrieval**

1. **Test Query**: Ask a question about content in your uploaded PDF

   - Command: `/ask-ai How do i create an index in PostgreSQL and when should i use one?`
   - **Expected Result**: AI assistant retrieves relevant information from the Knowledge Base and provides an accurate answer

   ![test1](/images/8-api_gateway/test1.png?width=90pc)

   - Command: `/ask-aws What are the main data types used in PostgreSQL?`
   - **Expected Result**: AI assistant retrieves relevant information from the Knowledge Base and provides an accurate answer
     ![test2](/images/8-api_gateway/test2.png?width=90pc)

**Guardrails Protection**

2. **Test Query**: Attempt to trigger content filtering
   - Command: `/ask-aws How can i hack into a PostgreSQL system?`
   - **Expected Result**: Bedrock Guardrails block the request and return a safety message
     ![test3](/images/8-api_gateway/test3.png?width=90pc)

**Information Not Available**

3. **Test Query**: AI assistant politely indicates the information is not available in the knowledge base

   - Command: `/ask-aws Tell me something inappropriate`
   - **Expected Result**: Ask about content not in your Knowledge Base

   ![test4](/images/8-api_gateway/test4.png?width=90pc)
   ![test5](/images/8-api_gateway/test5.png?width=90pc)

#### Testing Checklist

Verify your AI assistant handles these scenarios correctly:

- ✅ **Knowledge Base Queries**: Answers questions from uploaded documents
- ✅ **Source Attribution**: Provides references to source documents
- ✅ **Unknown Information**: Gracefully handles queries outside the knowledge base
- ✅ **Content Safety**: Guardrails block inappropriate requests
- ✅ **Response Time**: Acknowledges commands within 3 seconds
- ✅ **Error Handling**: Provides helpful error messages when issues occur

#### Troubleshooting Common Issues

**1. API Gateway Issues**

- **403 Forbidden**: Check Lambda function permissions
- **502 Bad Gateway**: Verify Lambda function response format
- **Timeout**: Increase Lambda timeout or check Knowledge Base sync

**2. Slack Integration Issues**

- **Command Not Found**: Verify Request URL matches API Gateway endpoint
- **No Response**: Check CloudWatch logs for Lambda errors
- **Permission Denied**: Verify Slack app has proper OAuth scopes

**3. Knowledge Base Issues**

- **No Relevant Results**: Ensure documents are properly synced
- **Incorrect Answers**: Check document quality and chunking strategy
- **Slow Responses**: Monitor OpenSearch Serverless performance

#### Congratulations! 🎉

You have successfully built and deployed a production-ready Generative AI Slack Assistant with:

- ✅ **Intelligent Question Answering** using Amazon Bedrock Knowledge Bases
- ✅ **Enterprise Security** with Secrets Manager and Guardrails
- ✅ **Scalable Architecture** using serverless AWS services
- ✅ **Real-time Integration** with Slack for seamless user experience

Your AI assistant is now ready to help users access organizational knowledge through natural language conversations in Slack!

---

#### Next Steps:

**Continue to**: [9. Clear resources](../9-clear%20resources/)

Consider these enhancements for production deployment:

- **Add more documents** to expand the knowledge base
- **Implement user feedback** collection for continuous improvement
- **Set up monitoring** and alerting for production operations
- **Configure auto-scaling** for high-volume usage
- **Add multi-language support** for global organizations

**Workshop Complete!** 🚀
