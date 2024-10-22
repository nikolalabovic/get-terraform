resource "aws_cloudwatch_event_rule" "daily_rule" {
  name        = "daily_rule"
  description = "Triggers every day at 1 AM"
  schedule_expression = "cron(0 23 * * ? *)" #utc
}

resource "aws_cloudwatch_event_target" "lambda_target" {
  rule      = aws_cloudwatch_event_rule.daily_rule.name
  target_id = "SendEmailLambda"
  arn       = aws_lambda_function.send_email.arn
}

# Add permissions for the event rule to invoke the Lambda function
resource "aws_lambda_permission" "allow_eventbridge" {
  statement_id  = "AllowExecutionFromEventBridge"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.send_email.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.daily_rule.arn
}