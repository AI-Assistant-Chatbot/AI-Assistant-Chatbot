---
title: "OpenSearch Serverless Collection"
date: "2025-06-30"
weight: 1
chapter: false
pre: " <b> 5.1 </b> "
---

#### Create OpenSearch Serverless Collection

This section guides you through creating an OpenSearch Serverless collection for vector storage, including the necessary access and network policies.

#### Access OpenSearch Console

1. Navigate to [Amazon OpenSearch Service Console](https://us-east-1.console.aws.amazon.com/aos/home?region=us-east-1#opensearch)
   ![opensearch1](/images/5-opensearch/5.1-collection/opensearch1.png?width=90pc)

#### Create Data Access Policy

2. Scroll down and select **Data access policies** → **Create access policy**
   ![opensearch8](/images/5-opensearch/5.1-collection/opensearch8.png?width=90pc)

3. Enter **Access policy name** → Choose **JSON**
   ![opensearch9](/images/5-opensearch/5.1-collection/opensearch9.png?width=90pc)

4. Enter the following JSON policy and click **Create**:
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
   ![opensearch10](/images/5-opensearch/5.1-collection/opensearch10.png?width=91pc)

{{% notice warning %}}
**Important:** Replace `<YOUR-ACCOUNT-ID>` with your actual AWS account ID.
{{% /notice %}}

#### Create Network Policy

5. Create **Network policy** → **Create network policy**
   ![opensearch11](/images/5-opensearch/5.1-collection/opensearch11.png?width=90pc)

6. Enter **Network policy name** -> select **JSON**
   ![opensearch12](/images/5-opensearch/5.1-collection/opensearch12.png?width=90pc)

7. Enter the following JSON policy and click **Create**:
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

#### Create Vector Collection

8. **Create the collection**:

   - Select **Collections**
     ![opensearch2](/images/5-opensearch/5.1-collection/opensearch2.png?width=90pc)

   - Select **Create Collection**
     ![opensearch3](/images/5-opensearch/5.1-collection/opensearch3.png?width=90pc)

   - Configure collection settings:

     - **Collection name**: `slack-bedrock-vector-db5`
     - **Collection type**: Vector search
       ![opensearch4](/images/5-opensearch/5.1-collection/opensearch4.png?width=91pc)
     - **Security**: Standard create
       ![opensearch5](/images/5-opensearch/5.1-collection/opensearch5.png?width=90pc)

   - Use default settings and click **Create**

#### Note Important Information

9. **Save the following details** for later configuration:

   - **Collection ARN**: `arn:aws:aoss:us-east-1:account:collection/collection-id`
   - **OpenSearch Endpoint**: `https://collection-id.us-east-1.aoss.amazonaws.com`

   ![opensearch14](/images/5-opensearch/5.1-collection/opensearch14.png?width=91pc)
   ![opensearch15](/images/5-opensearch/5.1-collection/opensearch15.png?width=91pc)

   - The next step is to create an index table.
     ![opensearch16](/images/5-opensearch/5.1-collection/opensearch16.png?width=90pc)

{{% notice tip %}}
**Tip:** Copy and save the Collection ARN and OpenSearch Endpoint as they will be needed for Bedrock Knowledge Base configuration.
{{% /notice %}}

#### What's Next

Your OpenSearch Serverless collection is now ready to store vector embeddings. Next, we'll create the vector index for efficient similarity searches.

---

**Continue to**: [5.2 - Create Vector Index](../5.2-vector_index/)
