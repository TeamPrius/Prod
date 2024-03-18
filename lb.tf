# create load balancer
resource "aws_lb" "prod_vpclb" {
  name               = "Application-Load-Balancer"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.lb_sg.id]
  subnets            = [aws_subnet.public_subnet_1.id, aws_subnet.public_subnet_2.id]
  depends_on         = [aws_nat_gateway.nat_gw_availability_zone_2]
}


# create load balancer target group
resource "aws_lb_target_group" "prod_vpclb_target_group" {
  name     = "prod-vpclb-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.prod_vpc.id
}


# create load balancer listener
resource "aws_lb_listener" "prod_vpclb_listener" {
  load_balancer_arn = aws_lb.prod_vpclb.arn
  port              = 80
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.prod_vpclb_target_group.arn
  }
}