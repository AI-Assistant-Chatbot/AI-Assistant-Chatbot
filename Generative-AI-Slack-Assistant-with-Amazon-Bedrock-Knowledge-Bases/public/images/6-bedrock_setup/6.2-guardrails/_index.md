---
title: "Setup Guardrails"
date: "2025-06-30"
weight: 2
chapter: false
pre: " <b> 6.2 </b> "
---

#### Amazon Bedrock Guardrails Overview

Amazon Bedrock Guardrails help you implement safeguards for your generative AI applications by filtering harmful content, blocking unwanted topics, and removing sensitive information. This ensures your Slack AI assistant provides safe and appropriate responses.

#### Prerequisites

Before setting up guardrails, ensure you have:

- ✅ Access to Amazon Bedrock console
- ✅ Appropriate IAM permissions for Bedrock Guardrails
- ✅ Understanding of your content filtering requirements

---

#### Access Bedrock Guardrails Console

**1. Navigate to Amazon Bedrock**

- Go to [Amazon Bedrock Console](https://console.aws.amazon.com/bedrock/)
- Ensure you're in the **us-east-1** region
- Click **Guardrails** in the left navigation panel
- Click **Create guardrail** button
- This will start the guardrail configuration wizard

![guardrail1](/images/6/guardrail1.png?width=90pc)

**2. Create New Guardrail**

- **Name**: `slack-ai-assistant-guardrail`
- **Description**: `Guardrail for Slack AI Assistant to filter harmful content and protect sensitive information`

![guardrail2](/images/6/guardrail2.png?width=90pc)

---

#### Configure Content Filters

**1. Set Up Harmful Content Filters**

Configure filters for different types of harmful content:

- **Hate Speech**: `High` - Block content promoting hatred
- **Insults**: `Medium` - Filter insulting language
- **Sexual Content**: `High` - Block inappropriate sexual content
- **Violence**: `High` - Filter violent content
- **Misconduct**: `Medium` - Block unethical behavior content

![guardrail3](/images/6/guardrail3.png?width=90pc)

---

**2. Set Up Prompt Attacks**

- **Prompt Attacks**: `High` - Prevent prompt injection attacks
  ![guardrail4](/images/6/guardrail4.png?width=90pc)

---

#### Configure Word Filters (Optional)

**1. Set Up Profanity Filters**

Add specific words or phrases to block:

- **Profanity Filter**: Enable to block common profanity
- **Custom Words**: Add company-specific terms to avoid
- **Sensitive Terms**: Block internal code names or confidential terms

![guardrail5](/images/6/guardrail5.png?width=90pc)

![guardrail6](/images/6/guardrail6.png?width=90pc)

---

- Save **ARN** and **ID**

![guardrail7](/images/6/guardrail7.png?width=91pc)

---

#### Troubleshooting Common Issues

**1. Guardrail Creation Fails**

- **Issue**: Permission denied
- **Solution**: Verify IAM permissions for Bedrock Guardrails

**2. Over-filtering Legitimate Content**

- **Issue**: Too many false positives
- **Solution**: Adjust filter levels from High to Medium

**3. PII Not Being Detected**

- **Issue**: Sensitive data passing through
- **Solution**: Enable additional PII types or use custom regex patterns

{{% notice tip %}}
**Best Practice:** Start with moderate filtering levels and adjust based on your organization's needs and user feedback.
{{% /notice %}}

---

#### Next Steps

With your guardrail configured, you're ready to integrate it with your Knowledge Base.

**Continue to**: [6.3 Knowledge Base Setup](../6.3-knowledge_base/)

---

#### Summary

In this section, you have:

- ✅ Created an Amazon Bedrock Guardrail
- ✅ Configured content filters for harmful content
- ✅ Set up PII protection for sensitive information
- ✅ Tested the guardrail functionality
- ✅ Prepared for Lambda integration

Your AI assistant now has robust safety measures to ensure appropriate and secure responses in your Slack workspace!
