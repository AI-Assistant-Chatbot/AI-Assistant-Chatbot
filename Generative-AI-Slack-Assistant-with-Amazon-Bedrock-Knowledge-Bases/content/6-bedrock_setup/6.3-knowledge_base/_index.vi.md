---
title: "Thiết lập knowledge base"
date: "2025-06-30"
weight: 3
chapter: false
pre: " <b> 6.3 </b> "
---

#### Tạo Bedrock Knowledge Base

Phần này hướng dẫn bạn tạo Bedrock Knowledge Base với S3 data source và tích hợp OpenSearch Serverless cho trợ lý AI của bạn.

#### Cấu hình S3

#### Tạo S3 Bucket

**Tạo S3 bucket mới để lưu trữ documents của bạn:**

- **Region**: us-east-1

- Sử dụng cài đặt mặc định cho các cấu hình khác
    ![s3_1](/images/6-bedrock_setup/6.3-knowledge_base/s3_1.png?width=90pc)
  
- **Bucket name**: `bucket-bedrock-document868686`
    ![s3_2](/images/6-bedrock_setup/6.3-knowledge_base/s3_2.png?width=90pc)
  
- Ghi chú **ARN**
    ![s3_3](/images/6-bedrock_setup/6.3-knowledge_base/s3-3.png?width=90pc)

{{% notice tip %}}
**Mẹo:** Sử dụng tên bucket duy nhất bằng cách bao gồm account ID của bạn để tránh xung đột tên.
{{% /notice %}}

#### Cấu hình Knowledge Base

#### Truy cập Bedrock Console

1. Điều hướng đến [Amazon Bedrock Console](https://us-east-1.console.aws.amazon.com/bedrock/home?region=us-east-1#/overview)
   ![modelAccess0](/images/6-bedrock_setup/6.3-knowledge_base/modelAccess0.png?width=90pc)

#### Tạo Knowledge Base

2. Điều hướng đến **Knowledge base** trong sidebar
   ![kb1](/images/6-bedrock_setup/6.3-knowledge_base/kb1.png?width=90pc)

3. Nhấp **Create** → **Knowledge Base with vector store**
   ![kb2](/images/6-bedrock_setup/6.3-knowledge_base/kb2.png?width=90pc)

#### Cấu hình Knowledge Base Settings

4. Thiết lập cấu hình knowledge base:

   **Thông tin Cơ bản:**

   - **Knowledge base name**: `slack-bedrock-kb5`
   - **IAM Role**: Tạo service role mới tên `BedrockKnowledgeBaseRole5`
     ![kb3](/images/6-bedrock_setup/6.3-knowledge_base/kb3.png?width=90pc)

   **Data Source:**

   - **Data source type**: Amazon S3
     ![kb4](/images/6-bedrock_setup/6.3-knowledge_base/kb4.png?width=90pc)

   **Cấu hình S3:**

   - Chọn S3 bucket đã tạo của bạn
   - Sử dụng chunking strategy mặc định
     ![kb5](/images/6-bedrock_setup/6.3-knowledge_base/kb5.png?width=90pc)
     ![kb6](/images/6-bedrock_setup/6.3-knowledge_base/kb6.png?width=90pc)

   **Embeddings Model:**

   - Chọn **Amazon Titan Text Embeddings V2**
     ![kb7](/images/6-bedrock_setup/6.3-knowledge_base/kb7.png?width=90pc)
     ![kb8](/images/6-bedrock_setup/6.3-knowledge_base/kb8.png?width=90pc)

   **Vector Store:**

   - Chọn **Amazon OpenSearch Serverless**
     ![kb9](/images/6-bedrock_setup/6.3-knowledge_base/kb9.png?width=90pc)

   **Cấu hình OpenSearch:**

   - **Collection**: `slack-bedrock-vector-db5` (đã tạo trong Module 5)
   - **Vector index name**: `slack-bedrock-os-index5`
   - **Vector field name**: `bedrock-knowledge-base-default-vector`
     ![kb10](/images/6-bedrock_setup/6.3-knowledge_base/kb10.png?width=90pc)
   - **Text field name**: `AMAZON_BEDROCK_TEXT_CHUNK`
   - **Metadata field name**:`AMAZON_BEDROCK_METADATA`
     ![kb11](/images/6-bedrock_setup/6.3-knowledge_base/kb11.png?width=90pc)

#### Hoàn thành Creation

5. Tạo và ghi chú Knowledge Base ID:
   ![kb12](/images/6-bedrock_setup/6.3-knowledge_base/kb12.png?width=90pc)

6. Xác minh IAM role được tạo tự động có các policies cần thiết:
   ![kb13](/images/6-bedrock_setup/6.3-knowledge_base/kb13.png?width=90pc)

#### Upload và Sync Documents

#### Upload Sample Document

1. Upload sample document vào S3 bucket của bạn:

   - Tải xuống: [PostgreSQL 16 Documentation](https://www.postgresql.org/files/documentation/pdf/16/postgresql-16-US.pdf)
   - Upload vào S3 bucket của bạn

   ![s3_4](/images/6-bedrock_setup/6.3-knowledge_base/s3-1.png?width=90pc)
   ![s3_5](/images/6-bedrock_setup/6.3-knowledge_base/s3-2.png?width=90pc)

#### Sync Knowledge Base

2. Sync Knowledge Base để xử lý documents đã upload:

   - Truy cập Knowledge Base **Data source** của bạn
   - Nhấp **Sync** để bắt đầu document processing
   - Đợi sync hoàn thành (có thể mất vài phút)

   ![kb17](/images/6-bedrock_setup/6.3-knowledge_base/kb17.png?width=90pc)
   ![kb18](/images/6-bedrock_setup/6.3-knowledge_base/kb18.png?width=90pc)

{{% notice info %}}
**Lưu ý:** Quy trình sync sẽ chunk documents của bạn, tạo embeddings sử dụng Titan V2, và lưu trữ chúng trong OpenSearch Serverless cho semantic search.
{{% /notice %}}

#### Tiếp theo là gì

Bedrock Knowledge Base của bạn hiện đã được cấu hình và sẵn sàng trả lời câu hỏi về documents đã upload. Tiếp theo, chúng ta sẽ tạo Lambda function sẽ tích hợp Knowledge Base này với Slack bot của bạn.

---

**Tiếp tục đến**: [7 Triển khai Lambda](../../7-lambda_implementation/)
