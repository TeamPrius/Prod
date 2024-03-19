# create rds instances


# RDS instance for availability zone 1
resource "aws_db_instance" "rds_instance" {
  allocated_storage = 5 # Storage for instance in gigabytes
  db_name           = "rds_availability_zone_1"
  availability_zone    = "us-east-1a" 
  engine            = "mysql"
  engine_version    = "5.7"
  instance_class    = "db.t2.micro"
  # manage_master_user_password   = true
  publicly_accessible = false
  #master_user_secret_kms_key_id  = aws_kms_key.prod_vpc_kms.key_id
  username               = "foo"
  password               = "foopasstest"
  multi_az               = true
  vpc_security_group_ids = [aws_security_group.rds_sg.id]
  db_subnet_group_name   = aws_db_subnet_group.db_subnet_group.id

  # skip final snapshot
  skip_final_snapshot = true
  apply_immediately   = true
}


# RDS instance for availability zone 2
resource "aws_db_instance" "rds_availability_zone_2" {
  # basic information
  db_name              = "rds_availability_zone_2"              # name of rds volume
  availability_zone    = "us-east-1b"                           # availability zone of rds volume
  db_subnet_group_name = aws_db_subnet_group.db_subnet_group.id # id of subnet rds volume is in
  engine               = "mysql"                                # we use mysql engine
  instance_class       = "db.t2.micro"                          # choose t2 micro instance class

  # storage information
  allocated_storage     = 5  # size of allocated storage in gb
  max_allocated_storage = 20 # max storage in gb

  # security information
  #deletion_protection    = true                                                               # protect against deletion of backup          =
  publicly_accessible    = false                                                             # prevent public access
  vpc_security_group_ids = [aws_security_group.data_storage_layer_sg_availability_zone_2.id] # get security group id

  # authentication
  username = "supersecurerdsusername" # username for rds volume
  password = "supersecurerdspassword" # password for rds volume

 

  # skip final snapshot
  skip_final_snapshot = true
  apply_immediately   = true
}