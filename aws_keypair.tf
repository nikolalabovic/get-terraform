resource "aws_key_pair" "test_key" {
  key_name   = "testkey"
  public_key = file("~/.ssh/test_key.pub")
}