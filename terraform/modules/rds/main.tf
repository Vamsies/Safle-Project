resource "aws_db_subnet_group" "db" {
  name       = "${var.app_name}-subnet-group"
  subnet_ids = var.subnet_ids
}

resource "aws_db_instance" "postgres" {
  identifier              = "${var.app_name}-db"
  allocated_storage       = 20
  engine                  = "postgres"
  engine_version          = "14.4"
  instance_class          = "db.t3.micro"
  name                    = "${var.app_name}_db"
  username                = var.db_username
  password                = var.db_password
  skip_final_snapshot     = true
  vpc_security_group_ids  = var.security_group_ids
  db_subnet_group_name    = aws_db_subnet_group.db.name
  publicly_accessible     = false
  multi_az                = false
}
