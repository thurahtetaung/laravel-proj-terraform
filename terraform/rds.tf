resource "aws_db_subnet_group" "db_subnet_group" {
  name       = "${var.project_name}-db-subnet"
  subnet_ids = aws_subnet.private[*].id

  tags = {
    Name        = "${var.project_name}-db-subnet"
    Environment = var.environment
  }
}

# Parameter Group
resource "aws_rds_cluster_parameter_group" "aurora_cluster_parameter_group" {
  family = "aurora-mysql8.0"  # Change to aurora-postgresql13 if using PostgreSQL
  name   = "aurora-cluster-parameter-group"

  parameter {
    name  = "character_set_server"
    value = "utf8mb4"
  }

  parameter {
    name  = "character_set_database"
    value = "utf8mb4"
  }
}

// aurora db cluster with 1 instance
resource "aws_rds_cluster" "db_cluster" {
  cluster_identifier              = "${var.project_name}-${var.environment}-db-cluster"
  engine                          = "aurora-mysql"
  engine_mode                     = "provisioned"
  engine_version                  = "${var.db_enginer_version}"
  database_name                   = "${var.project_name}-${var.environment}"
  master_username                 = "admin"
  master_password                 = var.db_password
  db_subnet_group_name            = aws_db_subnet_group.db_subnet_group.name
  db_cluster_parameter_group_name = aws_rds_cluster_parameter_group.aurora_cluster_parameter_group.name
  vpc_security_group_ids          = [aws_security_group.db.id]

  serverlessv2_scaling_configuration {
    min_capacity = 0.5
    max_capacity = 32
  }
  tags = {
    Name        = "${var.project_name}-${var.environment}-db-cluster"
    Environment = var.environment
  }
}

resource "aws_rds_cluster_instance" "db_instance" {
  count              = 1
  cluster_identifier = aws_rds_cluster.db_cluster.id
  auto_minor_version_upgrade = true
  instance_class     = "${var.db_instance_class}"
  engine             = aws_rds_cluster.db_cluster.engine
  engine_version     = aws_rds_cluster.db_cluster.engine_version
  identifier         = "${var.project_name}-${var.environment}-db-instance-${count.index}"
  publicly_accessible = var.db_publicly_accessible
  tags = {
    Name        = "${var.project_name}-db-instance-${count.index}"
    Environment = var.environment
  }
}

