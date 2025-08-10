+++
title = "Slack App Setup"
date = 2020-05-14T00:38:32+07:00
weight = 3
chapter = false
pre = "<b>3. </b>"
+++

#### Overview

A Slack app extends Slack's functionality by adding new features, automating tasks, and integrating with external services. For our AI assistant, the Slack app serves as the interface between users and our Amazon Bedrock-powered knowledge base, enabling natural language queries through slash commands.

#### What You'll Accomplish

In this module, you will:

- Create a new Slack app in your workspace
- Configure OAuth permissions and slash commands
- Generate authentication tokens for AWS integration
- Test the basic app installation

#### Key Components

**1. Slack App Configuration**

- **App Name**: AWS AI Assistant
- **Slash Command**: `/ask-ai`
- **Required Permissions**: `commands`, `chat:write`, `channels:read`

**2. Authentication Credentials**

- **Bot Token**: For API communication (starts with `xoxb-`)
- **Signing Secret**: For request verification
- **Request URL**: Will connect to AWS API Gateway

#### Expected Outcome

By the end of this module, you'll have a configured Slack app ready to connect with the AWS backend infrastructure we'll build in subsequent modules. The slash command will be visible in your workspace but won't function until we deploy the complete solution.

---

**Continue to**: [Module 4 - Knowledge Base Foundation](../4-knowledge-base/)
