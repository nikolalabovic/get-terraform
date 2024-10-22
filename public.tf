
resource "aws_subnet" "public_subnet_a" {
  vpc_id                  = aws_vpc.test_vpc.id
  cidr_block              = "10.123.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "eu-central-1a"

  tags = {
    Name = "test-public-a"
  }
}

resource "aws_subnet" "public_subnet_b" {
  vpc_id                  = aws_vpc.test_vpc.id
  cidr_block              = "10.123.2.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "eu-central-1b"

  tags = {
    Name = "test-public-b"
  }
}

resource "aws_eip" "eip_a" {
  tags = {
    Name = "eip-a"
  }
}

resource "aws_eip" "eip_b" {
  tags = {
    Name = "eip-b"
  }
}

resource "aws_nat_gateway" "nat-gw-2a-public" {
  allocation_id = aws_eip.eip_a.id
  subnet_id     = aws_subnet.public_subnet_a.id
  depends_on    = [aws_eip.eip_a]

  tags = {
    Name = "nat-gw-2a-public"
  }
}

resource "aws_nat_gateway" "nat-gw-2b-public" {
  allocation_id = aws_eip.eip_b.id
  subnet_id     = aws_subnet.public_subnet_b.id
  depends_on    = [aws_eip.eip_b]

  tags = {
    Name = "nat-gw-2b-public"
  }
}


resource "aws_internet_gateway" "test_gateway" {
  vpc_id = aws_vpc.test_vpc.id

  tags = {
    Name = "test-igw"
  }
}
#we need route table to route traffic from our subnet to internet gateway
resource "aws_route_table" "rt_public_a" {
  vpc_id = aws_vpc.test_vpc.id

  tags = {
    Name = "test-rt-public-a"
  }
}

resource "aws_route" "route_a" {
  route_table_id         = aws_route_table.rt_public_a.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.test_gateway.id
}
#create an association between route table and a subnet
resource "aws_route_table_association" "rt_assoc_public_a" {
  subnet_id      = aws_subnet.public_subnet_a.id
  route_table_id = aws_route_table.rt_public_a.id
}
####
resource "aws_route_table" "rt_public_b" {
  vpc_id = aws_vpc.test_vpc.id

  tags = {
    Name = "test-rt-public-b"
  }
}

resource "aws_route" "route_b" {
  route_table_id         = aws_route_table.rt_public_b.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.test_gateway.id
}
#create an association between route table and a subnet
resource "aws_route_table_association" "rt_assoc_public_b" {
  subnet_id      = aws_subnet.public_subnet_b.id
  route_table_id = aws_route_table.rt_public_b.id
}