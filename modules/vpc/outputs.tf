output "vpc_id" {
  value = aws_vpc.my_vpc.id
}

output "public_subnet_1_id" {
  value = aws_subnet.public_sb_1.id
}

output "public_subnet_2_id" {
  value = aws_subnet.public_sb_2.id
}

output "private_subnet_1_id" {
  value = aws_subnet.private_sb_1.id
}

output "private_subnet_2_id" {
  value = aws_subnet.private_sb_2.id
}