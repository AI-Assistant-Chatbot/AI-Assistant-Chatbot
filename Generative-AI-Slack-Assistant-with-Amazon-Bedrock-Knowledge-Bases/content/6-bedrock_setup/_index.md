+++
title ="Bedrock setup"
date = 2020-05-14T00:38:32+07:00
weight = 6
chapter = false
pre = "<b>6. </b>"
+++

In this workshop, we use a **knowledge base** to retrieve information provided from **S3**. The data from S3 is split into smaller segments (**document chunks**) and converted into vectors using an **embeddings model**. These vectors are then stored in a vector store, specifically **Amazon OpenSearch Serverless.**

When a user submits a question, the system performs **semantic search** against the vector store to retrieve relevant text segments (**context**). This contextual information is incorporated into **prompt augmentation** to provide the necessary background for the **Large Language Model (LLM).** Finally, the LLM generates an accurate and contextually appropriate response based on the knowledge base.

At the heart of this AI chatbot system lies Amazon Bedrock, which serves both as the foundation model hosting platform and the managed orchestration engine for the entire RAG (Retrieve-and-Generate) pipeline. Bedrock enables the seamless combination of foundation models, vector-based retrieval, and knowledge base indexing into a unified, scalable workflow.

The chatbot relies on two key models provided by Bedrock. For text embedding, it utilizes Amazon Titan Text Embeddings v2, a multilingual embedding model optimized for languages like Vietnamese and English, capable of generating rich semantic representations of documents and queries. For text generation, it employs Claude 3 Haiku, a lightweight and cost-efficient model that produces natural, fluent, and contextually appropriate responses.

The Amazon Bedrock Knowledge Base component acts as the central RAG orchestrator. It ingests documents stored in S3 (via a designated data source), generates vector embeddings using Titan v2, and stores them in OpenSearch Serverless. At runtime, when a user submits a query, the RetrieveAndGenerate API of Bedrock is invoked. This single API call handles all the complexity: embedding the query, retrieving the most relevant document chunks via vector similarity search, passing the content to Claude 3 Haiku, and returning the generated response.

A crucial layer of security and response control is handled by Bedrock Guardrails, configured under the name slack-bedrock-guardrail. This feature is responsible for content filtering, ensuring that responses do not contain sensitive, inappropriate, or harmful language, including topics related to violence, hate, or misconduct. It also offers protection against prompt injection attacks and enables custom error messaging, ensuring responses meet safety and compliance standards required in enterprise environments.

From a technical operations perspective, Bedrock requires no infrastructure provisioning, as it offers serverless access to foundation models with automatic scalability, maintenance, and updates. This significantly reduces the burden of managing ML infrastructure. The solution is also region-optimized for ap-southeast-1, ensuring latency and cost efficiency for users in Southeast Asia.

Access to Bedrock is strictly controlled through IAM roles (e.g., bedrockExecutionRole), and all operations are logged to support auditing, governance, and enterprise-grade security compliance.

In essence, Amazon Bedrock functions as the “brain” of the AI chatbot, coordinating embedding, retrieval, content generation, and moderation — all under a fully managed, secure, and scalable AI service platform.