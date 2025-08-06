+++
title = "Connect and chat"
date = 2020-05-14T00:38:32+07:00
weight = 8
chapter = false
pre = "<b>8. </b>"
+++

#### API GATEWAY URL
1. Access to [API console](https://us-east-1.console.aws.amazon.com/apigateway)
   ![api0](/images/8/api0.png?width=90pc)

2. Create **Rest API** and name
   ![api1](/images/8/api1.png?width=91pc)
   ![api2](/images/8/api2.png?width=91pc)
   ![api2](/images/8/api2-.png?width=91pc)

3. Create resource named **slack**
   ![api3](/images/8/api3.png?width=91pc)

4. Create another source named **ask-ai**
   ![api4](/images/8/api4.png?width=91pc)
   

5. Create method for **ask-ai**
   ![api4](/images/8/api4-.png?width=91pc)
   

6. Settings with method:
- Method: **POST**
- Lambda proxy integration: **enable**
- Lambda function: **BedrockKbSlackbotFunction5**
  ![api5](/images/8/api5.png?width=91pc)
  ![api6](/images/8/api6.png?width=90pc)
  

7. Deploy with new stage named **prod**
   ![api7](/images/8/api7.png?width=90pc)
   

8. Get the **Invoke URL** and replace it with the **Request URL** box in **Slack**. Choose **Save**
   ![api8](/images/8/api8.png?width=90pc)

9. Access to **Slash commands** again and replace **Request URL**. Finally, click **Save**
   ![api9](/images/8/api9.png?width=90pc)

#### TESTING
1. Use Case 1: Chatbot successfully retrieves data from the Knowledge Base
   ![test1](/images/8/test1.png?width=90pc)
   ![test2](/images/8/test2.png?width=90pc)

2. Use Case 2: Chatbot cannot answer because the data is not present in the PDF
   ![test3](/images/8/test3.png?width=90pc)

3. Use Case 3: Chatbot cannot respond due to sensitive content blocked by AWS Bedrock Guardrails
   ![test4](/images/8/test4.png?width=90pc)
   ![test5](/images/8/test5.png?width=90pc)