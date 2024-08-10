variable "region" {
  description = "AWS region where resources will be created"
  default     = "us-east-1"
}

variable "vpc_cidr_block" {
  description = "CIDR block for the VPC"
  default     = "10.0.0.0/16"
}

variable "subnet_cidr_blocks" {
  description = "CIDR blocks for the subnets"
  type        = list(string)
  default     = ["10.0.1.0/24"]
}

variable "eks_cluster_name" {
  description = "Name of the EKS cluster"
  default     = "example-cluster"
}

variable "eks_version" {
  description = "Kubernetes version for the EKS cluster"
  default     = "1.21"
}
