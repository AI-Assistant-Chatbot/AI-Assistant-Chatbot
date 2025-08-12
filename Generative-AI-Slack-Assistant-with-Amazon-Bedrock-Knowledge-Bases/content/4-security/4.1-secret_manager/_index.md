---
title: "Configure AWS Secrets Manager"
date: "2025-06-30"
weight: 1
chapter: false
pre: " <b> 4.1 </b> "
---

AWS Secrets Manager securely stores and manages your Slack bot credentials with encryption at rest and automatic rotation capabilities.

#### Access Secrets Manager Console

1. Navigate to [AWS Secrets Manager Console](https://console.aws.amazon.com/secretsmanager/)
   
  ![secret0](/images/4-security/4.1-secret_manager/secret1.png?width=90pc)

#### Prepare Slack Credentials

2. Copy your **Bot User OAuth Token** from Slack (from Module 3.3):
   
  ![slack_OAuth](/images/4-security/4.1-secret_manager/getOAuth1.png?width=90pc)

#### Create Bot Token Secret

3. Create a new secret for **bot-token**:

   - Click **Store a new secret**
   - Select **Other type of secret**
   - Enter key-value pair: `SLACK_BOT_TOKEN` = `your-bot-token-value`

  ![secret1](/images/4-security/4.1-secret_manager/secret2.png?width=90pc)

   - Name: `bot-token5`

  ![secret2](/images/4-security/4.1-secret_manager/secret3.png?width=90pc)

   - Created successfully

  ![secret3](/images/4-security/4.1-secret_manager/secret3-.png?width=90pc)

   - Save the **ARN**

  ![secret8](/images/4-security/4.1-secret_manager/secret4.png?width=90pc)

#### Get Signing Secret

4. Copy your **Signing Secret** from Slack app settings:
   
  ![slack_secret](/images/4-security/4.1-secret_manager/secret5-.png?width=90pc)

#### Create Signing Secret

5. Create a new secret for **signing-secret**:

   - Click **Store a new secret**
   - Select **Other type of secret**
   - Enter key-value pair: `SLACK_SIGNING_SECRET` = `your-signing-secret-value`

  ![secret4](/images/4-security/4.1-secret_manager/secret6-.png?width=90pc)

   - Name: `signing-secret5`
   - Created successfully

  ![secret6](/images/4-security/4.1-secret_manager/secret6.png?width=90pc)

   - Save the **ARN**

  ![secret7](/images/4-security/4.1-secret_manager/secret7-.png?width=90pc)

{{% notice tip %}}
**Tip:** Keep the secret names consistent (`bot-token5` and `signing-secret5`) as they will be referenced in Parameter Store configuration.
{{% /notice %}}

#### What's Next

Your Slack credentials are now securely stored in AWS Secrets Manager. Next, we'll configure Parameter Store to enable runtime access to these secrets.

---

**Continue to**: [4.2 Configure Systems Manager Parameter Store](../4.2-systems_manager/)
