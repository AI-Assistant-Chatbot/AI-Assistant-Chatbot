---
title: "Tạo slash commands"
date: "`r Sys.Date()`"
weight: 2
chapter: false
pre: " <b> 3.2 </b> "
---

#### Điều hướng đến Slash Commands

1. Trong cài đặt app của bạn, nhấp **Slash Commands** → **Create New Command**

![slackCommand1](/images/3/slashCommand1.png?width=90pc)

#### Cấu hình Chi tiết Command

2. Điền cấu hình command:

   - **Command**: `/ask-ai`
   - **Request URL**: `https://www.google.com/` (tạm thời)
   - **Short Description**:`test bedrock`
   - **Usage Hint**: `[câu hỏi của bạn về AWS]`

![slackCommand2](/images/3/slashCommand2.png?width=90pc)

{{% notice info %}}
**Lưu ý:** Request URL là tạm thời. Chúng ta sẽ cập nhật nó với URL API Gateway thực tế sau khi triển khai cơ sở hạ tầng AWS.
{{% /notice %}}

#### Lưu Command

3. Nhấp **Save** để tạo slash command thành công

![slackCommand3](/images/3/slashCommand3.png?width=90pc)

#### Tiếp theo là gì

Slash command của bạn đã được cấu hình! Tiếp theo, chúng ta sẽ thiết lập các quyền OAuth cần thiết để bot hoạt động đúng cách.

---

**Tiếp tục đến**: [3.3 - Lấy OAuth Tokens](../3.3-slash_commands/)