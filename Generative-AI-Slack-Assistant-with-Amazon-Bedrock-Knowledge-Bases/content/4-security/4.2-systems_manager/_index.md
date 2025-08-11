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
   ![ssm1](/images/4-security/4.2-systems_manager/ssm1.png?width=90pc)

#### Create Bot Token Parameter

2. Create a parameter for **bot-token5**:

   - Click **Create parameter**
     ![ssm2](/images/4-security/4.2-systems_manager/ssm2.png?width=91pc)
   - **Name**: `/slack/bot-token5/parameter5`

   ![ssm3](/images/4-security/4.2-systems_manager/ssm3.png?width=91pc)

   - **Type**: String
   - **Value**: `slack/bot-token5`
     ![ssm4](/images/4-security/4.2-systems_manager/ssm4.png?width=91pc)
   - Create successfully
     ![ssm5](/images/4-security/4.2-systems_manager/ssm5.png?width=91pc)

#### Create Signing Secret Parameter

3. Create a parameter for **signing-secret5**:

   - Click **Create parameter**
   - **Name**: `/slack/signing-secret5/parameter5`
     ![ssm6](/images/4-security/4.2-systems_manager/ssm6.png?width=91pc)
   - **Type**: String
   - **Value**: `slack/signing-secret5`
     ![ssm7](/images/4-security/4.2-systems_manager/ssm7.png?width=91pc)
     -Create successfully
     ![ssm8](/images/4-security/4.2-systems_manager/ssm8.png?width=91pc)

#### Note Parameter ARNs

4. Copy the **Parameter ARNs** for IAM policy configuration:

   - Signing secret ARN: `arn:aws:ssm:region:account:parameter/slack/signing-secret5/parameter5`

   ![ssm9](/images/4-security/4.2-systems_manager/ssm9.png?width=91pc)

   - Bot token ARN: `arn:aws:ssm:region:account:parameter/slack/bot-token5/parameter5`
     ![ssm10](/images/4-security/4.2-systems_manager/ssm10.png?width=91pc)

#### What's Next

Your Parameter Store is now configured to securely reference Secrets Manager. These parameters will be used by Lambda functions to access Slack credentials without direct secret exposure.

---

**Continue to**: [5 OpenSearch Serverless](../../5-opensearch/)
