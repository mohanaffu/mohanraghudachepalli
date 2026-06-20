variable "aws_region" {
  type        = string
  description = "AWS region"
  default     = "us-east-1"
}

variable "project_name" {
  type        = string
  description = "Project name"
  default     = "multi-cloud"
}

variable "environment" {
  type        = string
  description = "Environment (dev, staging, prod)"
  validation {
    condition     = contains(["dev", "staging", "prod"], var.environment)
    error_message = "Environment must be dev, staging, or prod."
  }
}

variable "vpc_cidr" {
  type        = string
  description = "CIDR block for VPC"
  default     = "10.0.0.0/16"
}

variable "eks_cluster_version" {
  type        = string
  description = "Kubernetes version"
  default     = "1.28"
}

variable "eks_node_group_size" {
  type = object({
    desired = number
    min     = number
    max     = number
  })
  description = "EKS node group size"
  default = {
    desired = 3
    min     = 1
    max     = 10
  }
}

variable "instance_type" {
  type        = string
  description = "EC2 instance type for EKS nodes"
  default     = "t3.medium"
}

variable "rds_instance_class" {
  type        = string
  description = "RDS instance class"
  default     = "db.t3.small"
}

variable "rds_engine" {
  type        = string
  description = "RDS database engine"
  default     = "postgres"
}

variable "rds_engine_version" {
  type        = string
  description = "RDS engine version"
  default     = "15"
}

variable "rds_database_name" {
  type        = string
  description = "RDS database name"
  default     = "appdb"
}

variable "rds_username" {
  type        = string
  description = "RDS master username"
  default     = "admin"
  sensitive   = true
}

variable "rds_password" {
  type        = string
  description = "RDS master password"
  sensitive   = true
}
