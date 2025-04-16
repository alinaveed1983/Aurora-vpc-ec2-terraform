# For 1st EC2
variable "ami_id" {}
variable "instance_name" {}
variable "instance_type" {}

/*
# For 2nd EC2
variable "ami_id_2" {}
variable "instance_name_2" {}
variable "instance_type_2" {}
*/

# VPC Module Variables
variable "vpc_cidr_block" {}
variable "vpc_name" {}
variable "public_subnet_1_cidr" {}
variable "public_subnet_2_cidr" {}
variable "private_subnet_1_cidr" {}
variable "private_subnet_2_cidr" {}
variable "nat_gw_name" {}
variable "igw_name" {}
variable "main_rt_name" {}
variable "private_rt_name" {}
