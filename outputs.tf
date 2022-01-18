#----------------
# Network Outputs
#----------------

output "private_subnets" {
  
  value = module.create_network_requirements.private_subnets
  
  description = "Private Subnets"
}

output "public_subnets" {
  
  value = module.create_network_requirements.public_subnets
  
  description = "Public Subnets"
}

#------------
# EKS Outputs
#------------

output "cluster_id" {
  
  value       = module.create_eks_cluster.cluster_id
  
  description = "EKS cluster ID."
}

output "cluster_endpoint" {
  
  value       = module.create_eks_cluster.cluster_endpoint
  
  description = "Endpoint for EKS control plane."
}