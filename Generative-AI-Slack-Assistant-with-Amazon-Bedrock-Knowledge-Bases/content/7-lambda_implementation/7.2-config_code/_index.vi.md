---
title: "Tạo và Cấu hình Lambda Function"
date: "2025-06-30"
weight: 2
chapter: false
pre: " <b> 7.2 </b> "
---

Phần này hướng dẫn bạn tạo Lambda function và cấu hình nó với code, settings và environment variables cần thiết.

#### Tạo Lambda Function

**Thiết lập Function Cơ bản**

1. Tạo Lambda function mới tên **BedrockKBSlackbotFunction5**:

   - **Runtime**: Python 3.12
   - **Architecture**: x86_64

   ![lambda5](/images/7-lambda_implementation/7.2-config_code/lambda5.png?width=90pc)

**Attach IAM Role**

2. Attach IAM role **BedrockExecutionRole8888** (đã tạo trong section 7.1) và nhấp **Create**:
   ![lambda6](/images/7-lambda_implementation/7.2-config_code/lambda6-.png?width=90pc)

#### Upload Function Code

**Deploy Code Package**

3. Upload Lambda deployment package:

   - Tải xuống: [BedrockKBSlackbotFunction.zip](https://github.com/honganh29122002/lambda_code_zip)
   - Truy cập **Code** tab → **Upload from** → **.zip file**
   - Chọn và upload file zip đã tải

   ![lambda7](/images/7-lambda_implementation/7.2-config_code/lambda7-.png?width=90pc)

   - Chọn **Save**
     ![lambda8](/images/7-lambda_implementation/7.2-config_code/lambda8.png?width=90pc)
   - Upload thành công
     ![lambda9](/images/7-lambda_implementation/7.2-config_code/lambda9-.png?width=90pc)

{{% notice info %}}
**Lưu ý:** File zip chứa Slack Bolt framework và tất cả dependencies cần thiết cho bot functionality.
{{% /notice %}}

#### Cấu hình Function Settings

**Cập nhật Handler**

4. Thay đổi **Handler** để khớp với code entry point của bạn:

   - **Handler**: `index.handler`

   ![lambda11](/images/7-lambda_implementation/7.2-config_code/lambda11-.png?width=91pc)

**Điều chỉnh Performance Settings**

5. Cấu hình **Memory** và **Timeout** để hiệu suất tối ưu:

   - **Memory**: 512 MB (khuyến nghị cho Bedrock API calls)
   - **Timeout**: 5 phút (cho phép thời gian cho Knowledge Base queries)

   ![lambda13](/images/7-lambda_implementation/7.2-config_code/lambda13-.png?width=90pc)

#### Environment Variables

**Thêm Configuration Variables**

6. Thêm các **Environment variables** sau:

   | Key                              | Value                                     | Mục đích                                |
   | -------------------------------- | ----------------------------------------- | --------------------------------------- |
   | `KNOWLEDGE_BASE_ID`              | `your-kb-id-from-module-6`                | Tham chiếu Knowledge Base của bạn       |
   | `MODEL_ID`                       | `anthropic.claude-3-sonnet-20240229-v1:0` | Chỉ định text generation model          |
   | `SLACK_BOT_TOKEN_PARAMETER`      | `/slack/bot-token5/parameter5`            | Parameter Store path cho bot token      |
   | `SLACK_SIGNING_SECRET_PARAMETER` | `/slack-bot/signing-secret5/parameter5`   | Parameter Store path cho signing secret |
   | `AWS_REGION`                     | `us-east-1`                               | AWS region cho service calls            |
   | `GUARDRAIL_ID`                   | `your-guardrail-id `                      | Tham chiếu guardrail của bạn            |
   | `SLACK_SLASH_COMMAND`            | `/ask-ai`                                 | slash command đã tạo lúc đầu            |

   ![lambda14](/images/7-lambda_implementation/7.2-config_code/lambda14-.png?width=90pc)
   ![lambda15](/images/7-lambda_implementation/7.2-config_code/lambda15-.png?width=90pc)

**Required Values**

Thay thế các placeholder values này bằng cấu hình thực tế của bạn:

- **KNOWLEDGE_BASE_ID**: Sao chép từ Bedrock Knowledge Base của bạn (Module 6.3)
- **MODEL_ID**: Sử dụng chính xác Claude 3 Sonnet model ID hiển thị ở trên
- **Parameter paths**: Phải khớp với cấu hình Parameter Store của bạn (Module 4.2)

{{% notice warning %}}
**Quan trọng:** Đảm bảo tất cả environment variable values khớp với AWS resources thực tế của bạn. Giá trị không chính xác sẽ gây ra runtime errors.
{{% /notice %}}

#### Tóm tắt Function Configuration

**1. Runtime Settings**

- ✅ **Function name**: BedrockKBSlackbotFunction5
- ✅ **Runtime**: Python 3.12
- ✅ **Handler**: lambda_function.lambda_handler
- ✅ **Memory**: 512 MB
- ✅ **Timeout**: 5 phút

**2. Security Settings**

- ✅ **Execution role**: BedrockExecutionRole8888
- ✅ **Environment variables**: Được cấu hình với giá trị phù hợp
- ✅ **Code package**: Đã upload với dependencies

#### Tiếp theo là gì

Lambda function của bạn hiện đã được cấu hình và sẵn sàng xử lý Slack commands. Tiếp theo, chúng ta sẽ tạo API Gateway sẽ nhận requests từ Slack và trigger Lambda function của bạn.

---

**Tiếp tục đến**: [8. Tích hợp API Gateway và Kiểm thử](../../8-api_gateway/)
