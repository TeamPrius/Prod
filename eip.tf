# create elastic ip addresses for VPC

# Availability Zone 1
resource "aws_eip" "eip_availability_zone_1" {
  depends_on = [
    aws_route_table_association.pres_layer_rta
  ]
  vpc        = true
  associate_with_private_ip = "10.0.0.6"
}



# Availability Zone 2
resource "aws_eip" "eip_availability_zone_2" {
  depends_on = [
    aws_route_table_association.pres_layer_rta
  ]
  vpc        = true
  associate_with_private_ip = "10.0.0.7"
}



