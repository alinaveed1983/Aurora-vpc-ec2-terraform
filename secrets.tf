resource "aws_secretsmanager_secret" "aurora" {
  name = "aurora-admin-password"
}

resource "aws_secretsmanager_secret_version" "aurora" {
  secret_id     = aws_secretsmanager_secret.aurora.id
  secret_string = jsonencode({
    username = "admin"
    password = "Aur0raRds#Db2025"
  })
}