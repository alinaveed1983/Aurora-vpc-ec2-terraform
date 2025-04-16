# main.tf

# VPC Resource
resource "aws_vpc" "my_vpc" {
  cidr_block = var.vpc_cidr_block

  tags = {
    Name = var.vpc_name
  }
}

# Public Subnet 1
resource "aws_subnet" "public_sb_1" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = var.public_subnet_1_cidr
  availability_zone       = var.public_subnet_1_az
  map_public_ip_on_launch = true

  tags = {
    Name = var.public_subnet_1_name
  }
}

# Public Subnet 2
resource "aws_subnet" "public_sb_2" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = var.public_subnet_2_cidr
  availability_zone       = var.public_subnet_2_az
  map_public_ip_on_launch = true

  tags = {
    Name = var.public_subnet_2_name
  }
}

# Private Subnet 1
resource "aws_subnet" "private_sb_1" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = var.private_subnet_1_cidr
  availability_zone       = var.private_subnet_1_az
  map_public_ip_on_launch = false

  tags = {
    Name = var.private_subnet_1_name
  }
}

# Private Subnet 2
resource "aws_subnet" "private_sb_2" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = var.private_subnet_2_cidr
  availability_zone       = var.private_subnet_2_az
  map_public_ip_on_launch = false

  tags = {
    Name = var.private_subnet_2_name
  }
}

# Internet Gateway
resource "aws_internet_gateway" "my_igw" {
  vpc_id = aws_vpc.my_vpc.id

  tags = {
    Name = var.igw_name
  }
}

# Elastic IP for NAT Gateway
resource "aws_eip" "my_eip" {
  domain = "vpc"

  tags = {
    Name = var.nat_gw_name
  }
}

# NAT Gateway
resource "aws_nat_gateway" "my_nat_gw" {
  allocation_id = aws_eip.my_eip.id
  subnet_id     = aws_subnet.public_sb_1.id

  tags = {
    Name = var.nat_gw_name
  }
}

# Main Route Table
resource "aws_route_table" "main_rt" {
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my_igw.id
  }

  tags = {
    Name = var.main_rt_name
  }
}

# Private Route Table
resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.my_nat_gw.id
  }

  tags = {
    Name = var.private_rt_name
  }
}

# Main Route Table Association
resource "aws_main_route_table_association" "main_rt_assoc" {
  vpc_id         = aws_vpc.my_vpc.id
  route_table_id = aws_route_table.main_rt.id
}

# Public Route Table Associations
resource "aws_route_table_association" "public_sb_1_association" {
  subnet_id      = aws_subnet.public_sb_1.id
  route_table_id = aws_route_table.main_rt.id
}

resource "aws_route_table_association" "public_sb_2_association" {
  subnet_id      = aws_subnet.public_sb_2.id
  route_table_id = aws_route_table.main_rt.id
}

# Private Route Table Associations
resource "aws_route_table_association" "private_sb_1_association" {
  subnet_id      = aws_subnet.private_sb_1.id
  route_table_id = aws_route_table.private_rt.id
}

resource "aws_route_table_association" "private_sb_2_association" {
  subnet_id      = aws_subnet.private_sb_2.id
  route_table_id = aws_route_table.private_rt.id
}
