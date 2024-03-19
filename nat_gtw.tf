# Create nat gateways

# Availability Zone 1

resource "aws_nat_gateway" "nat_gw_availability_zone_1" {
  allocation_id = aws_eip.eip_availability_zone_1.id
  subnet_id     = aws_subnet.public_subnet_1.id

  tags = {
    Name = "nat gateway availability zone 1"
  }
}



# Availability Zone 2

# create nat gateway
resource "aws_nat_gateway" "nat_gw_availability_zone_2" {
  allocation_id = aws_eip.eip_availability_zone_2.id
  subnet_id     = aws_subnet.public_subnet_2.id

  tags = {
    Name = "nat gateway availability zone 2"
  }
}