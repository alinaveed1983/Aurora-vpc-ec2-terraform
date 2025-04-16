# ================================
# modules/aurora_mysql/main.tf
# ================================
data "aws_secretsmanager_secret_version" "aurora" {
  secret_id = var.secret_arn
}

locals {
  secret_data = jsondecode(data.aws_secretsmanager_secret_version.aurora.secret_string)
}


resource "aws_db_subnet_group" "this" {
  name       = "${var.db_cluster_identifier}-subnet-group"
  subnet_ids = var.subnet_ids
}

resource "aws_rds_cluster" "this" {
  cluster_identifier      = var.db_cluster_identifier
  engine                  = "aurora-mysql"
  engine_version          = var.engine_version
  master_username         = local.secret_data.username
  master_password         = local.secret_data.password
  database_name           = var.db_name
  backup_retention_period = var.backup_retention_period
  db_subnet_group_name    = aws_db_subnet_group.this.name
  vpc_security_group_ids  = var.vpc_security_group_ids
  skip_final_snapshot     = true
}

resource "aws_rds_cluster_instance" "instance" {
  count              = 2
  identifier         = "${var.db_cluster_identifier}-instance-${count.index + 1}"
  cluster_identifier = aws_rds_cluster.this.id
  instance_class     = var.instance_class
  engine             = aws_rds_cluster.this.engine
}