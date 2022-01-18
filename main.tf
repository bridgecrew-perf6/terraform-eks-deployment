#--------
# General
#--------

terraform {
  required_version = ">= 1.1.3"
}

provider "aws"{
  region = "eu-west-1"
}

provider "kubernetes" {
  load_config_file = "true"
  host = data.aws_eks_cluster.cluster.endpoint
  token = data.aws_eks_cluster_auth.cluster.token
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
}

locals {
  private_subnets = module.create_network_requirements.private_subnets
  public_subnets = module.create_network_requirements.public_subnets
}

#------------------------------
# Deploy Network Configurations
#------------------------------

data "aws_availability_zones" "available" {}

data "aws_caller_identity" "current" {}

module "create_network_requirements" {

  source = "./modules/network"
 
  vpc_id = var.vpc_id
  
  availability_zone_names = var.azs
  
  private_subnets = var.private_subnets
  
  public_subnets = var.public_subnets
  
  tags = {
    iac_environment = var.iac_environment
  }
  pub_sn_tags = {
    "kubernetes.io/cluster/eks" = "shared"
    "kubernetes.io/role/elb" = "1"
    iac_environment = var.iac_environment
  }
  prv_sn_tags = {
    "kubernetes.io/cluster/eks" = "shared"
    "kubernetes.io/role/internal-elb" = "1"
    iac_environment = var.iac_environment
  }
  
}

#-----------
# Deploy EKS
#-----------

module "create_eks_cluster" {

  source = "./modules/eks"

  vpc_id = var.vpc_id
  
  cluster_name = var.eks_name
  
  eks_subnets = "${concat(local.public_subnets,local.private_subnets)}"
  
  aws_identity_id = data.aws_caller_identity.current.account_id
  
  managed_node_group_min_size = var.managed_node_group_min_size
  
  managed_node_group_max_size = var.managed_node_group_max_size
  
  managed_node_group_desired_size = var.managed_node_group_desired_size
  
  managed_node_group_instance_types = var.managed_node_group_instance_types
  
  managed_node_group_capacity_type = var.managed_node_group_capacity_type

  cluster_endpoint_private_access = var.cluster_endpoint_private_access

  cluster_endpoint_public_access = var.cluster_endpoint_public_access
}