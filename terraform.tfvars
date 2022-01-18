# Network

vpc_id = "vpc-0ef2b5b8a74e42af5"

iac_environment = "dev"

azs = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]

private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]

public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

# EKS

eks_name = "eks-1"

managed_node_group_min_size = 1

managed_node_group_max_size = 2

managed_node_group_desired_size = 1

managed_node_group_instance_types = ["t3.large"]

managed_node_group_capacity_type = "ON_DEMAND"

# Access EKS from private networks
cluster_endpoint_private_access = false

# Access EKS from public networks
cluster_endpoint_public_access = true