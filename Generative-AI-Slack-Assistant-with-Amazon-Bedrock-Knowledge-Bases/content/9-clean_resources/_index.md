---
title: "Clean Resources"
date: "2025-06-30"
weight: 9
chapter: false
pre: " <b> 9. </b> "
---

#### Resource Cleanup

This module guides you through properly cleaning up all AWS resources created during the workshop to avoid ongoing charges. Follow the deletion order carefully to prevent dependency errors.

{{% notice warning %}}
**Important:** Deleting these resources is irreversible. Ensure you have saved any important data or configurations before proceeding.
{{% /notice %}}

#### Cleanup Order

Follow this specific order to avoid dependency conflicts:

**Delete API Gateway**

1. **Delete API Gateway**:

   - Navigate to API Gateway Console
   - Select your `slack-bedrock-api5`
   - Click **Actions** → **Delete API**
   - Confirm deletion

   ![test13](/images/9-clean_resources/clear13.png?width=90pc)

**Delete Lambda Function**

2. **Delete Lambda Function**:

   - Navigate to Lambda Console
   - Select `BedrockKBSlackbotFunction5`
   - Click **Actions** → **Delete**
   - Confirm deletion

   ![test12](/images/9-clean_resources/clear12.png?width=90pc)

**Delete Bedrock Knowledge Base**

3. **Delete Knowledge Base**:

   - Navigate to S3 Console
   - **First**: Delete all objects in the bucket
   - **Then**: Delete the bucket itself
   - Confirm deletion

   ![clear1](/images/9-clean_resources/clear1.png?width=90pc)
   ![clear2](/images/9-clean_resources/clear2.png?width=90pc)

   - Navigate to Bedrock Console
   - Go to **Knowledge bases**
   - Select your knowledge base
   - Click **Delete**
   - Confirm deletion

   ![clear3](/images/9-clean_resources/clear3.png?width=90pc)

{{% notice info %}}
**Note:** Wait for the Knowledge Base deletion to complete before proceeding to OpenSearch cleanup.
{{% /notice %}}

**Delete OpenSearch Serverless Resources**

4. **Delete OpenSearch Components** (in this order):

   **a. Delete Vector Index:**

   - Use Postman or AWS CLI to delete the index
   - DELETE request to: `https://your-collection-endpoint/slack-bedrock-os-index5`

   ![clear7](/images/9-clean_resources/clear4.png?width=90pc)

   **b. Delete Collection:**

   - Navigate to OpenSearch Console
   - Select **Collections**
   - Delete `slack-bedrock-vector-db5`

   ![clear7](/images/9-clean_resources/clear5.png?width=90pc)

   **c. Delete Data Access Policy:**

   - Go to **Data access policies**
   - Delete your access policy

   ![clear7](/images/9-clean_resources/clear6.png?width=90pc)

   **d. Delete Network Policy:**

   - Go to **Network policies**
   - Delete your network policy

   ![clear7](/images/9-clean_resources/clear7.png?width=90pc)

**Delete Security Resources**

5. **Delete AWS Secrets Manager Secrets**:

   - Navigate to Secrets Manager Console
   - Delete `slack/bot-token5`
   - Delete `slack/signing-secret5`
   - Confirm immediate deletion (skip recovery period)

   ![clear8](/images/9-clean_resources/clear8.png?width=90pc)
   ![clear9](/images/9-clean_resources/clear9.png?width=90pc)

6. **Delete Systems Manager Parameters**:

   - Navigate to Systems Manager Console
   - Go to **Parameter Store**
   - Delete `/slack/bot-token5/parameter5`
   - Delete `/slack/signing-secret5/parameter5`

   ![clear10](/images/9-clean_resources/clear10.png?width=90pc)
   ![clear11](/images/9-clean_resources/clear11.png?width=90pc)

**Clean Up IAM Resources**

8. **Delete IAM Role** (Optional):
   - Navigate to IAM Console
   - Delete `BedrockExecutionRole8888`
   - Delete `bedrock-chatbot-deployer` user
   - Remove any custom policies created

#### Cost Verification

After cleanup, verify no ongoing charges:

**Check These Services:**

- ✅ **Lambda**: No functions remaining
- ✅ **API Gateway**: No APIs remaining
- ✅ **OpenSearch Serverless**: No collections or policies
- ✅ **S3**: No buckets with workshop data
- ✅ **Secrets Manager**: No secrets remaining
- ✅ **Bedrock**: Knowledge Base deleted (models remain enabled)

{{% notice tip %}}
**Tip:** Bedrock model access remains enabled but doesn't incur charges unless actively used. You can leave it enabled for future projects.
{{% /notice %}}

#### Cleanup Checklist

Confirm all resources are deleted:

- ✅ API Gateway deleted
- ✅ Lambda function deleted
- ✅ Bedrock Knowledge Base deleted
- ✅ OpenSearch collection and policies deleted
- ✅ Secrets Manager secrets deleted
- ✅ Parameter Store parameters deleted
- ✅ S3 bucket and contents deleted
- ✅ IAM roles and users deleted (optional)

#### Final Verification

1. **Check AWS Billing Dashboard**:

   - Verify no unexpected charges
   - Monitor for 24-48 hours after cleanup

2. **Review CloudWatch Logs**:
   - Log groups may remain but don't incur significant costs
   - Delete if desired: `/aws/lambda/BedrockKBSlackbotFunction5`

#### Workshop Summary

Congratulations on completing the Generative AI Slack Assistant workshop! You have successfully:

- ✅ Built an enterprise-grade AI assistant
- ✅ Implemented RAG architecture with Amazon Bedrock
- ✅ Configured secure credential management
- ✅ Deployed serverless infrastructure
- ✅ Integrated with Slack for real-world usage
- ✅ Properly cleaned up resources

---

**Workshop Complete** - All resources cleaned up successfully!
