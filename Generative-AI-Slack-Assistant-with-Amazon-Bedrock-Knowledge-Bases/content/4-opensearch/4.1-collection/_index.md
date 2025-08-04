+++
title = "collection"
date = 2020-05-14T00:38:32+07:00
weight = 4
chapter = false
pre = "<b>4.1 </b>"
+++

1. Access to [Amazon Opensearch Service Console.](https://us-east-1.console.aws.amazon.com/aos/home?region=us-east-1#opensearch)
   ![opensearch1](/images/4/opensearch1.png?width=90pc)

2. Scroll down and select **Data access policies** and click **create access policy**
    ![opensearch8](/images/4/opensearch8.png?width=90pc)

3. Enter **Access policy name** -> choose **JSON**
    ![opensearch9](/images/4/opensearch9.png?width=90pc)

4. Enter the following code
```json
[
  {
    "Rules": [
      {
        "ResourceType": "index",
        "Resource": ["index/<YOUR-OPENSEARCH-COLLECTION-NAME>/*"],
        "Permission": ["aoss:*"]
      },
      {
        "ResourceType": "collection",
        "Resource": ["collection/<YOUR-OPENSEARCH-COLLECTION-NAME>"],
        "Permission": ["aoss:*"]
      }
    ],
    "Principal": ["arn:aws:iam::<YOUR-ACCOUNT-ID>:root"]
  }
]
```

![opensearch10](/images/4/opensearch10.png?width=90pc)


5. Create networks policy
    ![opensearch11](/images/4/opensearch11.png?width=90pc)

6. Name **Network policy name**
    ![opensearch12](/images/4/opensearch12.png?width=90pc)

7. Enter the following code
```json
[
  {
    "Rules": [
      {
        "ResourceType": "collection",
        "Resource": ["collection/<YOUR-OPENSEARCH-COLLECTION-NAME>"]
      },
      {
        "ResourceType": "dashboard",
        "Resource": ["collection/<YOUR-OPENSEARCH-COLLECTION-NAME>"]
      }
    ],
    "AllowFromPublic": true
  }
]
```
![opensearch13](/images/4/opensearch13.png?width=90pc)


8. Create **Collection**
- Select **Collections**
    ![opensearch2](/images/4/opensearch2.png?width=90pc)

- Select **Create Collection**
    ![opensearch3](/images/4/opensearch3.png?width=90pc)

- Enter **Collection name** and select **Collection type**: Vector search
    ![opensearch4](/images/4/opensearch4.png?width=90pc)

    ![opensearch5](/images/4/opensearch5.png?width=90pc)

- Default and create. **Note**:
    - **Collection ARN**
    - **Opensearch endpoint**
    ![opensearch14](/images/4/opensearch14.png?width=90pc)
    ![opensearch15](/images/4/opensearch15.png?width=90pc)
    ![opensearch16](/images/4/opensearch16.png?width=90pc)