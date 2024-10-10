resource "aws_vpc" "test_vpc" {
  cidr_block = "10.123.0.0/16"
  enable_dns_hostnames = true

}

resource "aws_subnet" "test_subnet" {
  vpc_id = aws_vpc.test_vpc.id
  cidr_block = "10.123.1.0/16"
  availability_zone = "eu-central-1"
}

resource "aws_internet_gateway" "test_gateway" {
  vpc_id = aws_vpc.test_vpc.id
}
