# create autoscaling group

# Availability Zone 1
#
#resource "aws_autoscaling_group" "autoscaling_group_availability_zone_1" {
#  desired_capacity    = 1  # desired number of instances at a given time
#  max_size            = 1  # maximum number of instances group should have
#  min_size            = 1  # minimum number of instances group should have
#  vpc_zone_identifier = [aws_subnet.private_subnet_1.id]
#  target_group_arns   = [aws_lb_target_group.prod_vpclb_target_group.arn]
#
#  launch_template {
#    id      = aws_launch_template.web_lc.id
#    version = aws_launch_template.web_lc.latest_version
#  }
#}
#
#
#resource "aws_launch_template" "web_lc" {
#  name              = "Web-Server"
#  image_id          = "ami-0e731c8a588258d0d"
#  instance_type     = "t2.micro"
#
#  user_data         = filebase64("./userdata.sh")
#
#  block_device_mappings {
#    device_name = "/dev/sdf"
#
#    ebs {
#      volume_size = 5
#    }
#  }
#
#  network_interfaces {
#    associate_public_ip_address = false
#    subnet_id                   = aws_subnet.private_subnet_1.id
#    security_groups             = [aws_security_group.appsg.id]
#  }
#
#  tag_specifications {
#    resource_type = "instance"
#
#    tags = {
#      Name = "Launch template availability zone 2"
#    }
#  }
#}



# Availability Zone 2

#  autoscaling group
resource "aws_autoscaling_group" "autoscaling_group_availability_zone_2" {
  desired_capacity    = 1  # desired number of instances at a given time
  max_size            = 1  # maximum number of instances group should have
  min_size            = 1  # minimum number of instances group should have
  vpc_zone_identifier = [aws_subnet.private_subnet_1.id, aws_subnet.private_subnet_3.id]
  target_group_arns   = [aws_lb_target_group.prod_vpclb_target_group.arn]

  launch_template {
    id      = aws_launch_template.launch_template_availability_zone_2.id
    version = aws_launch_template.launch_template_availability_zone_2.latest_version
  }
}


# launch template
resource "aws_launch_template" "launch_template_availability_zone_2" {
  name          = "launch-template-availability-zone-2"
  image_id      = data.aws_ami.amazonlinux2023.id 
  instance_type = "t2.micro"
  user_data     = filebase64("./userdata.sh")

  block_device_mappings {
    device_name = "/dev/sdf"

    ebs {
      volume_size = 5
    }
  }

  network_interfaces {
    associate_public_ip_address = false
    subnet_id                   = aws_subnet.private_subnet_3.id
    security_groups             = [aws_security_group.business_logic_layer_sg_availability_zone_2.id]
  }

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "Launch template availability zone 2"
    }
  }
}