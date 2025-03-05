data "aws_vpc" "asap-tech-vpc" {
  id = "vpc-06c5c096a6bedaa72"
}

data "aws_subnet" "asap-tech-private-subnet" {
  id = "subnet-097622b2bded04bb9"
}

data "aws_security_group" "terraform-20250304081417935200000001" {
  id = "sg-0155206ac1d6afd98"
}