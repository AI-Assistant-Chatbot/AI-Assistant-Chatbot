---
title: "Thiết lập Guardrails"
date: "2025-06-30"
weight: 2
chapter: false
pre: " <b> 6.2 </b> "
---

#### Tổng quan Amazon Bedrock Guardrails

Amazon Bedrock Guardrails giúp bạn triển khai các biện pháp bảo vệ cho ứng dụng generative AI bằng cách lọc nội dung có hại, chặn các chủ đề không mong muốn và loại bỏ thông tin nhạy cảm. Điều này đảm bảo trợ lý Slack AI của bạn cung cấp phản hồi an toàn và phù hợp.

#### Điều kiện tiên quyết

Trước khi thiết lập guardrails, đảm bảo bạn có:

- ✅ Quyền truy cập Amazon Bedrock console
- ✅ IAM permissions phù hợp cho Bedrock Guardrails
- ✅ Hiểu biết về yêu cầu lọc nội dung của bạn

---

#### Truy cập Bedrock Guardrails Console

**1. Điều hướng đến Amazon Bedrock**

- Truy cập [Amazon Bedrock Console](https://console.aws.amazon.com/bedrock/)
- Đảm bảo bạn đang ở region **us-east-1**
- Nhấp **Guardrails** trong left navigation panel
- Nhấp nút **Create guardrail**
- Điều này sẽ bắt đầu guardrail configuration wizard

![guardrail1](/images/6-bedrock_setup/6.2-guardrails/guardrail1.png?width=90pc)

**2. Tạo Guardrail Mới**

- **Name**: `slack-ai-assistant-guardrail`
- **Description**: `Guardrail for Slack AI Assistant to filter harmful content and protect sensitive information`

![guardrail2](/images/6-bedrock_setup/6.2-guardrails/guardrail2.png?width=90pc)

---

#### Cấu hình Content Filters

**1. Thiết lập Harmful Content Filters**

Cấu hình filters cho các loại nội dung có hại khác nhau:

- **Hate Speech**: `High` - Chặn nội dung thúc đẩy thù hận
- **Insults**: `Medium` - Lọc ngôn ngữ xúc phạm
- **Sexual Content**: `High` - Chặn nội dung tình dục không phù hợp
- **Violence**: `High` - Lọc nội dung bạo lực
- **Misconduct**: `Medium` - Chặn nội dung hành vi phi đạo đức

![guardrail3](/images/6-bedrock_setup/6.2-guardrails/guardrail3.png?width=90pc)

---

**2. Thiết lập Prompt Attacks**

- **Prompt Attacks**: `High` - Ngăn chặn prompt injection attacks
  
![guardrail4](/images/6-bedrock_setup/6.2-guardrails/guardrail4.png?width=90pc)

---

#### Cấu hình Word Filters (Tùy chọn)

**1. Thiết lập Profanity Filters**

Thêm các từ hoặc cụm từ cụ thể để chặn:

- **Profanity Filter**: Kích hoạt để chặn profanity phổ biến
- **Custom Words**: Thêm các thuật ngữ cụ thể của công ty để tránh
- **Sensitive Terms**: Chặn tên mã nội bộ hoặc thuật ngữ bí mật

![guardrail5](/images/6-bedrock_setup/6.2-guardrails/guardrail5.png?width=90pc)

![guardrail6](/images/6-bedrock_setup/6.2-guardrails/guardrail6.png?width=90pc)

---

- Lưu **ARN** và **ID**

![guardrail7](/images/6-bedrock_setup/6.2-guardrails/guardrail7.png?width=90pc)

---

#### Khắc phục Sự cố Thường gặp

**1. Guardrail Creation Fails**

- **Vấn đề**: Permission denied
- **Giải pháp**: Xác minh IAM permissions cho Bedrock Guardrails

**2. Over-filtering Legitimate Content**

- **Vấn đề**: Quá nhiều false positives
- **Giải pháp**: Điều chỉnh filter levels từ High xuống Medium

**3. PII Not Being Detected**

- **Vấn đề**: Dữ liệu nhạy cảm đi qua
- **Giải pháp**: Kích hoạt thêm PII types hoặc sử dụng custom regex patterns

{{% notice tip %}}
**Best Practice:** Bắt đầu với moderate filtering levels và điều chỉnh dựa trên nhu cầu tổ chức và phản hồi người dùng.
{{% /notice %}}

---

#### Các bước tiếp theo

Với guardrail được cấu hình, bạn đã sẵn sàng tích hợp nó với Knowledge Base.

**Tiếp tục đến**: [6.3 Thiết lập Knowledge Base](../6.3-knowledge_base/)

---

#### Tóm tắt

Trong phần này, bạn đã:

- ✅ Tạo Amazon Bedrock Guardrail
- ✅ Cấu hình content filters cho harmful content
- ✅ Thiết lập PII protection cho thông tin nhạy cảm
- ✅ Kiểm thử guardrail functionality
- ✅ Chuẩn bị cho Lambda integration

Trợ lý AI của bạn hiện có các biện pháp an toàn mạnh mẽ để đảm bảo phản hồi phù hợp và an toàn trong Slack workspace của bạn!
