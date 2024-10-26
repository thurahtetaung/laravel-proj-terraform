resource "aws_db_subnet_group" "db_subnet_group" {
  name       = "${var.project_name}-db-subnet"
  subnet_ids = aws_subnet.private[*].id

  tags = {
    Name        = "${var.project_name}-db-subnet"
    Environment = var.environment
  }
}

resource "aws_db_instance" "db" {
  identifier           = "${var.project_name}-db"
  allocated_storage    = var.db_storage_size
  storage_type         = "gp3"
  engine              = "mysql"
  engine_version      = "8.0"
  instance_class      = "${var.db_instance_class}"
  db_name             = var.project_name
  username            = var.project_name
  password            = var.db_password
  skip_final_snapshot = true
  multi_az               = false
  publicly_accessible = var.db_publicly_accessible
  vpc_security_group_ids = [aws_security_group.db.id]
  db_subnet_group_name   = aws_db_subnet_group.db_subnet_group.name
  tags = {
    Name        = "${var.project_name}-db"
    Environment = var.environment
  }
}