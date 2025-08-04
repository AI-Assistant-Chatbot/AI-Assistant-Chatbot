+++
title = "Vector index"
date = 2020-05-14T00:38:32+07:00
weight = 4
chapter = false
pre = "<b>4.2 </b>"
+++

#### Create user

1. Create a user **bedrock-chatbot-deployer** with policy **AdministratorAccess**
   ![user1](/images/4/user1.png?width=90pc)

2. Create a **tag** with **Key** and **Value** are **access key**
   ![userAccesskey](/images/4/userAccesskey.png?width=90pc)
   ![user2](/images/4/user2.png?width=90pc)


#### Create index

1. Access to **Postman** with:
- URL is **Collection endpoint**/<Index_name>
- Auth type: **AWS Signature**
- **AccessKey** and **SecretKey**
- Region: **us-east-1**
- Service name: **aoss**
   ![postman1](/images/4/postman1.png?width=90pc)
- Header:
  - Content type: **Application/json**
   ![postman2](/images/4/postman2.png?width=90pc)

- Body:
  - **raw**
   ![postman3](/images/4/postman3.png?width=90pc)
  - Enter code following
  
 ```js
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
2. Click **Send**. Correct configuration will get response
  ![postman4](/images/4/postman4.png?width=90pc)

3. An index will be created with **Vector field name** and **Metadata**
  ![opensearch17](/images/4/opensearch17.png?width=90pc)


  ![opensearch18](/images/4/opensearch18.png?width=90pc)

  
  ![opensearch19](/images/4/opensearch19.png?width=90pc)
    
