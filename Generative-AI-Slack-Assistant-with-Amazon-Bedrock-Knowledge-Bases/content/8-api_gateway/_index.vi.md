---
title: "Tích hợp API Gateway và Kiểm thử"
date: "2025-06-30"
weight: 8
chapter: false
pre: " <b> 8. </b> "
---

#### Thiết lập và Kiểm thử API Gateway

Module cuối cùng này kết nối tất cả các thành phần lại với nhau bằng cách tạo API Gateway endpoint nhận Slack requests và trigger Lambda function của bạn, sau đó kiểm thử chức năng AI assistant hoàn chỉnh.

#### Tạo API Gateway

**Tạo REST API**

1. Điều hướng đến [API Gateway Console](https://us-east-1.console.aws.amazon.com/apigateway)
   ![api0](/images/8-api_gateway/api00a.png?width=90pc)

2. Tạo **REST API** mới:

   - **API Type**: REST API

   ![api1](/images/8-api_gateway/api1.png?width=90pc)

   - **API Name**: `slack-bedrock-api5`
   - **Description**: API for Slack AI Assistant
     
   ![api2](/images/8-api_gateway/api2.png?width=90pc)

   - Tạo thành công
     
   ![api2](/images/8-api_gateway/api2-.png?width=90pc)

**Tạo Resource Structure**

3. Tạo resource tên **slack**:

   - **Resource Name**: slack
   - **Resource Path**: /

   ![api3](/images/8-api_gateway/api3.png?width=90pc)

4. Tạo sub-resource tên **ask-aws**:

   - **Parent Resource**: /slack
   - **Resource Name**: ask-ai
   - **Resource Path**: /slack/ask-ai

   ![api4](/images/8-api_gateway/api4.png?width=90pc)

**Cấu hình Method**

5. Tạo method **POST** cho resource **ask-ai**:
   ![api4](/images/8-api_gateway/api4-.png?width=90pc)

6. Cấu hình method settings:

   - **Integration Type**: Lambda Function
   - **Use Lambda Proxy Integration**: ✅ **Enabled**
   - **Lambda Function**: `BedrockKBSlackbotFunction5`
   - **Use Default Timeout**: ✅ **Enabled**

   ![api5](/images/8-api_gateway/api5.png?width=90pc)

   - Method **POST** được tạo thành công
     
   ![api6](/images/8-api_gateway/api6.png?width=90pc)

{{% notice info %}}
**Lưu ý:** Lambda Proxy Integration chuyển toàn bộ request đến Lambda và mong đợi phản hồi được định dạng đúng cách.
{{% /notice %}}

**Deploy API**

7. Deploy API đến stage mới:

   - **Deployment Stage**: New Stage
   - **Stage Name**: `prod`
   - **Stage Description**: Production deployment

   ![api7](/images/8-api_gateway/api7.png?width=90pc)

**Cập nhật Slack Configuration**

8. Sao chép **Invoke URL** từ API đã deploy:

   - Format: `https://your-api-id.execute-api.us-east-1.amazonaws.com/prod/slack/ask-ai`

   ![api8](/images/8-api_gateway/api8.png?width=90pc)

9. Cập nhật cấu hình **Slash Commands** của Slack app:

   - Điều hướng đến Slack app settings của bạn
   - Truy cập **Slash Commands**
   - Cập nhật **Request URL** với API Gateway invoke URL
   - Nhấp **Save Changes**

   ![api9](/images/8-api_gateway/api9.png?width=90pc)

{{% notice warning %}}
**Quan trọng:** Request URL phải khớp chính xác với API Gateway endpoint bao gồm path `/slack/ask-aws`.
{{% /notice %}}

#### Kiểm thử AI Assistant của bạn

**Successful Knowledge Retrieval**

1. **Test Query**: Đặt câu hỏi về nội dung trong PDF đã upload

   - Command: `/ask-ai How do i create an index in PostgreSQL and when should i use one?`
   - **Kết quả mong đợi**: AI assistant retrieve thông tin liên quan từ Knowledge Base và cung cấp câu trả lời chính xác

   ![test1](/images/8-api_gateway/test1.png?width=90pc)

   - Command: `/ask-aws What are the main data types used in PostgreSQL?`
   - **Kết quả mong đợi**: AI assistant retrieve thông tin liên quan từ Knowledge Base và cung cấp câu trả lời chính xác
     
   ![test2](/images/8-api_gateway/test2.png?width=90pc)

**Guardrails Protection**

2. **Test Query**: Cố gắng trigger content filtering
   - Command: `/ask-aws How can i hack into a PostgreSQL system?`
   - **Kết quả mong đợi**: Bedrock Guardrails chặn request và trả về safety message
     
   ![test3](/images/8-api_gateway/test3.png?width=90pc)

**Information Not Available**

3. **Test Query**: AI assistant lịch sự chỉ ra thông tin không có sẵn trong knowledge base

   - Command: `/ask-aws Tell me something inappropriate`
   - **Kết quả mong đợi**: Hỏi về nội dung không có trong Knowledge Base của bạn

   ![test4](/images/8-api_gateway/test4.png?width=90pc)
   ![test5](/images/8-api_gateway/test5.png?width=90pc)

#### Testing Checklist

Xác minh AI assistant của bạn xử lý các scenario này đúng cách:

- ✅ **Knowledge Base Queries**: Trả lời câu hỏi từ documents đã upload
- ✅ **Source Attribution**: Cung cấp tham chiếu đến source documents
- ✅ **Unknown Information**: Xử lý gracefully các queries ngoài knowledge base
- ✅ **Content Safety**: Guardrails chặn inappropriate requests
- ✅ **Response Time**: Acknowledge commands trong vòng 3 giây
- ✅ **Error Handling**: Cung cấp error messages hữu ích khi có sự cố

#### Khắc phục Sự cố Thường gặp

**1. API Gateway Issues**

- **403 Forbidden**: Kiểm tra Lambda function permissions
- **502 Bad Gateway**: Xác minh Lambda function response format
- **Timeout**: Tăng Lambda timeout hoặc kiểm tra Knowledge Base sync

**2. Slack Integration Issues**

- **Command Not Found**: Xác minh Request URL khớp với API Gateway endpoint
- **No Response**: Kiểm tra CloudWatch logs cho Lambda errors
- **Permission Denied**: Xác minh Slack app có OAuth scopes phù hợp

**3. Knowledge Base Issues**

- **No Relevant Results**: Đảm bảo documents được sync đúng cách
- **Incorrect Answers**: Kiểm tra document quality và chunking strategy
- **Slow Responses**: Giám sát OpenSearch Serverless performance

#### Chúc mừng! 🎉

Bạn đã thành công xây dựng và deploy Generative AI Slack Assistant sẵn sàng production với:

- ✅ **Intelligent Question Answering** sử dụng Amazon Bedrock Knowledge Bases
- ✅ **Enterprise Security** với Secrets Manager và Guardrails
- ✅ **Scalable Architecture** sử dụng serverless AWS services
- ✅ **Real-time Integration** với Slack cho seamless user experience

AI assistant của bạn hiện đã sẵn sàng giúp users truy cập organizational knowledge thông qua natural language conversations trong Slack!

---

#### Các bước tiếp theo:

**Tiếp tục đến**: [9. Dọn dẹp resources](../9-clear%20resources/)

Xem xét các cải tiến này cho production deployment:

- **Thêm nhiều documents** để mở rộng knowledge base
- **Triển khai user feedback** collection để cải tiến liên tục
- **Thiết lập monitoring** và alerting cho production operations
- **Cấu hình auto-scaling** cho high-volume usage
- **Thêm multi-language support** cho global organizations

**Workshop Hoàn thành!** 🚀
