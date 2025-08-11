---
title: "OpenSearch Serverless Collection"
date: "2025-06-30"
weight: 1
chapter: false
pre: " <b> 5.1 </b> "
---

#### Tạo OpenSearch Serverless Collection

Phần này hướng dẫn bạn tạo OpenSearch Serverless collection để lưu trữ vector, bao gồm các access và network policies cần thiết.

#### Truy cập OpenSearch Console

1. Điều hướng đến [Amazon OpenSearch Service Console](https://us-east-1.console.aws.amazon.com/aos/home?region=us-east-1#opensearch)
   ![opensearch1](/images/5-opensearch/5.1-collection/opensearch1.png?width=90pc)

#### Tạo Data Access Policy

2. Cuộn xuống và chọn **Data access policies** → **Create access policy**
   ![opensearch8](/images/5-opensearch/5.1-collection/opensearch8.png?width=90pc)

3. Nhập **Access policy name** → Chọn **JSON**
   ![opensearch9](/images/5-opensearch/5.1-collection/opensearch9.png?width=90pc)

4. Nhập JSON policy sau và nhấp **Create**:
   ```json
   [
     {
       "Rules": [
         {
           "ResourceType": "index",
           "Resource": ["index/slack-bedrock-vector-db/*"],
           "Permission": ["aoss:*"]
         },
         {
           "ResourceType": "collection",
           "Resource": ["collection/slack-bedrock-vector-db"],
           "Permission": ["aoss:*"]
         }
       ],
       "Principal": ["arn:aws:iam::<YOUR-ACCOUNT-ID>:root"]
     }
   ]
   ```
   ![opensearch10](/images/5-opensearch/5.1-collection/opensearch10.png?width=90pc)

{{% notice warning %}}
**Quan trọng:** Thay thế `<YOUR-ACCOUNT-ID>` bằng AWS account ID thực tế của bạn.
{{% /notice %}}

#### Tạo Network Policy

5. Tạo **Network policy** → **Create network policy**
   ![opensearch11](/images/5-opensearch/5.1-collection/opensearch11.png?width=90pc)

6. Nhập **Network policy name** -> chọn **JSON**
   ![opensearch12](/images/5-opensearch/5.1-collection/opensearch12.png?width=90pc)

7. Nhập JSON policy sau và nhấp **Create**:
   ```json
   [
     {
       "Rules": [
         {
           "ResourceType": "collection",
           "Resource": ["collection/slack-bedrock-vector-db"]
         },
         {
           "ResourceType": "dashboard",
           "Resource": ["collection/slack-bedrock-vector-db"]
         }
       ],
       "AllowFromPublic": true
     }
   ]
   ```
   ![opensearch13](/images/5-opensearch/5.1-collection/opensearch13.png?width=90pc)

#### Tạo Vector Collection

8. **Tạo collection**:

   - Chọn **Collections**
     ![opensearch2](/images/5-opensearch/5.1-collection/opensearch2.png?width=90pc)

   - Chọn **Create Collection**
     ![opensearch3](/images/5-opensearch/5.1-collection/opensearch3.png?width=90pc)

   - Cấu hình collection settings:

     - **Collection name**: `slack-bedrock-vector-db5`
     - **Collection type**: Vector search
       ![opensearch4](/images/5-opensearch/5.1-collection/opensearch4.png?width=90pc)
     - **Security**: Standard create
       ![opensearch5](/images/5-opensearch/5.1-collection/opensearch5.png?width=90pc)

   - Sử dụng cài đặt mặc định và nhấp **Create**

#### Ghi chú Thông tin Quan trọng

9. **Lưu các chi tiết sau** cho cấu hình sau này:

   - **Collection ARN**: `arn:aws:aoss:us-east-1:account:collection/collection-id`
   - **OpenSearch Endpoint**: `https://collection-id.us-east-1.aoss.amazonaws.com`

   ![opensearch14](/images/5-opensearch/5.1-collection/opensearch14.png?width=90pc)
   ![opensearch15](/images/5-opensearch/5.1-collection/opensearch15.png?width=90pc)

   - Bước tiếp theo là tạo index table.
     ![opensearch16](/images/5-opensearch/5.1-collection/opensearch16.png?width=90pc)

{{% notice tip %}}
**Mẹo:** Sao chép và lưu Collection ARN và OpenSearch Endpoint vì chúng sẽ cần thiết cho cấu hình Bedrock Knowledge Base.
{{% /notice %}}

#### Tiếp theo là gì

OpenSearch Serverless collection của bạn hiện đã sẵn sàng để lưu trữ vector embeddings. Tiếp theo, chúng ta sẽ tạo vector index để tìm kiếm similarity hiệu quả.

---

**Tiếp tục đến**: [5.2 - Tạo Vector Index](../5.2-vector_index/)
