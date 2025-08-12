---
title: "Lấy OAuth Tokens"
date: "2025-06-30"
weight: 3
chapter: false
pre: " <b> 3.3 </b> "
---

#### Cấu hình Bot Permissions

1. Điều hướng đến **OAuth & Permissions** trong cài đặt app của bạn
2. Cuộn xuống **Scopes** → **Bot Token Scopes** và thêm:
   - `commands` - Kích hoạt slash commands
   - `chat:write` - Gửi tin nhắn như bot
   - `channels:read` - Cấp cho bot quyền truy cập thông tin cơ bản của các kênh công khai trong Slack workspace
     
![slack_scope](/images/3-slack_app/3.3-Oauth_Permissions/slack_scope.png?width=90pc)

#### Cài đặt App vào Workspace

3. Cuộn lên và nhấp **Install to Workspace**

![getOAuth1](/images/3-slack_app/3.3-Oauth_Permissions/slack_OAuth0.png?width=90pc)

4. Xem lại quyền và nhấp **Allow**

![getOAuth](/images/3-slack_app/3.3-Oauth_Permissions/slack_OAuth1.png?width=90pc)

#### Sao chép OAuth Tokens

5. Sau khi cài đặt, bạn sẽ thấy **Bot User OAuth Token** (bắt đầu với `xoxb-`)

![getOAuth](/images/3-slack_app/3.3-Oauth_Permissions/getOAuth1.png?width=90pc)

6. **Sao chép và lưu token này một cách an toàn** - bạn sẽ cần nó cho cấu hình AWS Lambda

{{% notice warning %}}
**Quan trọng:** Giữ OAuth token an toàn và không bao giờ commit nó vào version control. Chúng ta sẽ lưu trữ nó trong AWS Secrets Manager sau.
{{% /notice %}}

### Tiếp theo là gì

Slack app của bạn hiện đã được cấu hình đầy đủ với các quyền và tokens cần thiết. Tiếp theo, chúng ta sẽ chuyển sang xây dựng cơ sở hạ tầng AWS sẽ cung cấp năng lượng cho trợ lý AI của bạn.

---

**Tiếp tục đến**: [4 - Cấu hình Bảo mật](../../4-security/)
