+++
title = "Solution overview"
date = 2020-05-14T00:38:32+07:00
weight = 1
chapter = false
pre = "<b>1.1 </b>"
+++

This solution integrates **Slack** with **Amazon Bedrock** and its **Knowledge base** to enable business users to interact with a generative AI assistant directly within Slack. The system processes user queries asynchronously, performs safety checks using **Amazon Bedrock Guardrails**, and retrieves relevant knowledge from a vectorized database built on **Amazon OpenSearch**, populated from documents stored in **Amazon S3**.


The backend is fully serverless, using **AWS Lambda** and **API Gateway** to manage Slack interactions, and relies on **Amazon Bedrock** for prompt handling and intelligent responses. This architecture enables secure, scalable, and compliant AI-powered support for enterprise users in real time.
