output "vpc_id" {
  description = "ID of the created VPC"
  value       = aws_vpc.k8vpc.id
}

output "subnet_ids" {
  description = "IDs of the created subnets"
  value       = aws_subnet.k8subnet[*].id
}

output "security_group_id" {
  description = "ID of the created security group"
  value       = aws_security_group.k8securitygroup.id
}

output "eks_cluster_name" {
  description = "Name of the created EKS cluster"
  value       = aws_eks_cluster.k8cluster.name
}

output "eks_cluster_endpoint" {
  description = "Endpoint of the created EKS cluster"
  value       = aws_eks_cluster.k8cluster.endpoint
}
