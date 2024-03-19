# Presentation Layer Public Route Table For Public Subnet 1
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


#Create Public Route table1 association


resource "aws_route_table_association" "publicrta1" {
  subnet_id      = aws_subnet.public_subnet_1.id
  route_table_id = aws_route_table.publicroute1.id
}





# Presentation Layer Public Route Table For Public Subnet 2

resource "aws_route_table" "pres_layer_rt" {
  vpc_id = aws_vpc.prod_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.prod_vpcigw.id
  }
}


# create public route table association for public subnet 2

resource "aws_route_table_association" "pres_layer_rta" {
  subnet_id      = aws_subnet.public_subnet_2.id
  route_table_id = aws_route_table.pres_layer_rt.id
}



###########################################################################################


# Business Logic Layer Private Route Table For Private Subnet 3

resource "aws_route_table" "bus_log_layer_rt" {
  vpc_id = aws_vpc.prod_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.prod_vpcigw.id
  }
}


# create private route table association for Private Subnet 3

resource "aws_route_table_association" "bus_log_layer_rta" {
  subnet_id      = aws_subnet.private_subnet_3.id
  route_table_id = aws_route_table.bus_log_layer_rt.id
}


# Business Logic Layer Private Route Table For Private Subnet 1

resource "aws_route_table" "pvtroute1" {
  vpc_id = aws_vpc.prod_vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gw_availability_zone_1.id
  }


  tags = {
    Name = "PrivateRouteTable1"
  }
}

#Create Private Route table1 association


resource "aws_route_table_association" "pvtrta1" {
  subnet_id      = aws_subnet.private_subnet_1.id
  route_table_id = aws_route_table.pvtroute1.id
}


###########################################################################################




#Database Storage Layer Private Route Table for Private Subnet 2

resource "aws_route_table" "pvtroute2" {
  vpc_id = aws_vpc.prod_vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gw_availability_zone_1.id
  }


  tags = {
    Name = "PrivateRouteTable2"
  }
}


#Create Private Route table2 association for Private Subnet 2


resource "aws_route_table_association" "pvtrta2" {
  subnet_id      = aws_subnet.private_subnet_2.id
  route_table_id = aws_route_table.pvtroute2.id
}





# Database Storage Layer Private Route Table for Private Subnet 4
resource "aws_route_table" "data_stor_layer_rt" {
  vpc_id = aws_vpc.prod_vpc.id
}


# create private route table association for Private Subnet 4
resource "aws_route_table_association" "data_stor_layer_rta" {
  subnet_id      = aws_subnet.private_subnet_4.id
  route_table_id = aws_route_table.data_stor_layer_rt.id
}
###########################################################################################



