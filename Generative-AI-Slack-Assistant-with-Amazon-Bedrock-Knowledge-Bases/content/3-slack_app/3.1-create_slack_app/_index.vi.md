---
title: "Tạo slack app"
date: "`r Sys.Date()`"
weight: 1
chapter: false
pre: " <b> 3.1 </b> "
---

#### Điều hướng đến Slack API

1. Truy cập [api.slack.com/apps](https://api.slack.com/apps) và nhấp **Create New App** → **From scratch**

![slackApp1](/images/3/slakcApp1.png?width=90pc)

#### Cấu hình Chi tiết App

2. Điền thông tin app:

- **App Name**: `AWS AI Assistant`
- **Pick a workspace**: Chọn workspace workshop của bạn
- Nhấp **Create App**

![slackApp2](/images/3/slakcApp2.png?width=90pc)

{{% notice tip %}}
**Mẹo:** Sử dụng tên mô tả như "AWS AI Assistant" để dễ dàng nhận diện bot trong workspace.
{{% /notice %}}

#### Tiếp theo là gì

Slack app của bạn đã được tạo! Trong phần tiếp theo, chúng ta sẽ cấu hình các quyền và cài đặt cần thiết để kích hoạt chức năng bot.

---

**Tiếp tục đến**: [3.2 Cấu hình App Permissions](../3.2-OAuth&Permissions/)
