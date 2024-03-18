# create internet gateway
resource "aws_internet_gateway" "prod_vpcigw" {
  vpc_id = aws_vpc.prod_vpc.id

  tags = {
    Name = "Production VPC Internet Gateway"
  }
}



