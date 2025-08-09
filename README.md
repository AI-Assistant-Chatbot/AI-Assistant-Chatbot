# Build a Generative AI Slack Assistant with Amazon Bedrock Knowledge Bases

[![AWS](https://img.shields.io/badge/AWS-Bedrock-orange)](https://aws.amazon.com/bedrock/)
[![Python](https://img.shields.io/badge/Python-3.12+-blue)](https://www.python.org/)
[![Slack](https://img.shields.io/badge/Slack-Bot-purple)](https://slack.dev/)
[![License](https://img.shields.io/badge/License-MIT-green)](LICENSE)

## 🚀 Workshop Overview

Learn to build a production-ready Slack bot powered by Amazon Bedrock Knowledge Bases that can answer questions about your organization's documents using advanced AI and natural language processing.

**What you'll build:**
- A Slack bot that responds to `/ask-aws` commands
- RAG (Retrieval-Augmented Generation) system using Amazon Bedrock
- Enterprise-grade security with content filtering and guardrails
- Scalable serverless architecture on AWS

## 🎯 Learning Objectives

By the end of this workshop, you will:

- ✅ **Build a production-ready Slack bot** with generative AI capabilities
- ✅ **Implement RAG architecture** using Amazon Bedrock Knowledge Bases
- ✅ **Configure enterprise security** with Bedrock Guardrails and content filtering
- ✅ **Deploy serverless infrastructure** using AWS Lambda, API Gateway, and OpenSearch
- ✅ **Monitor and optimize** your AI application for production use

## 🏗️ Architecture

```mermaid
graph TB
    A[Slack User] -->|/ask-aws command| B[API Gateway]
    B --> C[Lambda Function]
    C --> D[Bedrock Knowledge Base]
    D --> E[OpenSearch Serverless]
    D --> F[Claude 3 Sonnet]
    G[S3 Documents] -->|Ingestion| D
    F --> H[Bedrock Guardrails]
    H -->|Filtered Response| I[Slack Channel]
    
    style A fill:#e1f5fe
    style D fill:#f3e5f5
    style F fill:#fff3e0
    style H fill:#ffebee
```

**Key Components:**
- **Slack Interface**: Natural language interaction via slash commands
- **API Gateway**: RESTful API endpoint for Slack webhooks
- **AWS Lambda**: Serverless compute for bot logic
- **Amazon Bedrock**: Fully managed AI service with Knowledge Bases
- **OpenSearch Serverless**: Vector database for semantic search
- **S3**: Document storage for knowledge base content

## 📋 Prerequisites

### Required Knowledge
- Basic AWS services (Lambda, S3, IAM)
- Python programming fundamentals
- REST API concepts
- Basic understanding of AI/ML concepts

### Required Tools
- **AWS Account** with appropriate permissions
- **Slack Workspace** with admin access
- **Python 3.12+** installed locally
- **AWS CLI** configured
- **Code Editor** (VS Code recommended)

### AWS Services Used
- Amazon Bedrock (Knowledge Bases, Guardrails)
- AWS Lambda
- Amazon API Gateway
- Amazon S3
- Amazon OpenSearch Serverless
- AWS Secrets Manager
- Amazon CloudWatch

## ⏱️ Workshop Timeline

| Module | Duration | Topic |
|--------|----------|-------|
| **1** | 15 min | Introduction |
| **2** | 30 min | Environment Setup |
| **3** | 45 min | Slack App Configuration |
| **4** | 30 min | Security Setup |
| **5** | 45 min | OpenSearch Serverless |
| **6** | 30 min | Bedrock Knowledge Base |
| **7** | 45 min | Lambda Implementation |
| **8** | 20 min | API Gateway & Testing |
| **9** | 15 min | Resource Cleanup |
| **10** | 15 min | Conclusion |

**Total Duration:** 4-5 hours

## 🛠️ Quick Start

### 1. Prerequisites Setup
```bash
# Ensure you have:
# - AWS Account with Bedrock access
# - Slack workspace with admin permissions
# - Python 3.12+ installed
# - AWS CLI configured
```

### 2. Enable Bedrock Models
1. Go to [Amazon Bedrock Console](https://console.aws.amazon.com/bedrock/)
2. Navigate to "Model access"
3. Enable:
   - **Amazon Titan Text Embeddings V2**
   - **Anthropic Claude 3 Sonnet**

### 3. Create Slack App
1. Visit [Slack API](https://api.slack.com/apps)
2. Create new app "From scratch"
3. Add OAuth scopes: `commands`, `chat:write`, `incoming-webhook`
4. Install to your workspace

### 4. Follow Workshop Modules
Start with [Module 1 - Introduction](content/1-introduction/) and follow the step-by-step guide.

## 📁 Workshop Structure

```
Bedrock-Slackbot-AI-Workshop/
├── content/                           # Workshop modules
│   ├── 1-introduction/               # Workshop overview
│   ├── 2-environment-setup/          # AWS and development setup
│   ├── 3-slack_app/                  # Slack app configuration
│   │   ├── 3.1-create_slackapp/      # Create Slack app
│   │   ├── 3.2-OAuth&Permissions/    # Configure permissions
│   │   └── 3.3-slash_commands/       # Set up slash commands
│   ├── 4-security/                   # Security configuration
│   │   ├── 4.1-secret manager/       # AWS Secrets Manager
│   │   └── 4.2-systems manager/      # Parameter Store
│   ├── 5-opensearch/                 # Vector database setup
│   │   ├── 5.1-collection/           # OpenSearch collection
│   │   └── 5.2-vector_index/         # Vector index creation
│   ├── 6-bedrock_setup/              # Bedrock configuration
│   │   ├── 6.1-model_access/         # Enable foundation models
│   │   └── 6.3-knowledge_base/       # Create Knowledge Base
│   ├── 7-lambda_implementation/      # Lambda function
│   │   ├── 7.1-lambda_role/          # IAM role creation
│   │   └── 7.2-config_code/          # Function configuration
│   ├── 8-api_gateway/                # API Gateway and testing
│   ├── 9-clear resources/            # Resource cleanup
│   └── 10-conclusion/                # Workshop conclusion
├── images/                           # Workshop screenshots
└── README.md                         # This file
```

## 🔧 Key Features

### 🤖 Intelligent Slack Bot
- **Natural Language Processing**: Ask questions in plain English
- **Contextual Responses**: AI-powered answers with source citations
- **Instant Feedback**: Sub-3-second acknowledgment with async processing

### 🛡️ Enterprise Security
- **Content Filtering**: Bedrock Guardrails block inappropriate content
- **PII Protection**: Automatic detection and anonymization
- **Access Control**: IAM-based permissions and Slack workspace restrictions
- **Secure Credential Management**: AWS Secrets Manager and Parameter Store

### 📊 Production Ready
- **Monitoring**: CloudWatch logs and custom metrics
- **Error Handling**: Graceful degradation and user-friendly messages
- **Scalability**: Serverless architecture with auto-scaling
- **Cost Optimization**: Pay-per-use pricing model

### 🔍 Advanced RAG
- **Semantic Search**: Vector-based document retrieval
- **Multi-Document Support**: Query across multiple knowledge sources
- **Citation Tracking**: Source attribution for all responses
- **Real-time Updates**: Dynamic knowledge base synchronization

## 💰 Cost Estimation

**Workshop Completion Cost:** ~$5-10

| Service | Usage | Cost |
|---------|-------|------|
| Lambda | 1,000 requests | $0.20 |
| API Gateway | 1,000 requests | $3.50 |
| Bedrock | 100K tokens | $3.00 |
| OpenSearch Serverless | 1 OCU × 4 hours | $0.96 |
| S3 | 10GB storage | $0.23 |

**Production Monthly Cost:** ~$175 (100 users, 1000 queries)

## 🎓 What You'll Learn

### Module Highlights

**🏗️ Infrastructure Setup**
- Deploy AWS resources with proper security
- Configure OpenSearch Serverless for vector search
- Set up secure IAM roles and policies

**🤖 AI/ML Integration**
- Implement RAG architecture with Amazon Bedrock
- Configure foundation models (Claude 3, Titan Embeddings)
- Apply content safety with Guardrails

**⚡ Serverless Development**
- Build event-driven Lambda functions
- Integrate with Slack using proper authentication
- Handle async processing and error management

**📊 Operations & Monitoring**
- Set up CloudWatch logging and metrics
- Configure alerts and troubleshooting
- Implement performance optimization

## 📚 Additional Resources

### Documentation
- [Amazon Bedrock User Guide](https://docs.aws.amazon.com/bedrock/)
- [Slack Bolt for Python](https://slack.dev/bolt-python/)
- [OpenSearch Serverless Guide](https://docs.aws.amazon.com/opensearch-service/latest/developerguide/serverless.html)

### Sample Use Cases
- **Customer Support**: Answer product questions from documentation
- **HR Assistant**: Query company policies and procedures
- **Technical Documentation**: Search engineering knowledge base
- **Compliance**: Access regulatory and compliance information

### Related Workshops
- [Build with Amazon Bedrock](https://catalog.workshops.aws/bedrock-immersion-day/)
- [Serverless AI Applications](https://catalog.workshops.aws/serverless-ai/)
- [OpenSearch Workshop](https://catalog.workshops.aws/opensearch/)

## 🤝 Contributing

We welcome contributions! Please see our [Contributing Guide](CONTRIBUTING.md) for details.

### Ways to Contribute
- 🐛 Report bugs and issues
- 💡 Suggest new features or improvements
- 📝 Improve documentation
- 🧪 Add test cases
- 🌟 Share your use cases and success stories

## 📄 License

This project is licensed under the MIT-0 License. See the [LICENSE](LICENSE) file for details.

## 🆘 Support

### Getting Help
- 📖 Check the workshop modules for detailed instructions
- 🎫 Open an [Issue](https://github.com/your-repo/bedrock-slack-bot-workshop/issues)
- 📧 Contact the workshop team

### Common Issues
- **Bedrock Model Access**: Ensure models are enabled in your region
- **Slack Permissions**: Verify OAuth scopes and workspace installation
- **API Limits**: Check service quotas and rate limits
- **Cost Management**: Monitor usage and set up billing alerts

## 🏆 Success Stories

> *"This workshop helped us build an internal knowledge assistant that reduced support tickets by 40% and improved employee productivity."*  
> — **Enterprise Customer**

> *"The step-by-step approach made it easy to understand RAG architecture and implement it in our organization."*  
> — **Solutions Architect**

> *"Great hands-on experience with Amazon Bedrock. The security features are exactly what we needed for enterprise deployment."*  
> — **DevOps Engineer**

## 👥 Credits

This workshop was developed and maintained by:

**Le Hong Anh**  
*AI Solutions Architect*  
[LinkedIn Profile](https://www.linkedin.com/in/hong-anh-le-29208a304/)

**Tran Doan Cong Ly**  
*Cloud Solutions Engineer*  
[LinkedIn Profile](https://www.linkedin.com/in/trandoancongly/)

## 🔄 Updates & Changelog

### Latest Version: v1.0.0
- ✨ Initial workshop release
- 🤖 Support for Claude 3 Sonnet and Titan Embeddings V2
- 🛡️ Bedrock Guardrails integration
- 📊 Comprehensive security setup
- 🔧 Complete resource cleanup guide

### Upcoming Features
- 🌐 Multi-language support
- 🔄 Automated CI/CD pipeline
- 📱 Mobile-optimized Slack interface
- 🎯 Advanced analytics dashboard

---

**Ready to build your AI-powered Slack assistant?** 🚀

[**Start the Workshop →**](content/1-introduction/)

---

<div align="center">

**Built with ❤️ by the AWS Community**

[🌟 Star this repo](https://github.com/your-repo/bedrock-slack-bot-workshop) | [🍴 Fork it](https://github.com/your-repo/bedrock-slack-bot-workshop/fork) | [📢 Share it](https://twitter.com/intent/tweet?text=Check%20out%20this%20awesome%20AWS%20Bedrock%20Slack%20Bot%20workshop!)

</div>