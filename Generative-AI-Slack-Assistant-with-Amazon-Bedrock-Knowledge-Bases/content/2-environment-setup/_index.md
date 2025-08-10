+++
title = "Environment Setup"
date = 2020-05-14T00:38:32+07:00
weight = 2
chapter = false
pre = "<b>2. </b>"
+++

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

    ![slackWorkSpace1](/images/2/slackWorkSpace1.png?width=90pc)

**2. Sign Up Process**

- **Enter your email to sign in**

![slackWorkSpace2](/images/2/slackWorkSpace2.png?width=90pc)

**3. Click Create a Workspace**
![slackWorkSpace3](/images/2/slackWorkSpace3.png?width=90pc)

#### Complete Workspace Setup

**1. Complete the workspace creation process by providing:**

- **Workspace name** (e.g., "AI-Assistant-Workshop")
- **Channel name** (e.g., "#ai-assistant")
- **Team member invitations** (optional for workshop)

![slackWorkSpace4](/images/2/slackWorkSpace4.png?width=91pc)

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

#### Enable Amazon Bedrock Models

**1. Access Bedrock Console**

**Navigate to Amazon Bedrock**

- Go to [Amazon Bedrock Console](https://console.aws.amazon.com/bedrock/)
- Ensure you're in the **us-east-1** region

**2. Request Model Access**

**Enable required models**

- Click **Model access** in the left navigation
- Click **Modify model access** or **Enable specific models**

**Select the following models:**

- ✅ **Amazon Titan Text Embeddings V2** (for vector embeddings)
- ✅ **Anthropic Claude 3 Sonnet** (for text generation)

**Submit access request**

- Click **Next** → **Submit**
- Wait for approval (usually instant for these models)

#### Verify Model Access

**Confirm access granted**

- Check that both models show **Access granted** status
- This may take a few minutes

{{% notice info %}}
**Note:** Model access is typically granted immediately for Titan and Claude models. If you encounter issues, ensure your AWS account is in good standing.
{{% /notice %}}

---

#### Development Environment Setup

**1. Python Environment**

**Verify Python installation**

```bash
python --version
# Should show Python 3.12 or higher
```

**Create virtual environment**

```bash
python -m venv bedrock-slack-env

# Activate (Windows)
bedrock-slack-env\Scripts\activate

# Activate (macOS/Linux)
source bedrock-slack-env/bin/activate
```

**2. Install Required Dependencies**

**Install core packages**

```bash
pip install boto3 slack-bolt python-dotenv requests
```

**Install AWS CDK (for infrastructure deployment)**

```bash
npm install -g aws-cdk
cdk --version
```

**3. Verify Installation**

**Test AWS SDK connection**

```python
import boto3

# Test Bedrock connection
bedrock = boto3.client('bedrock', region_name='us-east-1')
print("AWS SDK configured successfully!")
```

---

#### Environment Verification

**1. Complete Setup Checklist**

Verify all components are properly configured:

- ✅ **Slack workspace created** and accessible
- ✅ **AWS CLI configured** with valid credentials
- ✅ **Bedrock models enabled** (Titan + Claude 3)
- ✅ **Python environment** set up with dependencies
- ✅ **AWS CDK installed** and functional

**2. Test Basic Connectivity**

Run this verification script:

```python
import boto3
import json

def verify_setup():
    try:
        # Test AWS connection
        sts = boto3.client('sts')
        identity = sts.get_caller_identity()
        print(f"✅ AWS Account: {identity['Account']}")

        # Test Bedrock access
        bedrock = boto3.client('bedrock', region_name='us-east-1')
        models = bedrock.list_foundation_models()
        print("✅ Bedrock access confirmed")

        print("\n🎉 Environment setup complete!")
        return True

    except Exception as e:
        print(f"❌ Setup error: {e}")
        return False

if __name__ == "__main__":
    verify_setup()
```

---

#### Troubleshooting Common Issues

**1. AWS CLI Issues**

- **Problem**: `aws: command not found`
- **Solution**: Restart terminal after installation or add AWS CLI to PATH

**2. Bedrock Access Issues**

- **Problem**: Model access denied
- **Solution**: Ensure you're in us-east-1 region and have proper IAM permissions

**3. Python Environment Issues**

- **Problem**: Package installation fails
- **Solution**: Ensure virtual environment is activated and pip is updated

{{% notice tip %}}
**Need Help?** If you encounter issues, check the [Troubleshooting Guide](../troubleshooting/) or ask the workshop instructor.
{{% /notice %}}

---

#### Next Steps

With your environment properly configured, you're ready to start building the knowledge base foundation for your AI assistant.

**Continue to**: [Module 3 - Slack App Setup](../3-slack_app/)

---

#### Summary

In this module, you have:

- ✅ Created a Slack workspace for testing
- ✅ Configured AWS CLI and verified access
- ✅ Enabled required Amazon Bedrock models
- ✅ Set up Python development environment
- ✅ Verified all components are working correctly

Your development environment is now ready for building the Generative AI Slack Assistant!
