# Terraform Multi-Cloud Architecture

## AWS Architecture

```
┌─────────────────────────────────────────────────────────────┐
│                      AWS Region (us-east-1)                 │
├─────────────────────────────────────────────────────────────┤
│                                                               │
│  ┌──────────────────────────────────────────────────────┐  │
│  │                  VPC (10.0.0.0/16)                   │  │
│  ├──────────────────────────────────────────────────────┤  │
│  │                                                        │  │
│  │  ┌─────────────────┐  ┌─────────────────┐           │  │
│  │  │  Public Subnet  │  │ Private Subnet  │           │  │
│  │  │  10.0.1.0/24    │  │  10.0.10.0/24   │           │  │
│  │  │                 │  │                 │           │  │
│  │  │ ┌─────────────┐ │  │ ┌─────────────┐ │           │  │
│  │  │ │   NAT GW    │ │  │ │  EKS Nodes  │ │           │  │
│  │  │ └─────────────┘ │  │ │  (3x t3.m)  │ │           │  │
│  │  │                 │  │ └─────────────┘ │           │  │
│  │  └─────────────────┘  └─────────────────┘           │  │
│  │                                                        │  │
│  │  ┌─────────────────┐  ┌─────────────────┐           │  │
│  │  │ Private Subnet  │  │ Private Subnet  │           │  │
│  │  │  10.0.20.0/24   │  │  10.0.30.0/24   │           │  │
│  │  │                 │  │                 │           │  │
│  │  │ ┌─────────────┐ │  │ ┌─────────────┐ │           │  │
│  │  │ │ RDS (Multi) │ │  │ │ ElastiCache │ │           │  │
│  │  │ └─────────────┘ │  │ └─────────────┘ │           │  │
│  │  └─────────────────┘  └─────────────────┘           │  │
│  │                                                        │  │
│  └──────────────────────────────────────────────────────┘  │
│                                                               │
│  ┌──────────────────────────────────────────────────────┐  │
│  │            S3 Buckets                                │  │
│  │  • Application Logs Bucket                           │  │
│  │  • Terraform State Bucket (encrypted, versioned)     │  │
│  │  • Backups Bucket (lifecycle managed)                │  │
│  └──────────────────────────────────────────────────────┘  │
│                                                               │
└─────────────────────────────────────────────────────────────┘
```

## GCP Architecture

```
┌─────────────────────────────────────────────────────────────┐
│                   GCP Project (us-central1)                 │
├─────────────────────────────────────────────────────────────┤
│                                                               │
│  ┌──────────────────────────────────────────────────────┐  │
│  │          VPC Network (10.1.0.0/16)                   │  │
│  ├──────────────────────────────────────────────────────┤  │
│  │                                                        │  │
│  │  ┌──────────────────────────────────────────────┐   │  │
│  │  │      GKE Cluster (Regional HA)              │   │  │
│  │  │  • Control plane managed by Google          │   │  │
│  │  │  • 3 zones with auto-scaling node pools     │   │  │
│  │  │  • Network policies enabled                 │   │  │
│  │  └──────────────────────────────────────────────┘   │  │
│  │                                                        │  │
│  │  ┌──────────────────────────────────────────────┐   │  │
│  │  │         Cloud NAT (for outbound)             │   │  │
│  │  └──────────────────────────────────────────────┘   │  │
│  │                                                        │  │
│  └──────────────────────────────────────────────────────┘  │
│                                                               │
│  ┌──────────────────────────────────────────────────────┐  │
│  │         CloudSQL PostgreSQL                          │  │
│  │  • High Availability (primary + replica)            │  │
│  │  • Automated backups (PITR)                          │  │
│  │  • Private IP in VPC                                │  │
│  └──────────────────────────────────────────────────────┘  │
│                                                               │
│  ┌──────────────────────────────────────────────────────┐  │
│  │          Cloud Storage Buckets                        │  │
│  │  • Application data (geo-redundant)                  │  │
│  │  • Terraform state (versioned)                       │  │
│  │  • Logs (with lifecycle policies)                    │  │
│  └──────────────────────────────────────────────────────┘  │
│                                                               │
└─────────────────────────────────────────────────────────────┘
```

## Azure Architecture

```
┌─────────────────────────────────────────────────────────────┐
│                  Azure Resource Group                       │
│                   (East US Region)                          │
├─────────────────────────────────────────────────────────────┤
│                                                               │
│  ┌──────────────────────────────────────────────────────┐  │
│  │        Virtual Network (10.2.0.0/16)                │  │
│  ├──────────────────────────────────────────────────────┤  │
│  │                                                        │  │
│  │  ┌─────────────────┐  ┌─────────────────┐           │  │
│  │  │ AKS Subnet      │  │ Database Subnet │           │  │
│  │  │ 10.2.1.0/24     │  │ 10.2.2.0/24     │           │  │
│  │  │                 │  │                 │           │  │
│  │  │ ┌─────────────┐ │  │ ┌─────────────┐ │           │  │
│  │  │ │  AKS Nodes  │ │  │ │   Azure DB  │ │           │  │
│  │  │ │ (3 system +  │ │  │ │ PostgreSQL  │ │           │  │
│  │  │ │  N user)    │ │  │ │  (HA Zone)  │ │           │  │
│  │  │ └─────────────┘ │  │ └─────────────┘ │           │  │
│  │  └─────────────────┘  └─────────────────┘           │  │
│  │                                                        │  │
│  │  ┌─────────────────────────────────────────────┐    │  │
│  │  │   Network Security Groups (NSG)            │    │  │
│  │  │  • Ingress rules (SSH, HTTP, HTTPS)       │    │  │
│  │  │  • Egress rules (outbound traffic)         │    │  │
│  │  └─────────────────────────────────────────────┘    │  │
│  │                                                        │  │
│  └──────────────────────────────────────────────────────┘  │
│                                                               │
│  ┌──────────────────────────────────────────────────────┐  │
│  │         Azure Storage Accounts                        │  │
│  │  • Application data (LRS/GRS)                        │  │
│  │  • Terraform state (Premium LRS)                     │  │
│  │  • Backup vault                                      │  │
│  └──────────────────────────────────────────────────────┘  │
│                                                               │
└─────────────────────────────────────────────────────────────┘
```

## Networking Comparison

| Feature | AWS | GCP | Azure |
|---------|-----|-----|-------|
| VPC CIDR | 10.0.0.0/16 | 10.1.0.0/16 | 10.2.0.0/16 |
| Availability | 3 AZs | 3 Zones | Availability Zones |
| NAT Gateway | ✅ Explicit | ✅ Cloud NAT | ✅ Azure NAT |
| Security | Security Groups | Firewall Rules | NSGs |
| Ingress | ALB/NLB | Ingress/LB | App Gateway |

## Security Architecture

### All Clouds
- ✅ Private subnets for data tier
- ✅ Public subnets for ingress only
- ✅ NAT for outbound connectivity
- ✅ Encryption in transit (TLS)
- ✅ Encryption at rest (KMS/HSM)
- ✅ Network policies enabled
- ✅ IAM with least privilege
- ✅ Audit logging
- ✅ VPC flow logs

### Data Protection
- **RDS/CloudSQL/Azure DB:**
  - Automated backups (daily)
  - Point-in-time recovery (PITR)
  - Multi-AZ/Regional replication
  - Encryption at rest

- **Object Storage (S3/GCS/Azure Storage):**
  - Server-side encryption
  - Versioning enabled
  - Lifecycle policies
  - Access logging

## Disaster Recovery Strategy

### RTO/RPO Targets
- **RTO:** 1 hour
- **RPO:** 15 minutes

### Implementation
1. **Automated Backups:** Daily to separate storage
2. **Read Replicas:** Standby instances in different regions
3. **Infrastructure Backup:** Terraform code versioned in Git
4. **Runbooks:** Documented recovery procedures

## Cost Optimization

1. **Compute:**
   - Reserved instances for long-term
   - Spot instances for fault-tolerant workloads
   - Auto-scaling based on metrics

2. **Storage:**
   - Lifecycle policies for old logs
   - Cold storage for archives
   - De-duplication where possible

3. **Network:**
   - Minimize cross-region traffic
   - Use CDN for static content
   - Consolidate NAT gateways

4. **Monitoring:**
   - Regular cost analysis
   - Budget alerts
   - Unused resource cleanup