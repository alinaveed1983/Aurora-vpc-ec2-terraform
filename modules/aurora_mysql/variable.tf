# ================================
# modules/aurora_mysql/variables.tf
# ================================
variable "db_cluster_identifier" {}

variable "engine_version" {
  default = "8.0.mysql_aurora.3.04.0"
}

variable "instance_class" {
  default = "db.t3.medium"
}

variable "db_name" {}

variable "subnet_ids" {
  type = list(string)
}

variable "vpc_security_group_ids" {
  type = list(string)
}

variable "backup_retention_period" {
  default = 7
}

variable "secret_arn" {
  description = "ARN of the secret storing DB credentials"
  type        = string
}