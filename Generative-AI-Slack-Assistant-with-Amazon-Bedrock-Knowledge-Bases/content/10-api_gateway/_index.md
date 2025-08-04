+++
title = "API Gateway"
date = 2020-05-14T00:38:32+07:00
weight = 10
chapter = false
pre = "<b>10. </b>"
+++

1. Access to [API console](https://us-east-1.console.aws.amazon.com/apigateway)
   ![api0](/images/10/api0.png?width=90pc)

2. Create **Rest API** and name
   ![api1](/images/10/api1.png?width=90pc)
   ![api2](/images/10/api2.png?width=90pc)

3. Create resource named **slack**
   ![api3](/images/10/api3.png?width=90pc)

4. Create another source named **ask-ai**
   ![api4](/images/10/api4.png?width=90pc)

5. Create method for **ask-ai**
   ![api5](/images/10/api5.png?width=90pc)

6. Settings with method:
- Method: **POST**
- Lambda proxy integration: **enable**
- Lambda function: **BedrockKbSlackbotFunction5**
  ![api6](/images/10/api6.png?width=90pc)
  ![api7](/images/10/api7.png?width=90pc)

7. Deploy with new stage named **prod**
   ![api8](/images/10/api8.png?width=90pc)

8. Get the **Invoke URL** and replace it with the **Request URL** box in **Slack**. Choose **Save**
   ![api9](/images/10/api9.png?width=90pc)

9. Access to **Slash commands** again and replace **Request URL**. Finally, click **Save**
   ![api10](/images/10/api10.png?width=90pc)
   