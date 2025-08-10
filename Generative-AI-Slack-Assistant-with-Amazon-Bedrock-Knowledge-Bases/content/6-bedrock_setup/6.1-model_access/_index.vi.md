---
title: "Thiết lập Model Access"
date: "`r Sys.Date()`"
weight: 1
chapter: false
pre: " <b> 6.1 </b> "
---

#### Kích hoạt Foundation Model Access

Phần này hướng dẫn bạn kích hoạt quyền truy cập đến các Amazon Bedrock foundation models cần thiết cho trợ lý AI của bạn.

#### Models Cần thiết

Cho workshop này, bạn cần quyền truy cập đến:

- **Amazon Titan Text Embeddings V2**: Cho document vectorization
- **Anthropic Claude 3 Sonnet**: Cho intelligent text generation

#### Truy cập Bedrock Console

1. Điều hướng đến [Amazon Bedrock Console](https://us-east-1.console.aws.amazon.com/bedrock/home?region=us-east-1#/overview)
   ![modelAccess0](/images/6/modelAccess0.png?width=90pc)

#### Điều hướng đến Model Access

2. Cuộn xuống cuối **navigation sidebar** và chọn **Model access**
   ![modelAccess1](/images/6/modelAccess10a.png?width=90pc)

#### Modify Model Access

3. Nhấp **Modify model access**
   ![modelAccess2](/images/6/modelAccess20b.png?width=90pc)

#### Chọn Models Cần thiết

4. Chọn các models cần thiết cho workshop này:

   - ✅ **Amazon Titan Text Embeddings V2**
   - ✅ **Anthropic Claude 3 Sonnet**

   ![modelAccess3](/images/6/modelAccess30a.png?width=90pc)
   ![modelAccess4](/images/6/modelAccess40a.png?width=90pc)

   - Nhấp **Next** để tiếp tục
     ![modelAccess5](/images/6/modelAccess50a.png?width=90pc)

#### Submit Access Request

5. Xem lại lựa chọn models và nhấp **Submit**

   - Access requests thường được phê duyệt ngay lập tức cho các models này
   - Đợi vài phút để quyền truy cập được cấp

   ![modelAccess6](/images/6/modelAccess60a.png?width=90pc)

#### Xác minh Model Access

6. Xác nhận cả hai models hiển thị trạng thái **Access granted**:

   - ✅ **Amazon Titan Text Embeddings V2**: Access granted
   - ✅ **Anthropic Claude 3 Sonnet**: Access granted

   ![modelAccess7](/images/6/modelAccess70a.png?width=90pc)
   ![modelAccess8](/images/6/modelAccess80a.png?width=90pc)

{{% notice tip %}}
**Mẹo:** Model access thường được cấp ngay lập tức cho Titan và Claude models. Nếu bạn gặp chậm trễ, đảm bảo AWS account của bạn ở trạng thái tốt.
{{% /notice %}}

#### Tiếp theo là gì

Với foundation model access được kích hoạt, bạn đã sẵn sàng tạo Knowledge Base sẽ cung cấp năng lượng cho phản hồi thông minh của trợ lý AI.

---

**Tiếp tục đến**: [6.2 Thiết lập Guardrails](../6.2-guardrails/)
