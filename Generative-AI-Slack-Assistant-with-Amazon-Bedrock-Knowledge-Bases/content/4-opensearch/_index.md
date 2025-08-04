+++
title = "Set up opensearch"
date = 2020-05-14T00:38:32+07:00
weight = 4
chapter = false
pre = "<b>4. </b>"
+++

In Amazon OpenSearch Serverless, a collection is a logical unit that organizes and manages a set of related indices. It replaces the concept of domains in the traditional OpenSearch model, but operates in a serverless manner—that is, without the need for users to configure or manage specific infrastructure. Each collection is designed to automatically scale resources on demand and supports different types of data, including text and vector data.

Collections in OpenSearch Serverless perform many important functions such as storing search data, supporting real-time analytics, and processing text and vector queries (KNN search). It allows users to separate data and access policies according to each specific application or use case. In addition, collections automatically handle scaling, performance optimization, and security at the infrastructure level without requiring manual user intervention, simplifying the process of deploying and operating search systems.
