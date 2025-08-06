+++
title = "Security"
date = 2024-05-14T00:38:32+07:00
weight = 4
chapter = false
pre = "<b>4. </b>"
+++

Security is a foundational element of this chatbot system, and it is implemented through a dual-layered approach that combines the strengths of AWS Secrets Manager and AWS Systems Manager Parameter Store to ensure the secure handling of sensitive credentials and configurations throughout the application lifecycle.

The primary function of AWS Secrets Manager in this project is to securely store and manage confidential credentials, particularly those required for the Slack bot's authentication. These include the Slack Bot User OAuth Token, which is essential for programmatic access to the Slack API, and the Slack Signing Secret, which is used to validate that incoming requests to the application originate from Slack. Secrets Manager ensures these values are encrypted at rest using AWS-managed keys and supports automatic secret rotation, which enhances long-term security and reduces the risk of credential exposure. Furthermore, all access to stored secrets is tightly controlled through IAM policies, allowing only explicitly authorized roles and services to retrieve them.

Complementing Secrets Manager is the AWS Systems Manager Parameter Store, which plays a key role in configuration management and runtime secret resolution. Instead of Lambda functions directly accessing secrets, the architecture leverages Parameter Store to create references to the secrets stored in Secrets Manager. Using the native {{resolve:secretsmanager:...}} syntax, Lambda functions can dynamically fetch the latest values at execution time. This approach avoids hardcoding sensitive data in source code or environment variables, and makes deployments cleaner and safer. The use of Standard-tier parameters within SSM also ensures that the configuration layer remains cost-effective.

This design provides several security benefits. First, it enables a separation of concerns, where Secrets Manager handles encryption and storage, while Parameter Store manages controlled distribution. Second, credentials are never exposed in plain text or stored within the codebase, reducing attack vectors. Third, this setup supports dynamic runtime resolution, meaning credentials are always up to date when Lambda functions run. Fourth, auditing and monitoring are enabled for both Secrets Manager and Parameter Store, providing complete traceability for compliance. Lastly, it follows the principle of least privilege access, as Lambda functions require permission to read from SSM, but do not need direct access to Secrets Manager.

Together, these services establish a robust security architecture that ensures sensitive Slack credentials remain protected while still being seamlessly accessible to the AI chatbot application at runtime.

