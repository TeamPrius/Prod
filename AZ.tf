#Create ProdVPC
resource "aws_vpc" "prod_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true

  tags = {
    Name = "Prod VPC"
  }
}

#Create Presentation Layer Public Subnet 1
resource "aws_subnet" "public1" {
  vpc_id                  = aws_vpc.prod_vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "Public Subnet 1"
  }
}


#Create Business Logic Layer Private Subnet 1

resource "aws_subnet" "private1" {
  vpc_id            = aws_vpc.prod_vpc.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "Private Subnet 1"
  }
}

#Create Data Storage Layer Private Subnet 2

resource "aws_subnet" "private2" {
  vpc_id            = aws_vpc.prod_vpc.id
  cidr_block        = "10.0.3.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "Private Subnet 2"
  }
}




#Create Internet Gateway
resource "aws_internet_gateway" "prod_vpcigw" {
  vpc_id = aws_vpc.prod_vpc.id

  tags = {
    Name = "Prod VPC IGW"
  }
}



#Create Public Route Table for Public Subnet 1
resource "aws_route_table" "publicroute1" {
  vpc_id = aws_vpc.prod_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.prod_vpcigw.id
  }

  tags = {
    Name = "PublicRouteTable1"
  }
}


#Create Private Route Table for Private Subnet 1
resource "aws_route_table" "pvtroute1" {
  vpc_id = aws_vpc.prod_vpc.id

route {
cidr_block = "0.0.0.0/0"
nat_gateway_id = aws_nat_gateway.nat.id
}


  tags = {
    Name = "PrivateRouteTable1"
  }
}


#Create Private Route Table for Private Subnet 2 
resource "aws_route_table" "pvtroute2" {
  vpc_id = aws_vpc.prod_vpc.id


  tags = {
    Name = "PrivateRouteTable2"
  }
}




#Create Public Route table1 association


resource "aws_route_table_association" "publicrta1" {
  subnet_id      = aws_subnet.publicroute1.id
  route_table_id = aws_route_table.publicroute1.id
}


#Create Private Route table1 association


resource "aws_route_table_association" "pvtrta1" {
  subnet_id      = aws_subnet.pvtroute1.id
  route_table_id = aws_route_table.pvtroute1.id
}

#Create Private Route table2 association


resource "aws_route_table_association" "pvtrta2" {
  subnet_id      = aws_subnet.pvtroute2.id
  route_table_id = aws_route_table.pvtroute2.id
}



#Create NAT Gateway
resource "aws_nat_gateway" "nat" {
allocation_id = aws_eip.nat.id
subnet_id = aws_subnet.public1.id

tags = {
Name = "gw NAT"
}



#Allocate Elastic IP for NAT Gateway
resource "aws_eip" "nat" {
vpc = true
}





#Create Security Group
resource "aws_security_group" "appsg" {
  name        = "app_sg"
  description = "Allow inbound HTTP traffic"
  vpc_id      = aws_vpc.prod_vpc.id

  tags = {
    Name = "App-SG"
  }
}

#Inbound rule
resource "aws_vpc_security_group_ingress_rule" "allow_http" {
  security_group_id = aws_security_group.appsg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}


#Outbound rule
resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.appsg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

# Define default Network ACL 

resource "aws_network_acl" nacl1" {
  vpc_id = aws_vpc.prod_vpc.id

  egress {
    protocol   = "tcp"
    rule_no    = 200
    action     = "allow"
    cidr_block = "10.0.1.0/24"
    from_port  = 80
    to_port    = 80
  }

  ingress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = "10.0.1.0/24"
    from_port  = 80
    to_port    = 80
  }

  tags = {
    Name = "NACL 1"
  }
}



#Define EC2 Instance for Presentation Layer


resource "aws_instance" "web_tier" {
  ami           = "ami-0e731c8a588258d0d"
  instance_type = "t2.micro"


  subnet_id              = aws_subnet.public1.id
  availability_zone      = "us-east-1a"
  vpc_security_group_ids = [aws_security_group.appsg.id]



  user_data = file("userdata.sh")

  tags = {
    Name = "App Server"
  }

}


# Create auto-scaling group
resource "aws_autoscaling_group" "auto_scaling_group" {
  name                 = "prod_vpc_asg"
  launch_configuration = aws_launch_configuration.auto_scaling_group.id
  min_size             = 1
  max_size             = 5
  desired_capacity     = 2
  vpc_zone_identifier  = [aws_subnet.pvtroute1.id]
}




#Define EC2 Instance for Business Logic Layer with auto-scaling enabled


