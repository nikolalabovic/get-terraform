resource "aws_sns_topic" "hello_world_topic" {
  name = "hello-world-topic"
}

resource "aws_sns_topic_subscription" "sns_subscription" {
  topic_arn = aws_sns_topic.hello_world_topic.arn
  protocol  = "email"
  endpoint  = "nikolalabovicpn@gmail.com"
}