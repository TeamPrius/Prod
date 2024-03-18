# create VPC

resource "aws_vpc" "prod_vpc" {
  cidr_block = "10.0.0.0/16"  # cidr block of vpc
  enable_dns_hostnames = true

  tags = {
    Name = "Production VPC"
  }
}
##########################################################################################


# Availability Zone 1 Information

# create public subnet 1 for Jump Tier

resource "aws_subnet" "public_subnet_1" {
  vpc_id                  = aws_vpc.prod_vpc.id  # get vpc id
  cidr_block              = "10.0.1.0/24"        # cidr block of public subnet 1
  availability_zone       = "us-east-1a"         # availability zone of public subnet 1
  map_public_ip_on_launch = true

  tags = {
    Name = "Production Area Public Subnet 1"
  }
}


# create private subnet 1 for Business Logic Layer

resource "aws_subnet" "private_subnet_1" {
  vpc_id                  = aws_vpc.prod_vpc.id  # get vpc id
  cidr_block              = "10.0.2.0/24"        # cidr block of private subnet 1
  availability_zone       = "us-east-1a"         # availability zone of private subnet 1
  map_public_ip_on_launch = false

  tags = {
    Name = "Production Area Private Subnet 1"
  }
}


# create private subnet 2 for Data Storage Layer

resource "aws_subnet" "private_subnet_2" {
  vpc_id                  = aws_vpc.prod_vpc.id  # get vpc id
  cidr_block              = "10.0.3.0/24"        # cidr block of private subnet 2
  availability_zone       = "us-east-1a"         # availability zone of private subnet 2
  map_public_ip_on_launch = false

  tags = {
    Name = "Production Area Private Subnet 2"
  }
}
##########################################################################################



# Availability Zone 2 Information

# create public subnet 2 for Jump Tier

resource "aws_subnet" "public_subnet_2" {
  vpc_id                  = aws_vpc.prod_vpc.id    # get vpc id
  cidr_block              = "10.0.4.0/24"          # cidr block of public subnet 2
  availability_zone       = "us-east-1b"           # availability zone of public subnet 2
  map_public_ip_on_launch = true

  tags = {
    Name = "Production Area Public Subnet 2"
  }
}


# create private subnet 3 for Business Logic Layer

resource "aws_subnet" "private_subnet_3" {
  vpc_id                  = aws_vpc.prod_vpc.id  # get vpc id
  cidr_block              = "10.0.5.0/24"        # cidr block of private subnet 3
  availability_zone       = "us-east-1b"         # availability zone of private subnet 3
  map_public_ip_on_launch = false

  tags = {
    Name = "Production Area Private Subnet 3"
  }
}


# create private subnet 4 for Data Storage Layer

resource "aws_subnet" "private_subnet_4" {
  vpc_id                  = aws_vpc.prod_vpc.id  # get vpc id
  cidr_block              = "10.0.6.0/24"        # cidr block of private subnet 4
  availability_zone       = "us-east-1b"         # availability zone of private subnet 4
  map_public_ip_on_launch = false

  tags = {
    Name = "Production Area Private Subnet 4"
  }
}
##########################################################################################