---
title: "Dọn dẹp tài nguyên"
date: "2025-06-30"
weight: 9
chapter: false
pre: " <b> 9. </b> "
---

#### Dọn dẹp Resource

Module này hướng dẫn bạn dọn dẹp đúng cách tất cả AWS resources đã tạo trong workshop để tránh phí phát sinh. Tuân theo thứ tự xóa cẩn thận để ngăn chặn dependency errors.

{{% notice warning %}}
**Quan trọng:** Xóa các resources này là không thể hoàn tác. Đảm bảo bạn đã lưu bất kỳ dữ liệu hoặc cấu hình quan trọng nào trước khi tiến hành.
{{% /notice %}}

#### Thứ tự Cleanup

Tuân theo thứ tự cụ thể này để tránh dependency conflicts:

**Xóa API Gateway**

1. **Xóa API Gateway**:

   - Điều hướng đến API Gateway Console
   - Chọn `slack-bedrock-api5` của bạn
   - Nhấp **Actions** → **Delete API**
   - Xác nhận deletion

   ![test13](/images/9-clean_resources/clear13.png?width=90pc)

**Xóa Lambda Function**

2. **Xóa Lambda Function**:

   - Điều hướng đến Lambda Console
   - Chọn `BedrockKBSlackbotFunction5`
   - Nhấp **Actions** → **Delete**
   - Xác nhận deletion

   ![test12](/images/9-clean_resources/clear12.png?width=90pc)

**Xóa Bedrock Knowledge Base**

3. **Xóa Knowledge Base**:

   - Điều hướng đến S3 Console
   - **Đầu tiên**: Xóa tất cả objects trong bucket
   - **Sau đó**: Xóa chính bucket
   - Xác nhận deletion
     ![clear1](/images/9-clean_resources/clear1.png?width=90pc)
     ![clear2](/images/9-clean_resources/clear2.png?width=90pc)
   - Điều hướng đến Bedrock Console
   - Truy cập **Knowledge bases**
   - Chọn knowledge base của bạn
   - Nhấp **Delete**
   - Xác nhận deletion
     ![clear3](/images/9-clean_resources/clear3.png?width=90pc)

{{% notice info %}}
**Lưu ý:** Đợi Knowledge Base deletion hoàn thành trước khi tiến hành OpenSearch cleanup.
{{% /notice %}}

**Xóa OpenSearch Serverless Resources**

4. **Xóa OpenSearch Components** (theo thứ tự này):

   **a) Xóa Vector Index:**

   - Sử dụng Postman hoặc AWS CLI để xóa index
   - DELETE request đến: `https://your-collection-endpoint/slack-bedrock-os-index5`

   ![clear7](/images/9-clean_resources/clear4.png?width=90pc)

   **b) Xóa Collection:**

   - Điều hướng đến OpenSearch Console
   - Chọn **Collections**
   - Xóa `slack-bedrock-vector-db5`

   ![clear7](/images/9-clean_resources/clear5.png?width=90pc)

   **c) Xóa Data Access Policy:**

   - Truy cập **Data access policies**
   - Xóa access policy của bạn

   ![clear7](/images/9-clean_resources/clear6.png?width=90pc)

   **d) Xóa Network Policy:**

   - Truy cập **Network policies**
   - Xóa network policy của bạn

   ![clear7](/images/9-clean_resources/clear7.png?width=90pc)

**Xóa Security Resources**

5. **Xóa AWS Secrets Manager Secrets**:

   - Điều hướng đến Secrets Manager Console
   - Xóa `slack/bot-token5`
   - Xóa `slack/signing-secret5`
   - Xác nhận immediate deletion (bỏ qua recovery period)

   ![clear8](/images/9-clean_resources/clear8.png?width=90pc)
   ![clear9](/images/9-clean_resources/clear9.png?width=90pc)

6. **Xóa Systems Manager Parameters**:

   - Điều hướng đến Systems Manager Console
   - Truy cập **Parameter Store**
   - Xóa `/slack/bot-token5/parameter5`
   - Xóa `/slack/signing-secret5/parameter5`

   ![clear10](/images/9-clean_resources/clear10.png?width=90pc)
   ![clear11](/images/9-clean_resources/clear11.png?width=90pc)

**Dọn dẹp IAM Resources**

8. **Xóa IAM Role** (Tùy chọn):
   - Điều hướng đến IAM Console
   - Xóa `BedrockExecutionRole8888`
   - Xóa `bedrock-chatbot-deployer` user
   - Loại bỏ bất kỳ custom policies đã tạo

#### Xác minh Chi phí

Sau cleanup, xác minh không có phí phát sinh:

**Kiểm tra các Services này:**

- ✅ **Lambda**: Không còn functions nào
- ✅ **API Gateway**: Không còn APIs nào
- ✅ **OpenSearch Serverless**: Không còn collections hoặc policies
- ✅ **S3**: Không còn buckets với workshop data
- ✅ **Secrets Manager**: Không còn secrets nào
- ✅ **Bedrock**: Knowledge Base đã xóa (models vẫn enabled)

{{% notice tip %}}
**Mẹo:** Bedrock model access vẫn enabled nhưng không phát sinh phí trừ khi actively sử dụng. Bạn có thể để enabled cho các dự án tương lai.
{{% /notice %}}

#### Cleanup Checklist

Xác nhận tất cả resources đã được xóa:

- ✅ API Gateway đã xóa
- ✅ Lambda function đã xóa
- ✅ Bedrock Knowledge Base đã xóa
- ✅ OpenSearch collection và policies đã xóa
- ✅ Secrets Manager secrets đã xóa
- ✅ Parameter Store parameters đã xóa
- ✅ S3 bucket và contents đã xóa
- ✅ IAM roles và users đã xóa (tùy chọn)

#### Xác minh Cuối cùng

1. **Kiểm tra AWS Billing Dashboard**:

   - Xác minh không có unexpected charges
   - Giám sát trong 24-48 giờ sau cleanup

2. **Review CloudWatch Logs**:
   - Log groups có thể còn lại nhưng không phát sinh chi phí đáng kể
   - Xóa nếu muốn: `/aws/lambda/BedrockKBSlackbotFunction5`

#### Tóm tắt Workshop

Chúc mừng bạn đã hoàn thành workshop Generative AI Slack Assistant! Bạn đã thành công:

- ✅ Xây dựng AI assistant cấp enterprise
- ✅ Triển khai RAG architecture với Amazon Bedrock
- ✅ Cấu hình secure credential management
- ✅ Deploy serverless infrastructure
- ✅ Tích hợp với Slack cho real-world usage
- ✅ Dọn dẹp resources đúng cách

---

**Workshop Hoàn thành** - Tất cả resources đã được dọn dẹp thành công!
