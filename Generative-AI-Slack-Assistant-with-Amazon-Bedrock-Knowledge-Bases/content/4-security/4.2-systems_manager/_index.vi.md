+++
title = "Cấu hình Systems Manager Parameter Store"
date = 2024-05-14T00:38:32+07:00
weight = 2
chapter = false
pre = "<b>4.2 </b>"
+++

AWS Systems Manager Parameter Store cung cấp runtime secret resolution bằng cách tạo tham chiếu đến Secrets Manager, cho phép Lambda functions fetch credentials động mà không cần truy cập trực tiếp đến secrets.

#### Truy cập Parameter Store

1. Điều hướng đến [AWS Systems Manager Console](https://console.aws.amazon.com/systems-manager/)
   ![ssm1](/images/4/ssm1.png?width=90pc)

#### Tạo Bot Token Parameter

2. Tạo parameter cho **bot-token5**:

   - Nhấp **Create parameter**
     ![ssm2](/images/4/ssm2.png?width=91pc)
   - **Name**: `/slack/bot-token5/parameter5`

   ![ssm3](/images/4/ssm3.png?width=91pc)

   - **Type**: String
   - **Value**: `slack/bot-token5`
     ![ssm4](/images/4/ssm4.png?width=91pc)
   - Tạo thành công
     ![ssm5](/images/4/ssm5.png?width=91pc)

#### Tạo Signing Secret Parameter

3. Tạo parameter cho **signing-secret5**:

   - Nhấp **Create parameter**
   - **Name**: `/slack/signing-secret5/parameter5`
     ![ssm6](/images/4/ssm6.png?width=91pc)
   - **Type**: String
   - **Value**: `slack/signing-secret5`
     ![ssm7](/images/4/ssm7.png?width=91pc)
     - Tạo thành công
     ![ssm8](/images/4/ssm8.png?width=91pc)

#### Ghi chú Parameter ARNs

4. Sao chép **Parameter ARNs** cho cấu hình IAM policy:

   - Signing secret ARN: `arn:aws:ssm:region:account:parameter/slack/signing-secret5/parameter5`

   ![ssm9](/images/4/ssm9.png?width=91pc)

   - Bot token ARN: `arn:aws:ssm:region:account:parameter/slack/bot-token5/parameter5`
     ![ssm10](/images/4/ssm10.png?width=91pc)

#### Tiếp theo là gì

Parameter Store của bạn hiện đã được cấu hình để tham chiếu an toàn đến Secrets Manager. Các parameters này sẽ được sử dụng bởi Lambda functions để truy cập Slack credentials mà không bị lộ secret trực tiếp.

---

**Tiếp tục đến**: [5 OpenSearch Serverless](../../5-opensearch/)