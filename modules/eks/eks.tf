#-------------------
# Create EKS Cluster
#-------------------

module "eks" {
  
  source = "terraform-aws-modules/eks/aws"
  
  version = "18.2.0"
  
  cluster_name = var.cluster_name
  
  cluster_endpoint_private_access = var.cluster_endpoint_private_access
  
  cluster_endpoint_public_access  = var.cluster_endpoint_public_access

  enable_irsa = true
  
  vpc_id  = var.vpc_id
  
  subnet_ids = var.eks_subnets

  cluster_addons = {
    coredns = {
      resolve_conflicts = "OVERWRITE"
    }
    kube-proxy = {}
    vpc-cni = {
      resolve_conflicts = "OVERWRITE"
    }
  }  
  
  eks_managed_node_groups = {
    green = {
      min_size = var.managed_node_group_min_size
      max_size = var.managed_node_group_max_size
      desired_size = var.managed_node_group_desired_size
      instance_types = var.managed_node_group_instance_types
      capacity_type = var.managed_node_group_capacity_type
    }
  }
}

data "aws_eks_cluster" "cluster" {
  
  name = module.eks.cluster_id
}

data "aws_eks_cluster_auth" "cluster" {
  
  name = module.eks.cluster_id
}

provider "kubernetes" {
  
  host                   = data.aws_eks_cluster.cluster.endpoint
  
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
  
  token                  = data.aws_eks_cluster_auth.cluster.token
}