# create EC2 instances

# Presentation Layer


# Availability Zone 1


resource "aws_instance" "jump_tier_availability_zone_1" {
  ami                         = data.aws_ami.amazonlinux2023.id                                      # ami
  instance_type               = "t2.micro"                                                           # ami instance type
  subnet_id                   = aws_subnet.public_subnet_1.id                                        # get public subnet id
  availability_zone           = "us-east-1a"                                                         # get availability zone
  associate_public_ip_address = true                                                                 # gives public ip address
  vpc_security_group_ids      = [aws_security_group.appsg.id]

  tags = {
    Name = "Jump Tier Availability Zone 1"
  }
}



# Availability Zone 2


resource "aws_instance" "jump_tier_availability_zone_2" {
  ami                         = data.aws_ami.amazonlinux2023.id                                      # ami
  instance_type               = "t2.micro"                                                           # ami instance type
  subnet_id                   = aws_subnet.public_subnet_2.id                                        # get public subnet id
  availability_zone           = "us-east-1b"                                                         # get availability zone
  associate_public_ip_address = true                                                                 # gives public ip address
  vpc_security_group_ids      = [aws_security_group.presentation_layer_sg_availability_zone_2.id]    # get security group id

  tags = {
    Name = "Jump Tier Availability Zone 2"  # creates name
  }
}
###########################################################################################


# Business Logic Layer (we use launch templates to accomodate ebs volumes and autoscaling)


# Availability Zone 1


resource "aws_instance" "business_logic_tier_availability_zone_1" {
  ami                         = data.aws_ami.amazonlinux2023.id                                        # ami
  instance_type               = "t2.micro"                                                             # ami instance type
  subnet_id                   = aws_subnet.private_subnet_1.id                                         # get subnet id
  availability_zone           = "us-east-1a"                                                           # get availability zone
  associate_public_ip_address = true                                                                   # gives public ip address
  vpc_security_group_ids      = [aws_security_group.appsg.id]    # get security group id

  user_data                   = filebase64("./userdata.sh") 
  metadata_options {
    http_tokens = "optional"  # optional tokens
    http_endpoint = "enabled"
  }

  tags = {
    Name = "Business Logic Layer Availability Zone 1"  # creates name
  }
}


# Availability Zone 2


resource "aws_instance" "business_logic_tier_availability_zone_2" {
  ami                         = data.aws_ami.amazonlinux2023.id                                        # ami
  instance_type               = "t2.micro"                                                             # ami instance type
  subnet_id                   = aws_subnet.private_subnet_3.id                                         # get public subnet id
  availability_zone           = "us-east-1b"                                                           # get availability zone
  associate_public_ip_address = true                                                                   # gives public ip address
  vpc_security_group_ids      = [aws_security_group.business_logic_layer_sg_availability_zone_2.id]    # get security group id

  user_data                   = filebase64("./userdata.sh") 
  metadata_options {
    http_tokens = "optional"  # optional tokens
    http_endpoint = "enabled"
  }

  tags = {
    Name = "Business Logic Layer Availability Zone 2"  # creates name
  }
}