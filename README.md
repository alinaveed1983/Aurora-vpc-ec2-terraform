# Aurora-vpc-ec2-terraform
This creates complete aurora along with VPC, EC2 bastion 

Project Structure
```
Aurora-EC2_bastion-vpc-terraform/
│
├── main.tf                    # Root config calling modules, now includes secret_name
├── outputs.tf                 # Outputs including Aurora endpoints & optional secret name
├── provider.tf                # AWS provider block
├── secrets.tf                 # 🆕 Creates Aurora admin credentials in Secrets Manager
├── terraform.tfvars           # Values for root variables (no credentials here anymore)
├── variables.tf               # Declared variables for root modules
│
├── modules/
│   ├── vpc/
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   └── variable.tf
│   │
│   ├── ec2/
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   └── variable.tf
│   │
│   ├── ssm_role/
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   └── variable.tf
│   │
│   └── aurora_mysql/
│       ├── main.tf           # Uses Secrets Manager to retrieve admin creds
│       ├── outputs.tf        # Cluster and reader endpoint
│       └── variable.tf       # Includes secret_name input
```
