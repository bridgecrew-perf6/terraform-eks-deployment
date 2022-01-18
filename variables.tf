# Network Variables

variable "vpc_id" {
  type = string
  description = "VPC ID"
}

variable "iac_environment" {
  type = string
  description = "IaC Environment Name"
}

variable "azs" {
  type = list(string)
  description = "Availability zone name list"
}

variable "private_subnets" {
  type = list(string)
  description = "Private Networks list"
}

variable "public_subnets" {
  type = list(string)
  description = "Public Networks list"
}

# EKS Variables

variable "eks_name" {
  type = string
  description = "Kubernetes EKS Cluster Name"
}

variable "managed_node_group_min_size" {
  type = number
  description = "Managed Node Group Min Size"
}

variable "managed_node_group_max_size" {
  type = number
  description = "Managed Node Group Max Size"
}

variable "managed_node_group_desired_size" {
  type = number
  description = "Managed Node Group Desired Size"
}

variable "managed_node_group_instance_types" {
  type = list(string)
  description = "Managed Node Group Instance Type"
}

variable "managed_node_group_capacity_type" {
  type = string
  description = "Managed Node Group Capacity Type"
}

variable "cluster_endpoint_private_access" {
  type = bool
  description = "Cluster Endpoint Private Access"
}

variable "cluster_endpoint_public_access" {
  type = bool
  description = "Cluster Endpoint Public Access"
}