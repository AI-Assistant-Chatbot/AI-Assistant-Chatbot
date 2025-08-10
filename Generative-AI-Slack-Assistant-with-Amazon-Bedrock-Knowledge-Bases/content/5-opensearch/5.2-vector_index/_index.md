+++
title = "Create Vector Index"
date = 2020-05-14T00:38:32+07:00
weight = 2
chapter = false
pre = "<b>5.2 </b>"
+++

This section guides you through creating a vector index in OpenSearch Serverless using Postman to enable k-NN similarity searches for your AI assistant.

### Create IAM User

#### Create Deployment User

1. Create an IAM user **bedrock-chatbot-deployer** with **AdministratorAccess** policy
   ![user1](/images/5/user1.png?width=91pc)

#### Generate Access Keys

2. Create **Access Keys** for programmatic access:
- Get the access key information of the newly created user
     ![userAccesskey](/images/5/user2.png?width=91pc)
- Add a **tag** with **Key** and **Value** as an **access key**
     ![user2](/images/5/user3.png?width=91pc)

{{% notice warning %}}
**Important:** Save the Access Key ID and Secret Access Key securely - they will be needed for Postman authentication.
{{% /notice %}}

### Configure Postman Request

#### Set Up Authentication

1. Open **Postman** and configure the request:

   - **Method**: PUT
   - **URL**: `<Opensearch-Endpoint>/slack-bedrock-os-index5`
   - **Auth Type**: AWS Signature
   - **Access Key**: Your IAM user access key
   - **Secret Key**: Your IAM user secret key
   - **Region**: us-east-1
   - **Service Name**: aoss

   ![postman1](/images/5/postman1.png?width=91pc)

#### Set Headers

2. Configure request headers:
   - **Content-Type**: application/json
     ![postman2](/images/5/postman2.png?width=91pc)

#### Configure Request Body

3. Set body type to **raw** and enter the following JSON:
   ![postman3](/images/5/postman3.png?width=91pc)

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

### Create the Index

#### Send Request

4. Click **Send** to create the vector index
   - A successful response indicates the index was created
     ![postman4](/images/5/postman4.png?width=91pc)

#### Verify Index Creation

5. Verify the index was created successfully in OpenSearch console:

   - **Index Name**: slack-bedrock-os-index5
   ![opensearch17](/images/5/opensearch17.png?width=90pc)
   - **Vector Field**: bedrock-knowledge-base-default-vector
   ![opensearch18](/images/5/opensearch18.png?width=90pc)
   - **Metadata Fields**: Available for document tracking
   ![opensearch19](/images/5/opensearch19.png?width=90pc)

{{% notice info %}}
**Note:** The vector index is configured with 1024 dimensions to match Amazon Titan Text Embeddings V2 model output and uses HNSW algorithm for efficient similarity search.
{{% /notice %}}

### Index Configuration Explained

#### Vector Settings

- **Dimension**: 1024 (matches Titan Embeddings V2)
- **Algorithm**: HNSW (Hierarchical Navigable Small World)
- **Engine**: FAISS (Facebook AI Similarity Search)
- **Space Type**: L2 (Euclidean distance)

#### Metadata Fields

- **AMAZON_BEDROCK_TEXT_CHUNK**: Searchable document text
- **AMAZON_BEDROCK_METADATA**: Document metadata (not indexed)
- **x-amz-bedrock-kb-source-uri**: Document source tracking
- **x-amz-bedrock-kb-document-page-number**: Page reference

#### What's Next

Your vector index is now ready to store and search document embeddings. Next, we'll create the Bedrock Knowledge Base that will use this OpenSearch collection.

---

**Continue to**: [Module 6 - Bedrock Knowledge Base](../../6-bedrock-kb/)
