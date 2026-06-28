terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.5"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

resource "random_password" "db_password" {
  length  = 16
  special = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

resource "aws_db_parameter_group" "postgres" {
  name   = "ai-perfumer-postgres-params"
  family = "postgres15"

  parameter {
    name  = "shared_preload_libraries"
    value = "pg_stat_statements"
  }
}

resource "aws_db_subnet_group" "default" {
  name       = "ai-perfumer-db-subnet-group"
  subnet_ids = var.private_subnet_ids

  tags = {
    Name = "ai-perfumer-db-subnet-group"
  }
}

resource "aws_security_group" "db" {
  name        = "ai-perfumer-db-sg"
  description = "Allow DB access from backend"
  vpc_id      = var.vpc_id

  ingress {
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    security_groups = [aws_security_group.backend.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_rds_cluster" "ai_perfumer" {
  cluster_identifier      = "ai-perfumer-db-cluster"
  engine                  = "aurora-postgresql"
  engine_version          = "15.4"
  master_username         = "ai_perfumer_admin"
  master_password         = random_password.db_password.result
  db_subnet_group_name    = aws_db_subnet_group.default.name
  vpc_security_group_ids  = [aws_security_group.db.id]
  skip_final_snapshot     = true
}

resource "aws_rds_cluster_instance" "cluster_instances" {
  count                = 2
  identifier           = "ai-perfumer-db-${count.index}"
  cluster_identifier   = aws_rds_cluster.ai_perfumer.id
  instance_class       = "db.t3.small"
  engine               = aws_rds_cluster.ai_perfumer.engine
  engine_version       = aws_rds_cluster.ai_perfumer.engine_version
  db_subnet_group_name = aws_db_subnet_group.default.name
}

resource "aws_security_group" "backend" {
  name        = "ai-perfumer-backend-sg"
  description = "Allow HTTP access"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_ecr_repository" "backend" {
  name                 = "ai-perfumer-backend"
  image_tag_mutability = "MUTABLE"
  
  image_scanning_configuration {
    scan_on_push = true
  }
}

output "db_cluster_endpoint" {
  description = "Database cluster endpoint"
  value       = aws_rds_cluster.ai_perfumer.endpoint
}

output "db_cluster_port" {
  description = "Database cluster port"
  value       = aws_rds_cluster.ai_perfumer.port
}

output "db_master_username" {
  description = "Database master username"
  value       = aws_rds_cluster.ai_perfumer.master_username
}

output "ecr_repository_url" {
  description = "ECR repository URL"
  value       = aws_ecr_repository.backend.repository_url
}
