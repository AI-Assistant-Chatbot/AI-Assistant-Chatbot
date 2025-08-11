---
title: "Thiết lập Môi trường"
date: "2025-06-30"
weight: 2
chapter: false
pre: " <b> 2. </b> "
---

#### Tổng quan Thiết lập Môi trường

Trước khi xây dựng Trợ lý Slack AI Tạo sinh của bạn, bạn cần thiết lập các môi trường và công cụ cần thiết. Module này sẽ hướng dẫn bạn tạo Slack workspace, cấu hình dịch vụ AWS và chuẩn bị môi trường phát triển.

#### Danh sách kiểm tra Điều kiện tiên quyết

Đảm bảo bạn có những điều sau trước khi tiếp tục:

- ✅ **AWS Account** với quyền truy cập quản trị
- ✅ **Địa chỉ email** để tạo Slack workspace
- ✅ **Python 3.12+** được cài đặt trên máy local
- ✅ **AWS CLI** được cài đặt và cấu hình
- ✅ **Code editor** (khuyến nghị VS Code)

#### Mục tiêu học tập Module

Kết thúc module này, bạn sẽ có:

1. **Tạo Slack workspace** để kiểm thử bot
2. **Cấu hình AWS CLI** với thông tin đăng nhập phù hợp
3. **Kích hoạt Amazon Bedrock models** trong AWS account
4. **Thiết lập môi trường phát triển** với các dependencies cần thiết
5. **Xác minh tất cả điều kiện tiên quyết** cho workshop

---

#### Tạo Slack Workspace

**1. Điều hướng đến Slack**

- Truy cập [Slack.com](https://slack.com/) và nhấp **Create a new workspace**.

  ![slackWorkSpace1](/images/2-environment-setup/slackWorkSpace1.png?width=90pc)

**2. Quy trình Đăng ký**

- **Nhập email để đăng nhập**

![slackWorkSpace2](/images/2-environment-setup/slackWorkSpace2.png?width=90pc)

**3. Nhấp Create a Workspace**
![slackWorkSpace3](/images/2-environment-setup/slackWorkSpace3.png?width=90pc)

#### Hoàn thành Thiết lập Workspace

**1. Hoàn thành quy trình tạo workspace bằng cách cung cấp:**

- **Tên workspace** (ví dụ: "AI-Assistant-Workshop")
- **Tên channel** (ví dụ: "#ai-assistant")
- **Lời mời thành viên nhóm** (tùy chọn cho workshop)

![slackWorkSpace4](/images/2-environment-setup/slackWorkSpace4.png?width=90pc)

{{% notice tip %}}
**Mẹo:** Giữ tên workspace đơn giản và liên quan đến workshop. Bạn sẽ sử dụng workspace này để kiểm thử trợ lý AI.
{{% /notice %}}

---

#### Cấu hình AWS Account

**1. Xác minh Quyền truy cập AWS Account**

**Đăng nhập AWS Console**

- Điều hướng đến [AWS Console](https://console.aws.amazon.com/)
- Đảm bảo bạn có quyền truy cập quản trị hoặc các quyền sau:
  - Amazon Bedrock full access
  - Lambda full access
  - API Gateway full access
  - S3 full access
  - OpenSearch Serverless access

**2. Cấu hình AWS CLI**

**Cài đặt AWS CLI** (nếu chưa cài đặt)

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

**3. Cấu hình AWS credentials**

```bash
aws configure
```

Nhập những thông tin sau khi được nhắc:

- **AWS Access Key ID**: Access key của bạn
- **AWS Secret Access Key**: Secret key của bạn
- **Default region name**: `us-east-1` (khuyến nghị cho Bedrock)
- **Default output format**: `json`

**4. Xác minh cấu hình**

```bash
aws sts get-caller-identity
```

{{% notice warning %}}
**Quan trọng:** Sử dụng region `us-east-1` cho workshop này vì nó có khả năng model tốt nhất cho Amazon Bedrock.
{{% /notice %}}

---

#### Khắc phục Sự cố Thường gặp

**Sự cố AWS CLI**

- **Vấn đề**: `aws: command not found`
- **Giải pháp**: Khởi động lại terminal sau khi cài đặt hoặc thêm AWS CLI vào PATH

{{% notice tip %}}
**Cần Trợ giúp?** Nếu bạn gặp sự cố, kiểm tra [Hướng dẫn Khắc phục Sự cố](https://docs.aws.amazon.com/cli/v1/userguide/cli-chap-troubleshooting.html) hoặc hỏi người hướng dẫn workshop.
{{% /notice %}}

---

#### Các bước tiếp theo

Với môi trường được cấu hình đúng cách, bạn đã sẵn sàng bắt đầu xây dựng nền tảng knowledge base cho trợ lý AI.

**Tiếp tục đến**: [Thiết lập Slack App](../3-slack_app/)

---

#### Tóm tắt

Trong module này, bạn đã:

- ✅ Tạo Slack workspace để kiểm thử
- ✅ Cấu hình AWS CLI và xác minh quyền truy cập

Môi trường phát triển của bạn hiện đã sẵn sàng để xây dựng Trợ lý Slack AI Tạo sinh!
