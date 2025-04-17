# Aurora-vpc-ec2-terraform
This creates complete aurora along with VPC, EC2 bastion 

Project Structure
```
Aurora-EC2_bastion-vpc-terraform/
│
├── main.tf                  # Root: calls all modules and resources
├── provider.tf              # AWS provider and profile/region
├── terraform.tfvars         # Centralized input values (no secrets!)
├── variables.tf             # All root-level variable declarations
├── outputs.tf               # Global outputs (VPC ID, EC2 IDs, endpoints)
├── secrets.tf               # ✅ Aurora admin secret (Secrets Manager)
│
├── modules/                 # All reusable Terraform modules
│
│   ├── vpc/
│   │   ├── main.tf          # VPC, Subnets, NAT, IGW, RTs
│   │   ├── outputs.tf       # Subnet IDs, VPC ID
│   │   └── variable.tf
│
│   ├── ec2/
│   │   ├── main.tf          # EC2 instance with optional keyless SSM
│   │   ├── outputs.tf       # EC2 instance ID, IPs
│   │   └── variable.tf      # Includes SG input, subnet ID, profile
│
│   ├── ssm_role/
│   │   ├── main.tf          # IAM Role + Instance Profile for EC2
│   │   ├── outputs.tf
│   │   └── variable.tf
│
│   ├── aurora_mysql/
│   │   ├── main.tf          # Cluster, subnet group, secrets fetch
│   │   ├── outputs.tf       # Endpoints
│   │   └── variable.tf      # Inputs including secret_name
│
│   └── security_group/      # ✅ Modular SG logic (reusable for EC2/RDS)
│       ├── main.tf          # Handles dynamic ingress/egress
│       ├── outputs.tf       # SG ID
│       └── variables.tf     # Name, description, rules, tags

```


# Mysql client Installation in Amazon Linux 3 EC2
<pre> ```bash sudo dnf remove -y mysql80-community-release sudo rm -f /etc/yum.repos.d/mysql*.repo sudo dnf clean all sudo rm -rf /var/cache/dnf sudo dnf install -y https://repo.mysql.com/mysql80-community-release-el9-1.noarch.rpm sudo rpm --import https://repo.mysql.com/RPM-GPG-KEY-mysql-2022 sudo dnf makecache --refresh sudo dnf install -y --nogpgcheck mysql-community-client mysql --version sudo dnf install -y telnet telnet --version telnet aurora-mysql-dev.cluster-c76e6c4c6pmc.us-east-1.rds.amazonaws.com 3306 mysql -h <endpoint> -uadmin -p ``` </pre>
