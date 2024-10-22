resource "aws_security_group" "test_sg" {
  name        = "test_sg"
  description = "test security group"
  vpc_id      = aws_vpc.test_vpc.id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["178.253.192.204/32","0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "test_sg"
  }
}

resource "aws_security_group" "sg" {
  name        = "db_sg"
  description = "Default sg for the database"
  vpc_id      = aws_vpc.test_vpc.id

  tags = {
    Name = "db_sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_tls_ipv4" {
  security_group_id            = aws_security_group.sg.id
  referenced_security_group_id = aws_security_group.test_sg.id
  from_port                    = 5432
  ip_protocol                  = "tcp"
  to_port                      = 5432
}