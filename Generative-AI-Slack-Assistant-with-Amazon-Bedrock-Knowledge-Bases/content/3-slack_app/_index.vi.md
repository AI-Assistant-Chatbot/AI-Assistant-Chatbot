---
title: "Thiết lập Slack App"
date: "`r Sys.Date()`"
weight: 3
chapter: false
pre: " <b> 3. </b> "
---

#### Tổng quan

Slack app mở rộng chức năng của Slack bằng cách thêm các tính năng mới, tự động hóa tác vụ và tích hợp với các dịch vụ bên ngoài. Đối với trợ lý AI của chúng ta, Slack app đóng vai trò là giao diện giữa người dùng và knowledge base được hỗ trợ bởi Amazon Bedrock, cho phép truy vấn ngôn ngữ tự nhiên thông qua slash commands.

#### Những gì bạn sẽ hoàn thành

Trong module này, bạn sẽ:

- Tạo Slack app mới trong workspace của bạn
- Cấu hình OAuth permissions và slash commands
- Tạo authentication tokens cho tích hợp AWS
- Kiểm thử cài đặt app cơ bản

#### Các thành phần chính

**1. Cấu hình Slack App**

- **Tên App**: AWS AI Assistant
- **Slash Command**: `/ask-ai`
- **Quyền cần thiết**: `commands`, `chat:write`, `channels:read`

**2. Thông tin đăng nhập Authentication**

- **Bot Token**: Cho giao tiếp API (bắt đầu với `xoxb-`)
- **Signing Secret**: Cho xác minh request
- **Request URL**: Sẽ kết nối với AWS API Gateway

#### Kết quả mong đợi

Kết thúc module này, bạn sẽ có một Slack app được cấu hình sẵn sàng kết nối với cơ sở hạ tầng backend AWS mà chúng ta sẽ xây dựng trong các module tiếp theo. Slash command sẽ hiển thị trong workspace của bạn nhưng sẽ không hoạt động cho đến khi chúng ta triển khai giải pháp hoàn chỉnh.

---

**Tiếp tục đến**:

- [3.1 Tạo slack app](../3-slack_app/3.1-create_slackapp)
- [3.2 Tạo slash commands](../3-slack_app/3.2-OAuth&Permissions)
- [3.3 Lấy OAuth Tokens](../3-slack_app/3.3-slash_commands)
