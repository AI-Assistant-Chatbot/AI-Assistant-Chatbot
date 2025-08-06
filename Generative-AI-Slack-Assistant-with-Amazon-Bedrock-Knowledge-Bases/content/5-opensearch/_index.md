+++
title = "Set up opensearch"
date = 2020-05-14T00:38:32+07:00
weight = 5
chapter = false
pre = "<b>5. </b>"
+++

In the context of this AI chatbot solution, Amazon OpenSearch Serverless functions as the centralized vector database, acting as the memory engine that drives the semantic retrieval capabilities of the Retrieval-Augmented Generation (RAG) workflow.

When documents are first ingested into the system, they are processed and transformed into high-dimensional vector embeddings using the Amazon Titan Text Embeddings v2 model. These embeddings, which support semantic understanding across multiple languages including Vietnamese and English, are stored in a dedicated vector collection within OpenSearch Serverless. The vector collection, identified by the name slack-bedrock-vector-db, offers fully managed, serverless, and auto-scaling storage of embedding vectors, eliminating the need for manual cluster management.

To facilitate efficient retrieval, these stored vectors are indexed using a vector index named slack-bedrock-os-index, which enables high-performance similarity search using k-nearest neighbor (k-NN) algorithms. The OpenSearch index also retains metadata associated with the original document chunks, such as file names or section titles, ensuring that retrieval results are both contextually accurate and traceable.

During a typical query interaction, when a user submits a question via Slack, the input is embedded using the same Titan v2 model. This query embedding is sent to OpenSearch, where a vector similarity search is conducted against the stored embeddings. The most relevant chunks of documents are then retrieved and returned to the RAG system to serve as context for final response generation.

The serverless nature of OpenSearch ensures that it scales automatically with traffic volume and operates on a pay-per-use pricing model, helping keep costs predictable and aligned with usage. The architecture requires no manual provisioning or maintenance of nodes, which significantly simplifies operations. With sub-second response times, the system supports real-time querying, providing users with instant, relevant information.

Security is also embedded into the design. OpenSearch Serverless integrates with IAM-based access control and supports encryption both at rest and in transit. Through the BedrockOSSPolicyForKnowledgeBase policy, fine-grained access permissions are enforced, ensuring that only authorized components can access or query the vector database.

Ultimately, OpenSearch Serverless functions as the persistent memory layer of the AI assistant, enabling it to recall and reference vast amounts of organizational knowledge with semantic precision.