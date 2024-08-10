provider "aws" {
  region = "us-east-1"  # Replace with your desired AWS region
}

# Create VPC
resource "aws_vpc" "k8vpc" {
  cidr_block = "10.0.0.0/16"
  enable_dns_support = true
  enable_dns_hostnames = true
  tags = {
    Name = "api_k8"
  }
}


# Create Subnets
resource "aws_subnet" "k8subnet" {
  count = 2
  vpc_id = aws_vpc.k8vpc.id
  cidr_block = "10.0.${count.index + 1}.0/24"
  availability_zone = element(data.aws_availability_zones.available.names, count.index)
  tags = {
    Name = "example-subnet-${count.index}"
  }
}

# Create Security Group
resource "aws_security_group" "k8securitygroup" {
  name        = "k8-security-group"
  vpc_id      = aws_vpc.k8vpc.id
  description = "Allow inbound and outbound traffic"

  ingress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "k8-security-group"
  }
}


# Create IAM Role for EKS
resource "aws_iam_role" "k8eksrole" {
  name = "example-eks-role"
  
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "eks.amazonaws.com"
        }
      },
    ],
  })
}

# Attach policy to IAM Role
resource "aws_iam_role_policy_attachment" "k8eksrolepolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role     = aws_iam_role.k8eksrole.name
}

# Create EKS Cluster
resource "aws_eks_cluster" "k8cluster" {
  name     = "flask-api-cluster"
  role_arn  = aws_iam_role.k8eksrole.arn
  version   = "1.30"

  vpc_config {
    subnet_ids         = aws_subnet.k8subnet[*].id
    security_group_ids = [aws_security_group.k8securitygroup.id]
  }
}

# Data source to get availability zones
data "aws_availability_zones" "available" {}
