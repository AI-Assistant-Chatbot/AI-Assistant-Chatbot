+++
title ="Set up knowledge base"
date = 2020-05-14T00:38:32+07:00
weight = 6
chapter = false
pre = "<b>5.2 </b>"
+++
#### S3 configuration
1. Create a new bucket.
    ![s3_1](/images/5/s3_1.png?width=90pc)
    ![s3_2](/images/5/s3_2.png?width=90pc)
    ![s3_3](/images/5/s3_3.png?width=90pc)
  

#### Configure on Bedrock
1. Access to [Amazon Bedrock Console](https://us-east-1.console.aws.amazon.com/bedrock/home?region=us-east-1#/overview).

   ![modelAccess0](/images/5/modelAccess0.png?width=90pc)

2. Scroll down to the bottom of the **navigation sidebar** and choose **Knowledge base**.
    ![kb1](/images/5/kb1.png?width=90pc)

3. Choose **Create** and choose **Knowledge Base with vector store**.
    ![kb2](/images/5/kb2.png?width=90pc)

4. Set up knowledge base with vector store.
- Enter **knowledge base name** and **create a new role**
    ![kb3](/images/5/kb3.png?width=91pc)
- Data source type will be S3
    ![kb4](/images/5/kb4.png?width=91pc)
- Select S3 to store data
    ![kb5](/images/5/kb5.png?width=91pc)
    ![kb6](/images/5/kb6.png?width=91pc)
- Select **Embeddings model**
    ![kb7](/images/5/kb7.png?width=91pc)
    ![kb8](/images/5/kb8.png?width=91pc)
- **Vector store** is **Amazon Opensearch Serverless**
    ![kb9](/images/5/kb9.png?width=91pc)
- Configuring the **Vector Store** with what was created in the previous steps is the **set up opensearch** preparation step
    ![kb10](/images/5/kb10.png?width=91pc)
    ![kb11](/images/5/kb11.png?width=91pc)
- Knowledge Base will be created successfully.
    ![kb12](/images/5/kb12.png?width=91pc)
- Role for knowledge base will have policies
    ![kb13](/images/5/kb13.png?width=91pc)
