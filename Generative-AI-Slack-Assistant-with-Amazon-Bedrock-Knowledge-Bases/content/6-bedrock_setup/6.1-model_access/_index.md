---
title: "Setup Model Access"
date: "`r Sys.Date()`"
weight: 1
chapter: false
pre: " <b> 6.1 </b> "
---

#### Enable Foundation Model Access

This section guides you through enabling access to the required Amazon Bedrock foundation models for your AI assistant.

#### Required Models

For this workshop, you need access to:

- **Amazon Titan Text Embeddings V2**: For document vectorization
- **Anthropic Claude 3 Sonnet**: For intelligent text generation

#### Access Bedrock Console

1. Navigate to [Amazon Bedrock Console](https://us-east-1.console.aws.amazon.com/bedrock/home?region=us-east-1#/overview)
   ![modelAccess0](/images/6/modelAccess0.png?width=91pc)

#### Navigate to Model Access

2. Scroll down to the bottom of the **navigation sidebar** and choose **Model access**
   ![modelAccess1](/images/6/modelAccess10.png?width=90pc)

#### Modify Model Access

3. Click **Modify model access**
   ![modelAccess2](/images/6/modelAccess20.png?width=91pc)

#### Select Required Models

4. Select the models needed for this workshop:

   - ✅ **Amazon Titan Text Embeddings V2**
   - ✅ **Anthropic Claude 3 Sonnet**

   ![modelAccess3](/images/6/modelAccess30.png?width=91pc)
   ![modelAccess4](/images/6/modelAccess40.png?width=91pc)

   - Click **Next** to proceed
     ![modelAccess5](/images/6/modelAccess50.png?width=91pc)

#### Submit Access Request

5. Review your model selections and click **Submit**

   - Access requests are typically approved instantly for these models
   - Wait a few minutes for the access to be granted

   ![modelAccess6](/images/6/modelAccess60.png?width=91pc)

#### Verify Model Access

6. Confirm both models show **Access granted** status:

   - ✅ **Amazon Titan Text Embeddings V2**: Access granted
   - ✅ **Anthropic Claude 3 Sonnet**: Access granted

   ![modelAccess7](/images/6/modelAccess70.png?width=91pc)
   ![modelAccess8](/images/6/modelAccess80.png?width=90pc)

{{% notice tip %}}
**Tip:** Model access is typically granted immediately for Titan and Claude models. If you encounter delays, ensure your AWS account is in good standing.
{{% /notice %}}

#### What's Next

With foundation model access enabled, you're ready to create the Knowledge Base that will power your AI assistant's intelligent responses.

---

**Continue to**: [6.2 Setup Guardrails](../6.2-guardrails/)
