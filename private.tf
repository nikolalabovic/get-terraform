resource "aws_subnet" "private_a" {
  vpc_id                  = aws_vpc.test_vpc.id
  cidr_block              = "10.123.4.0/24"
  map_public_ip_on_launch = false
  availability_zone       = "eu-central-1a"

  tags = {
    Name = "test-private-a"
  }
}

resource "aws_subnet" "private_b" {
  vpc_id                  = aws_vpc.test_vpc.id
  cidr_block              = "10.123.5.0/24"
  map_public_ip_on_launch = false
  availability_zone       = "eu-central-1b"

  tags = {
    Name = "test-private-b"
  }
}

resource "aws_route_table" "rt_private_a" {
  vpc_id = aws_vpc.test_vpc.id
  tags = {
    Name = "test-rt-private-a"
  }
}

resource "aws_route_table_association" "rt_assoc_private_a" {
  subnet_id      = aws_subnet.private_a.id
  route_table_id = aws_route_table.rt_private_a.id
}

resource "aws_route" "route_pa" {
  route_table_id         = aws_route_table.rt_private_a.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat-gw-2a-public.id
}

resource "aws_route_table" "rt_private_b" {
  vpc_id = aws_vpc.test_vpc.id

  tags = {
    Name = "test-rt-private-b"
  }
}

resource "aws_route_table_association" "rt_assoc_private_b" {
  subnet_id      = aws_subnet.private_b.id
  route_table_id = aws_route_table.rt_private_b.id
}

resource "aws_route" "route_pb" {
  route_table_id         = aws_route_table.rt_private_b.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat-gw-2b-public.id
}