# create db subnet group for rds
resource "aws_db_subnet_group" "db_subnet_group" {
  name       = "db-subnet-group"
  subnet_ids = [aws_subnet.private_subnet_2.id, aws_subnet.private_subnet_4.id]

  tags = {
    Name = "DB subnet group for both availability zone 1 and 2"
  }
}