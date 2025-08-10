+++
title = "Get OAuth Tokens"
date = 2020-05-14T00:38:32+07:00
weight = 3
chapter = false
pre = "<b>3.3 </b>"
+++

#### Configure Bot Permissions

1. Navigate to **OAuth & Permissions** in your app settings
2. Scroll down to **Scopes** → **Bot Token Scopes** and add:
   - `commands` - Enable slash commands
   - `chat:write` - Send messages as bot
   - `channels:read` - Give the bot access to basic information of public channels in the Slack workspace
  ![slack_scope](/images/3/slack_scope.png?width=90pc)

#### Install App to Workspace

3. Scroll up and click **Install to Workspace**

![getOAuth1](/images/3/slack_OAuth0.png?width=90pc)

4. Review permissions and click **Allow**

![getOAuth](/images/3/slack_OAuth1.png?width=90pc)

#### Copy OAuth Tokens

5. After installation, you'll see the **Bot User OAuth Token** (starts with `xoxb-`)

![getOAuth](/images/4/getOAuth1.png?width=90pc)

6. **Copy and save this token securely** - you'll need it for AWS Lambda configuration

{{% notice warning %}}
**Important:** Keep your OAuth token secure and never commit it to version control. We'll store it in AWS Secrets Manager later.
{{% /notice %}}

### What's Next

Your Slack app is now fully configured with the necessary permissions and tokens. Next, we'll move on to building the AWS infrastructure that will power your AI assistant.

---

**Continue to**: [Module 4 - Security Configuration](../../4-security/)
