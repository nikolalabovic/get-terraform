resource "aws_instance" "test_node" {
  ami                    = data.aws_ami.server_ami.id
  instance_type          = "t2.micro"
  key_name               = aws_key_pair.test_key.id
  vpc_security_group_ids = [aws_security_group.test_sg.id]
  subnet_id              = aws_subnet.public_subnet_a.id
  user_data              = file("userdata.tpl")


  lifecycle {
    ignore_changes = [ami]
  }

  tags = {
    Name        = "test-ec2"
    Description = "Test instance"
    CostCenter  = "123456"
  }
}