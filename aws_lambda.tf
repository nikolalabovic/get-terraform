resource "aws_lambda_function" "send_email" {
  function_name = "send_email_function"
  handler       = "lambda_function.lambda_handler"
  runtime       = "python3.9"
  role          = aws_iam_role.lambda_exec_role.arn
  filename      = "lambda_function.zip"


  environment {
    variables = {
      SNS_TOPIC_ARN = aws_sns_topic.hello_world_topic.arn
    }
  }
}


