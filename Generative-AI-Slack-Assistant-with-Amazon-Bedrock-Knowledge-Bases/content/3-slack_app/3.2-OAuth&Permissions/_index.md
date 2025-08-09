+++
title = "Create slash commands"
date = 2020-05-14T00:38:32+07:00
weight = 2
chapter = false
pre = "<b>3.2 </b>"
+++

#### Navigate to Slash Commands

1. In your app settings, click **Slash Commands** → **Create New Command**

![slackCommand1](/images/3/slashCommand1.png?width=90pc)

#### Configure Command Details

2. Fill in the command configuration:

   - **Command**: `/ask-aws`
   - **Request URL**: `https://example.com/slack/ask-aws` (temporary)
   - **Short Description**: `Ask questions about AWS documentation`
   - **Usage Hint**: `[your question about AWS]`

![slackCommand2](/images/3/slashCommand2.png?width=90pc)

{{% notice info %}}
**Note:** The Request URL is temporary. We'll update it with the actual API Gateway URL after deploying our AWS infrastructure.
{{% /notice %}}

#### Save Command

3. Click **Save** to create the slash command successfully

![slackCommand3](/images/3/slashCommand3.png?width=90pc)

#### What's Next

Your slash command is now configured! Next, we'll set up the necessary OAuth permissions for your bot to function properly.

---

**Continue to**: [3.3 - Configure OAuth Permissions](../3.3-oauth_permissions/)
