# create elastic ip addresses for NAT Gateway

# Availability Zone 1
resource "aws_eip" "eip_availability_zone_1" {
  depends_on = [aws_internet_gateway.prod_vpcigw]
  vpc        = true
  associate_with_private_ip = "10.0.0.6"
  vpc = true
}



# Availability Zone 2
resource "aws_eip" "eip_availability_zone_2" {
  depends_on = [aws_internet_gateway.prod_vpcigw]
  vpc        = true
  associate_with_private_ip = "10.0.0.7"
  vpc = true
}



