# Amazon Bedrock Knowledge Base Slack Bot - Terraform

Đây là phiên bản Terraform của Amazon Bedrock Knowledge Base Slack Bot, được migrate từ AWS CDK.

## Cấu trúc dự án

```
terraform/
├── main.tf                    # File cấu hình chính
├── terraform.tfvars.example   # File ví dụ cho biến
├── modules/
│   ├── bedrock/              # Module Bedrock và OpenSearch
│   ├── lambda/               # Module Lambda functions
│   └── api_gateway/          # Module API Gateway
└── README.md
```

## Yêu cầu

- Terraform >= 1.0
- AWS CLI được cấu hình
- Slack App với Bot Token và Signing Secret

## Cách triển khai

### 1. Chuẩn bị

```bash
cd terraform
cp terraform.tfvars.example terraform.tfvars
```

### 2. Cấu hình biến

Chỉnh sửa file `terraform.tfvars`:

```hcl
aws_region = "us-east-1"
slack_bot_token = "xoxb-your-actual-bot-token"
slack_signing_secret = "your-actual-signing-secret"
```

### 3. Khởi tạo và triển khai

```bash
# Khởi tạo Terraform
terraform init

# Xem kế hoạch triển khai
terraform plan

# Triển khai
terraform apply
```

### 4. Lấy thông tin đầu ra

Sau khi triển khai thành công:

```bash
# Lấy URL API Gateway
terraform output api_gateway_url

# Lấy tên S3 bucket
terraform output s3_bucket_name

# Lấy Knowledge Base ID
terraform output knowledge_base_id
```

## Tài nguyên được tạo

### Core Resources
- **S3 Bucket**: Lưu trữ dữ liệu cho Knowledge Base
- **Secrets Manager**: Lưu trữ Slack credentials
- **SSM Parameters**: Tham chiếu đến secrets

### Bedrock Module
- **Bedrock Knowledge Base**: RAG service chính
- **Bedrock Guardrail**: Bảo vệ nội dung
- **OpenSearch Serverless**: Vector database
- **IAM Roles**: Quyền truy cập cho Bedrock

### Lambda Module
- **Bedrock KB Slackbot Function**: Xử lý Slack commands
- **Create Index Function**: Tạo OpenSearch index
- **IAM Roles**: Quyền thực thi Lambda

### API Gateway Module
- **REST API**: Endpoint cho Slack integration
- **CloudWatch Logs**: Logging cho API Gateway

## Cấu hình Slack App

1. Tạo Slack App tại https://api.slack.com/apps
2. Cấu hình Bot Token Scopes:
   - `chat:write`
   - `commands`
3. Tạo Slash Command `/xhaly`
4. Cấu hình Request URL với API Gateway URL từ output
5. Install App vào workspace

## Tải dữ liệu vào Knowledge Base

Sử dụng script có sẵn:

```bash
# Từ thư mục gốc của dự án
./scripts/load-kb.sh
```

Hoặc upload file trực tiếp vào S3 bucket được tạo.

## Dọn dẹp

```bash
terraform destroy
```

## So sánh với CDK

| Tính năng | CDK | Terraform |
|-----------|-----|-----------|
| Cú pháp | TypeScript | HCL |
| Modules | Constructs | Modules |
| State | CloudFormation | State file |
| Deployment | `cdk deploy` | `terraform apply` |

## Lưu ý

- Đảm bảo có quyền truy cập Bedrock models trong region
- Kiểm tra quota limits cho OpenSearch Serverless
- Backup state file Terraform thường xuyên