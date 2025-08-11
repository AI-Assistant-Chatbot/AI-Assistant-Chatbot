---
title: "Cấu hình AWS Secrets Manager"
date: "2025-06-30"
weight: 1
chapter: false
pre: " <b> 4.1 </b> "
---

AWS Secrets Manager lưu trữ và quản lý an toàn thông tin đăng nhập Slack bot với mã hóa at rest và khả năng rotation tự động.

#### Truy cập Secrets Manager Console

1. Điều hướng đến [AWS Secrets Manager Console](https://console.aws.amazon.com/secretsmanager/)
   ![secret0](/images/4-security/4.1-secret_manager/secret1.png?width=91pc)

#### Chuẩn bị Slack Credentials

2. Sao chép **Bot User OAuth Token** từ Slack (từ Module 3.3):
   ![slack_OAuth](/images/4-security/4.1-secret_manager/getOAuth1.png?width=90pc)

#### Tạo Bot Token Secret

3. Tạo secret mới cho **bot-token**:

   - Nhấp **Store a new secret**
   - Chọn **Other type of secret**
   - Nhập key-value pair: `SLACK_BOT_TOKEN` = `giá-trị-bot-token-của-bạn`

   ![secret1](/images/4-security/4.1-secret_manager/secret2.png?width=91pc)

   - Tên: `bot-token5`
     ![secret2](/images/4-security/4.1-secret_manager/secret3.png?width=91pc)
   - Tạo thành công
     ![secret3](/images/4-security/4.1-secret_manager/secret3-.png?width=91pc)
   - Lưu **ARN**
     ![secret8](/images/4-security/4.1-secret_manager/secret4.png?width=91pc)

#### Lấy Signing Secret

4. Sao chép **Signing Secret** từ cài đặt Slack app:
   ![slack_secret](/images/4-security/4.1-secret_manager/secret5-.png?width=90pc)

#### Tạo Signing Secret

5. Tạo secret mới cho **signing-secret**:

   - Nhấp **Store a new secret**
   - Chọn **Other type of secret**
   - Nhập key-value pair: `SLACK_SIGNING_SECRET` = `giá-trị-signing-secret-của-bạn`

   ![secret4](/images/4-security/4.1-secret_manager/secret6-.png?width=90pc)

   - Tên: `signing-secret5`
   - Tạo thành công
     ![secret6](/images/4-security/4.1-secret_manager/secret6.png?width=90pc)
   - Lưu **ARN**
     ![secret7](/images/4-security/4.1-secret_manager/secret7-.png?width=90pc)

{{% notice tip %}}
**Mẹo:** Giữ tên secret nhất quán (`bot-token5` và `signing-secret5`) vì chúng sẽ được tham chiếu trong cấu hình Parameter Store.
{{% /notice %}}

#### Tiếp theo là gì

Slack credentials của bạn hiện đã được lưu trữ an toàn trong AWS Secrets Manager. Tiếp theo, chúng ta sẽ cấu hình Parameter Store để cho phép truy cập runtime đến các secrets này.

---

**Tiếp tục đến**: [4.2 Cấu hình Systems Manager Parameter Store](../4.2-systems_manager/)