resource "aws_vpc" "asap-tech-vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "asap-tech-vpc"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.asap-tech-vpc.id

  tags = {
    Name = "asap-tech-igw"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.asap-tech-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "public-route-table"
  }
}

resource "aws_subnet" "asap-tech-public-subnet-1" {
  vpc_id                  = aws_vpc.asap-tech-vpc.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true
  tags = {
    Name = "asap-tech-public-subnet-1"
  }
}

resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.asap-tech-public-subnet-1.id
  route_table_id = aws_route_table.public.id
}

resource "aws_eip" "nat" {
  domain = "vpc"

  tags = {
    Name = "nat-eip"
  }
}

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.asap-tech-public-subnet-1.id

  tags = {
    Name = "nat-gateway"
  }
}

resource "aws_subnet" "asap-tech-private_subnet" {
  vpc_id            = aws_vpc.asap-tech-vpc.id
  cidr_block        = "10.0.3.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "asap-tech-private-subnet"
  }
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.asap-tech-vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat.id
  }

  tags = {
    Name = "private-route-table"
  }
}

resource "aws_route_table_association" "private" {
  subnet_id      = aws_subnet.asap-tech-private_subnet.id
  route_table_id = aws_route_table.private.id
}


resource "aws_security_group" "allow_app" {
  vpc_id = aws_vpc.asap-tech-vpc.id

  egress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
  }

  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
  }

  tags = {
    Name = "allow-app"
  }
}
