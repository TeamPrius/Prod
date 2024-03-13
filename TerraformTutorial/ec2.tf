resource "aws_instance" "app_server" {
  ami           = "ami-0c7217cdde317cfec"
  instance_type = "t2.micro"
  tags = {
    Name = "AppServerInstance"
  }
}

output "instance_id" {
  description = "ID of the EC2 instance"
  value       = aws_instance.app_server.id
}

output "instance_public_ip" {
  description = "Public IP address of the EC2 instance"
  value       = aws_instance.app_server.public_ip
}

variable "instance_name" {
  description = "Value of the Name tag for the EC2 instance"
  type        = string
  default     = "Jazz"
}
