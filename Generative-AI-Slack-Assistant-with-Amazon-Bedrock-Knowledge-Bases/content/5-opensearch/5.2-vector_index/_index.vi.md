---
title: "Tạo Vector Index"
date: "2025-06-30"
weight: 2
chapter: false
pre: " <b> 5.2 </b> "
---

Phần này hướng dẫn bạn tạo vector index trong OpenSearch Serverless sử dụng Postman để cho phép k-NN similarity searches cho trợ lý AI của bạn.

### Tạo IAM User

#### Tạo Deployment User

1. Tạo IAM user **bedrock-chatbot-deployer** với policy **AdministratorAccess**
   ![user1](/images/5-opensearch/5.2-vector_index/user1.png?width=90pc)

#### Tạo Access Keys

2. Tạo **Access Keys** cho programmatic access:

    - Lấy thông tin access key của user mới tạo

    ![userAccesskey](/images/5-opensearch/5.2-vector_index/user2.png?width=90pc)

    - Thêm **tag** với **Key** và **Value** như một **access key**

    ![user2](/images/5-opensearch/5.2-vector_index/user3.png?width=90pc)

{{% notice warning %}}
**Quan trọng:** Lưu Access Key ID và Secret Access Key một cách an toàn - chúng sẽ cần thiết cho Postman authentication.
{{% /notice %}}

### Cấu hình Postman Request

#### Thiết lập Authentication

1. Mở **Postman** và cấu hình request:

   - **Method**: PUT
   - **URL**: `<Opensearch-Endpoint>/slack-bedrock-os-index5`
   - **Auth Type**: AWS Signature
   - **Access Key**: IAM user access key của bạn
   - **Secret Key**: IAM user secret key của bạn
   - **Region**: us-east-1
   - **Service Name**: aoss

   ![postman1](/images/5-opensearch/5.2-vector_index/postman1.png?width=90pc)

#### Thiết lập Headers

2. Cấu hình request headers:
   - **Content-Type**: application/json
     
    ![postman2](/images/5-opensearch/5.2-vector_index/postman2.png?width=90pc)

#### Cấu hình Request Body

3. Đặt body type thành **raw** và nhập JSON sau:
   ![postman3](/images/5-opensearch/5.2-vector_index/postman3.png?width=90pc)

   ```json
   {
     "settings": {
       "index": {
         "knn": true,
         "knn.algo_param.ef_search": 512
       }
     },
     "mappings": {
       "properties": {
         "bedrock-knowledge-base-default-vector": {
           "type": "knn_vector",
           "dimension": 1024,
           "method": {
             "name": "hnsw",
             "engine": "faiss",
             "space_type": "l2",
             "parameters": {
               "ef_construction": 512,
               "m": 16
             }
           }
         },
         "AMAZON_BEDROCK_METADATA": {
           "type": "text",
           "index": false
         },
         "AMAZON_BEDROCK_TEXT_CHUNK": {
           "type": "text",
           "index": true
         },
         "id": {
           "type": "text",
           "index": true
         },
         "x-amz-bedrock-kb-data-source-id": {
           "type": "text",
           "index": true
         },
         "x-amz-bedrock-kb-document-page-number": {
           "type": "long",
           "index": true
         },
         "x-amz-bedrock-kb-source-uri": {
           "type": "text",
           "index": true
         }
       }
     }
   }
   ```

### Tạo Index

#### Gửi Request

4. Nhấp **Send** để tạo vector index
   - Phản hồi thành công cho biết index đã được tạo
     
    ![postman4](/images/5-opensearch/5.2-vector_index/postman4.png?width=90pc)

#### Xác minh Index Creation

5. Xác minh index đã được tạo thành công trong OpenSearch console:

   - **Index Name**: slack-bedrock-os-index5

    ![opensearch17](/images/5-opensearch/5.2-vector_index/opensearch17.png?width=90pc)

   - **Vector Field**: bedrock-knowledge-base-default-vector

    ![opensearch18](/images/5-opensearch/5.2-vector_index/opensearch18.png?width=90pc)

   - **Metadata Fields**: Có sẵn để tracking document

    ![opensearch19](/images/5-opensearch/5.2-vector_index/opensearch19.png?width=90pc)

{{% notice info %}}
**Lưu ý:** Vector index được cấu hình với 1024 dimensions để khớp với Amazon Titan Text Embeddings V2 model output và sử dụng thuật toán HNSW cho similarity search hiệu quả.
{{% /notice %}}

### Giải thích Index Configuration

#### Vector Settings

- **Dimension**: 1024 (khớp với Titan Embeddings V2)
- **Algorithm**: HNSW (Hierarchical Navigable Small World)
- **Engine**: FAISS (Facebook AI Similarity Search)
- **Space Type**: L2 (Euclidean distance)

#### Metadata Fields

- **AMAZON_BEDROCK_TEXT_CHUNK**: Document text có thể tìm kiếm
- **AMAZON_BEDROCK_METADATA**: Document metadata (không được index)
- **x-amz-bedrock-kb-source-uri**: Document source tracking
- **x-amz-bedrock-kb-document-page-number**: Page reference

#### Tiếp theo là gì

Vector index của bạn hiện đã sẵn sàng để lưu trữ và tìm kiếm document embeddings. Tiếp theo, chúng ta sẽ tạo Bedrock Knowledge Base sẽ sử dụng OpenSearch collection này.

---

**Tiếp tục đến**: [Thiết lập Bedrock](../../6-bedrock_setup/)
