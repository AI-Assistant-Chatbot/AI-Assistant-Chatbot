+++
title = "Clear resources"
date = 2020-05-14T00:38:32+07:00
weight = 9
chapter = false
pre = "<b>9. </b>"
+++

## Resource Cleanup

This module guides you through properly cleaning up all AWS resources created during the workshop to avoid ongoing charges. Follow the deletion order carefully to prevent dependency errors.

{{% notice warning %}}
**Important:** Deleting these resources is irreversible. Ensure you have saved any important data or configurations before proceeding.
{{% /notice %}}

## Cleanup Order

Follow this specific order to avoid dependency conflicts:

### Step 1: Delete API Gateway

1. **Delete API Gateway**:
   - Navigate to API Gateway Console
   - Select your `slack-bedrock-api`
   - Click **Actions** → **Delete API**
   - Confirm deletion

   ![test13](/images/9/clear13.png?width=91pc)

### Step 2: Delete Lambda Function

2. **Delete Lambda Function**:
   - Navigate to Lambda Console
   - Select `BedrockKBSlackbotFunction5`
   - Click **Actions** → **Delete**
   - Confirm deletion

   ![test12](/images/9/clear12.png?width=91pc)

### Step 3: Delete Bedrock Knowledge Base

3. **Delete Knowledge Base**:
   - Navigate to Bedrock Console
   - Go to **Knowledge bases**
   - Select your knowledge base
   - Click **Delete**
   - Confirm deletion

   ![clear2](/images/9/clear2.png?width=91pc)
   ![clear3](/images/9/clear3.png?width=91pc)

{{% notice info %}}
**Note:** Wait for the Knowledge Base deletion to complete before proceeding to OpenSearch cleanup.
{{% /notice %}}

### Step 4: Delete OpenSearch Serverless Resources

4. **Delete OpenSearch Components** (in this order):

   **a) Delete Vector Index:**
   - Use Postman or AWS CLI to delete the index
   - DELETE request to: `https://your-collection-endpoint/slack-bedrock-os-index`

   ![clear7](/images/9/clear4.png?width=91pc)

   **b) Delete Collection:**
   - Navigate to OpenSearch Console
   - Select **Collections**
   - Delete `slack-bedrock-vector-db`

   ![clear7](/images/9/clear5.png?width=91pc)

   **c) Delete Data Access Policy:**
   - Go to **Data access policies**
   - Delete your access policy

   ![clear7](/images/9/clear6.png?width=91pc)

   **d) Delete Network Policy:**
   - Go to **Network policies**
   - Delete your network policy

   ![clear7](/images/9/clear7.png?width=91pc)

### Step 5: Delete Security Resources

5. **Delete AWS Secrets Manager Secrets**:
   - Navigate to Secrets Manager Console
   - Delete `bot-token5`
   - Delete `signing-secret5`
   - Confirm immediate deletion (skip recovery period)

   ![clear8](/images/9/clear8.png?width=91pc)
   ![clear9](/images/9/clear9.png?width=91pc)

6. **Delete Systems Manager Parameters**:
   - Navigate to Systems Manager Console
   - Go to **Parameter Store**
   - Delete `/slack-bot/token`
   - Delete `/slack-bot/signing-secret`

   ![clear10](/images/9/clear10.png?width=91pc)
   ![clear11](/images/9/clear11.png?width=91pc)

### Step 6: Delete S3 Resources

7. **Delete S3 Bucket**:
   - Navigate to S3 Console
   - **First**: Delete all objects in the bucket
   - **Then**: Delete the bucket itself
   - Confirm deletion

   ![clear1](/images/9/clear1.png?width=91pc)

### Step 7: Clean Up IAM Resources

8. **Delete IAM Role** (Optional):
   - Navigate to IAM Console
   - Delete `BedrockExecutionRole8888`
   - Delete `bedrock-chatbot-deployer` user
   - Remove any custom policies created

## Cost Verification

After cleanup, verify no ongoing charges:

### Check These Services:
- ✅ **Lambda**: No functions remaining
- ✅ **API Gateway**: No APIs remaining  
- ✅ **OpenSearch Serverless**: No collections or policies
- ✅ **S3**: No buckets with workshop data
- ✅ **Secrets Manager**: No secrets remaining
- ✅ **Bedrock**: Knowledge Base deleted (models remain enabled)

{{% notice tip %}}
**Tip:** Bedrock model access remains enabled but doesn't incur charges unless actively used. You can leave it enabled for future projects.
{{% /notice %}}

## Cleanup Checklist

Confirm all resources are deleted:

- ✅ API Gateway deleted
- ✅ Lambda function deleted
- ✅ Bedrock Knowledge Base deleted
- ✅ OpenSearch collection and policies deleted
- ✅ Secrets Manager secrets deleted
- ✅ Parameter Store parameters deleted
- ✅ S3 bucket and contents deleted
- ✅ IAM roles and users deleted (optional)

## Final Verification

1. **Check AWS Billing Dashboard**:
   - Verify no unexpected charges
   - Monitor for 24-48 hours after cleanup

2. **Review CloudWatch Logs**:
   - Log groups may remain but don't incur significant costs
   - Delete if desired: `/aws/lambda/BedrockKBSlackbotFunction5`

## Workshop Summary

Congratulations on completing the Generative AI Slack Assistant workshop! You have successfully:

- ✅ Built an enterprise-grade AI assistant
- ✅ Implemented RAG architecture with Amazon Bedrock
- ✅ Configured secure credential management
- ✅ Deployed serverless infrastructure
- ✅ Integrated with Slack for real-world usage
- ✅ Properly cleaned up resources

## Next Steps

Consider these follow-up activities:

- **Explore Advanced Features**: Guardrails customization, multi-modal inputs
- **Scale the Solution**: Multiple knowledge bases, user personalization
- **Production Deployment**: CI/CD pipelines, monitoring, alerting
- **Cost Optimization**: Reserved capacity, usage analytics

Thank you for participating in this workshop! 🎉

---

**Workshop Complete** - All resources cleaned up successfully!