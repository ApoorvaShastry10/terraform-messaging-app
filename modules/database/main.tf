resource "aws_db_instance" "db" {
  identifier              = "app-database"
  allocated_storage       = 20
  engine                  = "mysql"
  engine_version          = "8.0"
  instance_class          = "db.t3.micro"
  username                = "admin"
  password                = "password123"
  publicly_accessible     = false
  vpc_security_group_ids  = var.security_group_ids
  db_subnet_group_name = aws_db_subnet_group.db_subnet_group.name
  skip_final_snapshot     = true
}


resource "aws_db_subnet_group" "db_subnet_group" {
  name       = "my-db-subnet-group"
  subnet_ids = var.subnet_ids  # Make sure subnets belong to the same VPC as the EC2 SG
  
  tags = {
    Name = "my-db-subnet-group"
  }
}