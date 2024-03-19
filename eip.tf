# create elastic ip addresses for NAT Gateway

# Availability Zone 1
resource "aws_eip" "eip_availability_zone_1" {
  depends_on = [
    aws_route_table_association.pres_layer_rta
  ]
<<<<<<< HEAD
  vpc        = true
  associate_with_private_ip = "10.0.0.6"
=======
  vpc = true
>>>>>>> e923f4cd65d1312745e5a5550d4ee1366beb991f
}



# Availability Zone 2
resource "aws_eip" "eip_availability_zone_2" {
  depends_on = [
    aws_route_table_association.pres_layer_rta
  ]
<<<<<<< HEAD
  vpc        = true
  associate_with_private_ip = "10.0.0.7"
=======
  vpc = true
>>>>>>> e923f4cd65d1312745e5a5550d4ee1366beb991f
}



