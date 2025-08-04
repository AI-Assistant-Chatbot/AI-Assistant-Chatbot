+++
title ="Bedrock setup"
date = 2020-05-14T00:38:32+07:00
weight = 5
chapter = false
pre = "<b>5. </b>"
+++

In this workshop, we use a **knowledge base** to retrieve information provided from **S3**. The data from S3 is split into smaller segments (**document chunks**) and converted into vectors using an **embeddings model**. These vectors are then stored in a vector store, specifically **Amazon OpenSearch Serverless.**

When a user submits a question, the system performs **semantic search** against the vector store to retrieve relevant text segments (**context**). This contextual information is incorporated into **prompt augmentation** to provide the necessary background for the **Large Language Model (LLM).** Finally, the LLM generates an accurate and contextually appropriate response based on the knowledge base.
