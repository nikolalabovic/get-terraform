import os
import boto3

def lambda_handler(event, context):
    sns_client = boto3.client('sns')
    message = "Hello World"
    topic_arn = os.environ['SNS_TOPIC_ARN']

    respone = sns_client.publish(
        TopicArn=topic_arn,
        Message=message,
        Subject="Daily Hello World"
    )
