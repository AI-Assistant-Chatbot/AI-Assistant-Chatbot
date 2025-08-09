+++
title = "Configure Systems Manager Parameter Store"
date = 2024-05-14T00:38:32+07:00
weight = 2
chapter = false
pre = "<b>4.2 </b>"
+++

AWS Systems Manager Parameter Store provides runtime secret resolution by creating references to Secrets Manager, enabling Lambda functions to dynamically fetch credentials without direct access to secrets.

#### Access Parameter Store

1. Navigate to [AWS Systems Manager Console](https://console.aws.amazon.com/systems-manager/)
   ![ssm1](/images/4/ssm1.png?width=90pc)

#### Create Bot Token Parameter

2. Create a parameter for **bot-token5**:

   - Click **Create parameter**
   - **Name**: `/slack-bot/token`
   - **Type**: String
   - **Value**: `{{resolve:secretsmanager:bot-token5:SecretString:SLACK_BOT_TOKEN}}`

   ![ssm2](/images/4/ssm2.png?width=91pc)
   ![ssm3](/images/4/ssm3.png?width=91pc)
   ![ssm4](/images/4/ssm4.png?width=91pc)
   ![ssm5](/images/4/ssm5.png?width=91pc)

#### Create Signing Secret Parameter

3. Create a parameter for **signing-secret5**:

   - Click **Create parameter**
   - **Name**: `/slack-bot/signing-secret`
   - **Type**: String
   - **Value**: `{{resolve:secretsmanager:signing-secret5:SecretString:SLACK_SIGNING_SECRET}}`

   ![ssm6](/images/4/ssm6.png?width=91pc)
   ![ssm7](/images/4/ssm7.png?width=91pc)
   ![ssm8](/images/4/ssm8.png?width=91pc)

#### Note Parameter ARNs

4. Copy the **Parameter ARNs** for IAM policy configuration:

   - Bot token ARN: `arn:aws:ssm:region:account:parameter/slack-bot/token`
   - Signing secret ARN: `arn:aws:ssm:region:account:parameter/slack-bot/signing-secret`

   ![ssm9](/images/4/ssm9.png?width=91pc)
   ![ssm10](/images/4/ssm10.png?width=91pc)

{{% notice info %}}
**Note:** The `{{resolve:secretsmanager:...}}` syntax enables dynamic resolution of secrets at runtime, ensuring Lambda functions always get the latest credential values.
{{% /notice %}}

#### What's Next

Your Parameter Store is now configured to securely reference Secrets Manager. These parameters will be used by Lambda functions to access Slack credentials without direct secret exposure.

---

**Continue to**: [Module 5 - Knowledge Base Foundation](../../5-knowledge-base/)
