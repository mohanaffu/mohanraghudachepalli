# Terraform Multi-Cloud Infrastructure

Production-grade Infrastructure as Code for AWS, GCP, and Azure with modular, reusable components.

## 📊 Overview

This project contains Terraform configurations for deploying complete cloud infrastructure across multiple cloud providers:
- **AWS:** VPC, EKS, RDS, S3, CloudWatch, IAM
- **GCP:** VPC, GKE, CloudSQL, GCS, Cloud Logging, IAM
- **Azure:** VNet, AKS, Azure Database, Storage, Monitor, RBAC

## 🗂️ Project Structure

```
terraform-multi-cloud-infrastructure/
├── README.md
├── ARCHITECTURE.md
├── terraform.tfvars.example
├── aws/
│   ├── main.tf
│   ├── vpc.tf
│   ├── eks.tf
│   ├── rds.tf
│   ├── s3.tf
│   ├── iam.tf
│   ├── variables.tf
│   ├── outputs.tf
│   └── terraform.tfvars.example
├── gcp/
│   ├── main.tf
│   ├── network.tf
│   ├── gke.tf
│   ├── cloudsql.tf
│   ├── storage.tf
│   ├── iam.tf
│   ├── variables.tf
│   ├── outputs.tf
│   └── terraform.tfvars.example
├── azure/
│   ├── main.tf
│   ├── vnet.tf
│   ├── aks.tf
│   ├── database.tf
│   ├── storage.tf
│   ├── rbac.tf
│   ├── variables.tf
│   ├── outputs.tf
│   └── terraform.tfvars.example
├── modules/
│   ├── vpc/
│   ├── kubernetes-cluster/
│   ├── database/
│   ├── storage/
│   └── monitoring/
├── environments/
│   ├── dev/
│   ├── staging/
│   └── prod/
├── scripts/
│   ├── init.sh
│   ├── plan.sh
│   ├── apply.sh
│   └── destroy.sh
└── docs/
    ├── SETUP.md
    ├── AWS-GUIDE.md
    ├── GCP-GUIDE.md
    └── AZURE-GUIDE.md
```

## 🚀 Quick Start

### Prerequisites
```bash
# Install Terraform
terraform -version  # v1.0+

# AWS CLI
aws --version
aws configure

# GCP CLI
gcloud --version
gcloud auth login

# Azure CLI
az --version
az login
```

### Deploy to AWS
```bash
cd aws
cp terraform.tfvars.example terraform.tfvars
# Edit terraform.tfvars with your values
terraform init
terraform plan
terraform apply
```

### Deploy to GCP
```bash
cd gcp
cp terraform.tfvars.example terraform.tfvars
# Edit terraform.tfvars with your values
terraform init
terraform plan
terraform apply
```

### Deploy to Azure
```bash
cd azure
cp terraform.tfvars.example terraform.tfvars
# Edit terraform.tfvars with your values
terraform init
terraform plan
terraform apply
```

## 🏗️ What Gets Deployed

### AWS Stack
- **VPC** with public/private subnets across 3 AZs
- **EKS Cluster** with 3 node groups (on-demand + spot instances)
- **RDS PostgreSQL** with automated backups and Multi-AZ
- **S3 Buckets** with versioning, encryption, and lifecycle policies
- **IAM Roles & Policies** with least privilege
- **CloudWatch** monitoring and log groups
- **NAT Gateways** for private subnet internet access
- **Security Groups** with proper ingress/egress rules

### GCP Stack
- **VPC Network** with custom subnets
- **GKE Cluster** (regional for HA)
- **CloudSQL PostgreSQL** with automated backups
- **GCS Buckets** with lifecycle management
- **IAM Service Accounts** and bindings
- **Cloud Logging** integration
- **Cloud NAT** for outbound connectivity
- **Firewall Rules** for network security

### Azure Stack
- **Virtual Network** with subnets
- **AKS Cluster** with multiple node pools
- **Azure Database for PostgreSQL** with HA
- **Storage Accounts** with containers
- **RBAC** configurations
- **Azure Monitor** integration
- **User-Assigned Managed Identity**
- **Network Security Groups**

## 📝 Configuration Variables

### Common Variables (All Clouds)
```hcl
aws_region     = "us-east-1"
environment    = "production"
project_name   = "my-project"
cluster_name   = "production-eks"
db_version     = "13"
db_engine      = "postgres"
```

## 🎓 Interview Questions This Project Addresses

1. **"Explain your multi-cloud strategy"**
   - Answer: This project demonstrates expertise across AWS, GCP, and Azure with consistent patterns

2. **"How do you manage Terraform state in production?"**
   - Answer: Remote state with backends, state locking, and encryption

3. **"Describe your disaster recovery approach"**
   - Answer: Multi-region setup, backup policies, failover procedures

4. **"How do you handle infrastructure secrets?"**
   - Answer: Terraform Cloud, AWS Secrets Manager, GCP Secret Manager, Azure Key Vault

5. **"Walk us through your IaC best practices"**
   - Answer: Modular design, environment separation, version control, documentation

## 🔒 Security Best Practices Implemented

✅ Encryption in transit and at rest
✅ IAM with least privilege principle
✅ Network isolation with security groups/NSGs
✅ Secrets managed via cloud providers
✅ VPC flow logs enabled
✅ Regular backups configured
✅ Resource tagging for cost tracking
✅ Audit logging enabled

## 📊 Cost Estimation

### AWS (Monthly Estimate)
- EKS: ~$73
- EC2 Instances (3 nodes): ~$150
- RDS: ~$50
- NAT Gateway: ~$32
- **Total: ~$305/month**

### GCP (Monthly Estimate)
- GKE: ~$146 (cluster management)
- Compute: ~$100
- CloudSQL: ~$50
- Cloud NAT: ~$30
- **Total: ~$326/month**

### Azure (Monthly Estimate)
- AKS: Free (cluster management)
- VM Instances: ~$120
- Database: ~$50
- Storage: ~$10
- **Total: ~$180/month**

## 🚨 Troubleshooting

### State Lock Issues
```bash
terraform force-unlock <LOCK_ID>
```

### Resource Import
```bash
terraform import aws_instance.example i-1234567890abcdef0
```

### Destroy Infrastructure
```bash
terraform destroy -auto-approve
```

## 📚 Additional Resources

- [Terraform AWS Provider](https://registry.terraform.io/providers/hashicorp/aws/latest)
- [Terraform GCP Provider](https://registry.terraform.io/providers/hashicorp/google/latest)
- [Terraform Azure Provider](https://registry.terraform.io/providers/hashicorp/azurerm/latest)
- [Terraform Best Practices](https://www.terraform.io/docs/cloud/guides/recommended-practices)

## 📄 License

MIT License - See LICENSE file

## 👤 Author

**Dachepalli Mohan Raghu**
- 💼 LinkedIn: https://linkedin.com/in/dachepalli-mohan-raghu-0b5146170/
- 🐙 GitHub: https://github.com/mohanaffu
- 📧 Email: your-email@example.com

---

**Made with ❤️ | DevOps Engineer**