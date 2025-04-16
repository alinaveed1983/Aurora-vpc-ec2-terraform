variable "vpc_cidr_block" {
  description = "The CIDR block for the VPC"
  default     = "10.0.0.0/26"
}

variable "vpc_name" {
  description = "The name of the VPC"
  default     = "my-vpc-1"
}

variable "igw_name" {
  description = "The name of the Internet Gateway"
  default     = "my-IGW"
}

variable "main_rt_name" {
  description = "The name of the main route table"
  default     = "Main-RT"
}

variable "private_rt_name" {
  description = "The name of the private route table"
  default     = "Private-RT"
}

variable "nat_gw_name" {
  description = "The name of the NAT Gateway"
  default     = "my-NATG1"
}

variable "eip_allocation_id" {
  description = "The allocation ID of the Elastic IP for the NAT Gateway"
  default     = "eipalloc-089c7c223344c4231"
}

variable "public_subnet_1_cidr" {
  description = "CIDR block for the first public subnet"
  default     = "10.0.0.0/28"
}

variable "public_subnet_1_az" {
  description = "Availability zone for the first public subnet"
  default     = "us-east-1a"
}

variable "public_subnet_1_name" {
  description = "Name of the first public subnet"
  default     = "public-sb-1"
}

variable "public_subnet_2_cidr" {
  description = "CIDR block for the second public subnet"
  default     = "10.0.0.16/28"
}

variable "public_subnet_2_az" {
  description = "Availability zone for the second public subnet"
  default     = "us-east-1b"
}

variable "public_subnet_2_name" {
  description = "Name of the second public subnet"
  default     = "public-sb-2"
}

variable "private_subnet_1_cidr" {
  description = "CIDR block for the first private subnet"
  default     = "10.0.0.32/28"
}

variable "private_subnet_1_az" {
  description = "Availability zone for the first private subnet"
  default     = "us-east-1a"
}

variable "private_subnet_1_name" {
  description = "Name of the first private subnet"
  default     = "private-sb-1"
}

variable "private_subnet_2_cidr" {
  description = "CIDR block for the second private subnet"
  default     = "10.0.0.48/28"
}

variable "private_subnet_2_az" {
  description = "Availability zone for the second private subnet"
  default     = "us-east-1b"
}

variable "private_subnet_2_name" {
  description = "Name of the second private subnet"
  default     = "private-sb-2"
}