# EC2 for rds-bastion-1
ami_id        = "ami-00a929b66ed6e0de6"
instance_name = "rds-bastion-1"
instance_type = "t2.micro"

/*
# EC2 for rds-bastion-2
ami_id_2        = "ami-00a929b66ed6e0de6"
instance_name_2 = "rds-bastion-2"
instance_type_2 = "t3.large"
*/

# VPC 
vpc_cidr_block           = "10.1.0.0/26"
vpc_name                 = "my-prod-vpc1"
public_subnet_1_cidr     = "10.1.0.0/28"
public_subnet_2_cidr     = "10.1.0.16/28"
private_subnet_1_cidr    = "10.1.0.32/28"
private_subnet_2_cidr    = "10.1.0.48/28"
nat_gw_name              = "my-prod-nat"
igw_name                 = "my-prod-igw"
main_rt_name             = "prod-main-rt"
private_rt_name          = "prod-private-rt"

