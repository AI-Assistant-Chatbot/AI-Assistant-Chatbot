+++
title = "Introduction"
date = 2020-05-14T00:38:32+07:00
weight = 1
chapter = false
pre = "<b>1. </b>"
+++

This project introduces an AI-powered assistant chatbot designed for integration with Slack, built upon the managed RAG (Retrieval-Augmented Generation) capabilities of Amazon Bedrock. At its core, the solution is structured to provide intelligent, context-aware responses to user queries by tapping into an organization's internal knowledge base. The chatbot is triggered via Slack's custom slash command /ask-ai, using the Slack Bolt Python SDK to handle event processing, authentication, and command execution.

Once a user submits a question in Slack, the request is routed to an AWS Lambda function via API Gateway. This Lambda function interacts directly with the Amazon Bedrock Knowledge Base service, which orchestrates the entire RAG pipeline. The chatbot retrieves relevant content from the knowledge base through vector similarity search powered by Amazon OpenSearch Serverless, which stores and indexes document embeddings that were generated using Amazon Titan Text Embeddings v2. These embeddings support multilingual processing, particularly optimized for Vietnamese and English, allowing users to interact naturally in both languages.

After the appropriate content is retrieved from the vector store, it is passed along with the original user query to Claude 3 Haiku, a lightweight and cost-effective large language model hosted within Amazon Bedrock. This model generates the final response that is returned to the Slack user.

The entire system is built using a serverless architecture, leveraging AWS Lambda for compute, API Gateway for routing, S3 for document storage, and Bedrock for managed AI services. All components are defined and deployed using the AWS Cloud Development Kit (CDK), which allows infrastructure to be managed as code. This enables full automation, scalability, and maintainability while keeping operational overhead low.

Designed with flexibility and extensibility in mind, this chatbot can be adapted for a wide range of scenarios such as internal documentation access, frequently asked questions (FAQs), customer service support, or enterprise-level knowledge sharing. The use of Amazon Bedrock’s managed orchestration combined with serverless infrastructure results in a powerful AI assistant that is secure, scalable, cost-efficient, and highly responsive to end-user needs.