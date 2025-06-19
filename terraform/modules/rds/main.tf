resource "aws_db_instance" "default" {
  engine = "postgres"
  instance_class = "db.t3.micro"
  allocated_storage = 20
  name = "appdb"
  username = var.db_username
  password = var.db_password
  publicly_accessible = false
  vpc_security_group_ids = var.security_group_ids
  db_subnet_group_name = aws_db_subnet_group.default.name
  skip_final_snapshot = true
}
