---
title: "Setup Knowledge Base"
date: "2025-06-30"
weight: 3
chapter: false
pre: " <b> 6.3 </b> "
---

#### Create Bedrock Knowledge Base

This section guides you through creating a Bedrock Knowledge Base with S3 data source and OpenSearch Serverless integration for your AI assistant.

#### S3 Configuration

#### Create S3 Bucket

1. Create a new S3 bucket for storing your documents:

- **Region**: us-east-1

  - Use default settings for other configurations

  ![s3_1](/images/6-bedrock_setup/6.3-knowledge_base/s3_1.png?width=90pc)

  - **Bucket name**: `bucket-bedrock-document868686`
    ![s3_2](/images/6-bedrock_setup/6.3-knowledge_base/s3_2.png?width=90pc)
  - Note **ARN**
    ![s3_3](/images/6-bedrock_setup/6.3-knowledge_base/s3-3.png?width=90pc)

{{% notice tip %}}
**Tip:** Use a unique bucket name by including your account ID to avoid naming conflicts.
{{% /notice %}}

#### Configure Knowledge Base

#### Access Bedrock Console

1. Navigate to [Amazon Bedrock Console](https://us-east-1.console.aws.amazon.com/bedrock/home?region=us-east-1#/overview)
   ![modelAccess0](/images/6-bedrock_setup/6.3-knowledge_base/modelAccess0.png?width=90pc)

#### Create Knowledge Base

2. Navigate to **Knowledge base** in the sidebar
   ![kb1](/images/6-bedrock_setup/6.3-knowledge_base/kb1.png?width=90pc)

3. Click **Create** → **Knowledge Base with vector store**
   ![kb2](/images/6-bedrock_setup/6.3-knowledge_base/kb2.png?width=90pc)

#### Configure Knowledge Base Settings

4. Set up the knowledge base configuration:

   **Basic Information:**

   - **Knowledge base name**: `slack-bedrock-kb5`
   - **IAM Role**: Create a new service role name `BedrockKnowledgeBaseRole5`
     ![kb3](/images/6-bedrock_setup/6.3-knowledge_base/kb3.png?width=90pc)

   **Data Source:**

   - **Data source type**: Amazon S3
     ![kb4](/images/6-bedrock_setup/6.3-knowledge_base/kb4.png?width=90pc)

   **S3 Configuration:**

   - Select your created S3 bucket
   - Use default chunking strategy
     ![kb5](/images/6-bedrock_setup/6.3-knowledge_base/kb5.png?width=90pc)
     ![kb6](/images/6-bedrock_setup/6.3-knowledge_base/kb6.png?width=90pc)

   **Embeddings Model:**

   - Select **Amazon Titan Text Embeddings V2**
     ![kb7](/images/6-bedrock_setup/6.3-knowledge_base/kb7.png?width=90pc)
     ![kb8](/images/6-bedrock_setup/6.3-knowledge_base/kb8.png?width=90pc)

   **Vector Store:**

   - Choose **Amazon OpenSearch Serverless**
     ![kb9](/images/6-bedrock_setup/6.3-knowledge_base/kb9.png?width=90pc)

   **OpenSearch Configuration:**

   - **Collection**: `slack-bedrock-vector-db5` (created in Module 5)
   - **Vector index name**: `slack-bedrock-os-index5`
   - **Vector field name**: `bedrock-knowledge-base-default-vector`
     ![kb10](/images/6-bedrock_setup/6.3-knowledge_base/kb10.png?width=90pc)
   - **Text field name**: `AMAZON_BEDROCK_TEXT_CHUNK`
   - **Metadata field name**:`AMAZON_BEDROCK_METADATA`
     ![kb11](/images/6-bedrock_setup/6.3-knowledge_base/kb11.png?width=90pc)

#### Complete Creation

5. Create and note the Knowledge Base ID:
   ![kb12](/images/6-bedrock_setup/6.3-knowledge_base/kb12.png?width=90pc)

6. Verify the automatically created IAM role has the necessary policies:
   ![kb13](/images/6-bedrock_setup/6.3-knowledge_base/kb13.png?width=90pc)

#### Upload and Sync Documents

#### Upload Sample Document

1. Upload a sample document to your S3 bucket:

   - Download: [PostgreSQL 16 Documentation](https://www.postgresql.org/files/documentation/pdf/16/postgresql-16-US.pdf)
   - Upload to your S3 bucket

   ![s3_4](/images/6-bedrock_setup/6.3-knowledge_base/s3-1.png?width=90pc)
   ![s3_5](/images/6-bedrock_setup/6.3-knowledge_base/s3-2.png?width=90pc)

#### Sync Knowledge Base

2. Sync the Knowledge Base to process the uploaded documents:

   - Go to your Knowledge Base **Data source**
   - Click **Sync** to start document processing
   - Wait for the sync to complete (may take several minutes)

   ![kb17](/images/6-bedrock_setup/6.3-knowledge_base/kb17.png?width=90pc)
   ![kb18](/images/6-bedrock_setup/6.3-knowledge_base/kb18.png?width=90pc)

{{% notice info %}}
**Note:** The sync process will chunk your documents, create embeddings using Titan V2, and store them in OpenSearch Serverless for semantic search.
{{% /notice %}}

#### What's Next

Your Bedrock Knowledge Base is now configured and ready to answer questions about your uploaded documents. Next, we'll create the Lambda function that will integrate this Knowledge Base with your Slack bot.

---

**Continue to**: [7 Lambda Implementation](../../7-lambda_implementation/)
