# ================================
# root/main.tf
# ================================
module "vpc" {
  source                  = "./modules/vpc"
  vpc_cidr_block          = var.vpc_cidr_block
  vpc_name                = var.vpc_name
  public_subnet_1_cidr    = var.public_subnet_1_cidr
  public_subnet_2_cidr    = var.public_subnet_2_cidr
  private_subnet_1_cidr   = var.private_subnet_1_cidr
  private_subnet_2_cidr   = var.private_subnet_2_cidr
  nat_gw_name             = var.nat_gw_name
  igw_name                = var.igw_name
  main_rt_name            = var.main_rt_name
  private_rt_name         = var.private_rt_name
}

module "ssm_role" {
  source    = "./modules/ssm_role"
  role_name = "EC2-ssm-role"
}

module "bastion_sg" {
  source      = "./modules/security_group"
  name        = "bastion-sg"
  description = "Allow egress"
  vpc_id      = module.vpc.vpc_id
  ingress_rules = []
  egress_rules = [{
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }]
  tags = {
    Name = "bastion-sg"
  }
}

module "rds_sg" {
  source      = "./modules/security_group"
  name        = "rds-sg"
  description = "Allow MySQL from Bastion"
  vpc_id      = module.vpc.vpc_id
  ingress_rules = [{
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [module.bastion_sg.security_group_id]
  }]
  egress_rules = [{
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }]
  tags = {
    Name = "rds-sg"
  }
}

module "ec2_bastion_1" {
  source                = "./modules/ec2"
  ami_id                = var.ami_id
  instance_name         = var.instance_name
  instance_type         = var.instance_type
  subnet_id             = module.vpc.public_subnet_1_id
  instance_profile_name = module.ssm_role.instance_profile_name
  security_group_ids    = [module.bastion_sg.security_group_id]
}


module "aurora_mysql" {
  source                  = "./modules/aurora_mysql"
  db_cluster_identifier   = "aurora-mysql-dev"
  db_name                 = "appdb"
  engine_version          = "8.0.mysql_aurora.3.04.0"
  instance_class          = "db.t3.medium"
  subnet_ids              = [module.vpc.private_subnet_1_id, module.vpc.private_subnet_2_id]
  vpc_security_group_ids  = [module.rds_sg.security_group_id]
  secret_arn              = aws_secretsmanager_secret.aurora.arn
}

/*
module "ec2_bastion_1" {
  source                = "./modules/ec2"
  ami_id                = var.ami_id_2
  instance_name         = var.instance_name_2
  instance_type         = var.instance_type_2
  subnet_id             = module.vpc.public_subnet_1_id
  instance_profile_name = module.ssm_role.instance_profile_name
  security_group_ids    = [module.bastion_sg.security_group_id]
}
*/
