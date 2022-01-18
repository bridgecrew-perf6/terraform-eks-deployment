variable "vpc_id" {
  type = string
  description = "VPC ID"
}

variable "cluster_name" {
  type = string
  description = "EKS Cluster Name"
}

variable "aws_identity_id" {
  type = string
  description = "AWS Identity Account ID"
}

variable "eks_subnets" {
  type = list(string)
  description = "EKS Subnet list"
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