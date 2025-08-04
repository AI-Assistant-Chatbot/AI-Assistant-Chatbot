+++
title = "Lambda role"
date = 2024-05-14T00:38:32+07:00
weight = 8
chapter = false
pre = "<b>8.1 </b>"
+++

#### Create a role named **BedrockExecutionRole8888**:
- Policy **AWSLambdaBasicExecutionRole**:
   ![lambda1](/images/8/lambda1.png?width=90pc)
- Add a custom policy named **BedrockExecutionPolicy**:
  
   ![lambda2](/images/8/lambda2.png?width=90pc)

   ```js
   {
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": [
                "bedrock:InvokeModel"
            ],
            "Effect": "Allow",
            "Resource": "arn:aws:bedrock:us-east-1::foundation-model/anthropic.claude-3-haiku-20240307-v1:0"
        },
        {
            "Action": [
                "bedrock:Retrieve",
                "bedrock:RetrieveAndGenerate"
            ],
            "Effect": "Allow",
            "Resource": "<YOUR-KNOWLEDGEBASE-ARN>"
        },
        {
            "Action": [
                "ssm:GetParameter"
            ],
            "Effect": "Allow",
            "Resource": [
                "<YOUR-SSM-ARN-1>",
                "<YOUR-SSM-ARN-1>"
            ]
        },
        {
            "Action": [
                "lambda:InvokeFunction"
            ],
            "Effect": "Allow",
            "Resource": "<YOUR-LAMBDA-FUNCTION-ARN>"
        },
        {
            "Action": [
                "bedrock:ApplyGuardrail"
            ],
            "Effect": "Allow",
            "Resource": "arn:aws:bedrock:us-east-1:<YOUR-ACCOUNT-ID>:guardrail/<YOUR-GUARDRAIL-ID>*"
        },
        {
            "Action": [
                "secretsmanager:GetSecretValue"
            ],
            "Effect": "Allow",
            "Resource": [
                "<YOUR-SECRET-BOT-TOKEN-ARN>",
                "<YOUR-SECRET-SIGNING-SECRET-ARN>"
            ]
        }
    ]
   }
   ```

   ![lambda3](/images/8/lambda3.png?width=90pc)

   ![lambda4](/images/8/lambda4.png?width=90pc)