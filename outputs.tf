output "vpc_id" {
  value = module.vpc.vpc_id
}

output "bastion_ec2_1_id" {
  value = module.ec2_bastion_1.instance_id
}

/*
output "bastion_ec2_2_id" {
  value = module.ec2_bastion_2.instance_id
}
*/
