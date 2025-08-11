---
title: "Environment Setup"
date: "2025-06-30"
weight: 2
chapter: false
pre: " <b> 2. </b> "
---

#### Environment Setup Overview

Before building your Generative AI Slack Assistant, you need to set up the required environments and tools. This module will guide you through creating a Slack workspace, configuring AWS services, and preparing your development environment.

#### Prerequisites Checklist

Ensure you have the following before proceeding:

- ✅ **AWS Account** with administrative access
- ✅ **Email address** for Slack workspace creation
- ✅ **Python 3.12+** installed on your local machine
- ✅ **AWS CLI** installed and configured
- ✅ **Code editor** (VS Code recommended)

#### Module Learning Objectives

By the end of this module, you will have:

1. **Created a Slack workspace** for testing the bot
2. **Configured AWS CLI** with proper credentials
3. **Enabled Amazon Bedrock models** in your AWS account
4. **Set up your development environment** with required dependencies
5. **Verified all prerequisites** for the workshop

---

#### Create Slack Workspace

**1. Navigate to Slack**

- Go to [Slack.com](https://slack.com/) and click **Create a new workspace**.

  ![slackWorkSpace1](/images/2-environment-setup/slackWorkSpace1.png?width=90pc)

**2. Sign Up Process**

- **Enter your email to sign in**

![slackWorkSpace2](/images/2-environment-setup/slackWorkSpace2.png?width=90pc)

**3. Click Create a Workspace**
![slackWorkSpace3](/images/2-environment-setup/slackWorkSpace3.png?width=90pc)

#### Complete Workspace Setup

**1. Complete the workspace creation process by providing:**

- **Workspace name** (e.g., "AI-Assistant-Workshop")
- **Channel name** (e.g., "#ai-assistant")
- **Team member invitations** (optional for workshop)

![slackWorkSpace4](/images/2-environment-setup/slackWorkSpace4.png?width=90pc)

{{% notice tip %}}
**Tip:** Keep your workspace name simple and related to the workshop. You'll use this workspace to test your AI assistant.
{{% /notice %}}

---

#### AWS Account Configuration

**1. Verify AWS Account Access**

**Log in to AWS Console**

- Navigate to [AWS Console](https://console.aws.amazon.com/)
- Ensure you have administrative access or the following permissions:
  - Amazon Bedrock full access
  - Lambda full access
  - API Gateway full access
  - S3 full access
  - OpenSearch Serverless access

**2. Configure AWS CLI**

**Install AWS CLI** (if not already installed)

```bash
# Windows
msiexec.exe /i https://awscli.amazonaws.com/AWSCLIV2.msi

# macOS
curl "https://awscli.amazonaws.com/AWSCLIV2.pkg" -o "AWSCLIV2.pkg"
sudo installer -pkg AWSCLIV2.pkg -target /

# Linux
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
```

**3. Configure AWS credentials**

```bash
aws configure
```

Enter the following when prompted:

- **AWS Access Key ID**: Your access key
- **AWS Secret Access Key**: Your secret key
- **Default region name**: `us-east-1` (recommended for Bedrock)
- **Default output format**: `json`

**4. Verify configuration**

```bash
aws sts get-caller-identity
```

{{% notice warning %}}
**Important:** Use `us-east-1` region for this workshop as it has the best model availability for Amazon Bedrock.
{{% /notice %}}

---

#### Troubleshooting Common Issues

**AWS CLI Issues**

- **Problem**: `aws: command not found`
- **Solution**: Restart terminal after installation or add AWS CLI to PATH

{{% notice tip %}}
**Need Help?** If you encounter issues, check the [Troubleshooting Guide](https://docs.aws.amazon.com/cli/v1/userguide/cli-chap-troubleshooting.html) or ask the workshop instructor.
{{% /notice %}}

---

#### Next Steps

With your environment properly configured, you're ready to start building the knowledge base foundation for your AI assistant.

**Continue to**: [Slack App Setup](../3-slack_app/)

---

#### Summary

In this module, you have:

- ✅ Created a Slack workspace for testing
- ✅ Configured AWS CLI and verified access

Your development environment is now ready for building the Generative AI Slack Assistant!
