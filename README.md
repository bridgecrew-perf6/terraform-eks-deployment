# Terraform - EKS Cluster Deployment

# About the project

This module implements an EKS Cluster. For this project we are assuming that only the VPC exists. VPC need to have DNS Hostnames option enabled.

Main Features:
- Network
  - External IP Address
  - Internet Gateway
  - Nat Gateway per AZ
  - Private and Public Subnets
  - Route Tables
- EKS
  - EKS Cluster
  - Managed Node Groups
- Optional Features
  - IAM Roles

Warning



# Getting Started

## Vareables Example

    # Network

    vpc_id = "vpc-0ef2b5b8a74e42af5"

    iac_environment = "dev"

    azs = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]

    private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]

    public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

    # EKS

    eks_name = "eks-1"

    eks_iam = ["arn1","arn2"]

    managed_node_group_min_size = 1

    managed_node_group_max_size = 2

    managed_node_group_desired_size = 1

    managed_node_group_instance_types = ["t3.large"]

    managed_node_group_capacity_type = "ON_DEMAND"

    # Optional

    arn_policies = ["",""]

## Deployment Example

For this example, we need to have docker installed, since we will use it to create an aws cli container.
Bellow the steps to deploy the solution:


1 - Clone Gitlab repository

    git clone repo

2 - Update input variables editing the file terraform.tfvars

3 - Start docker with aws cli

    docker run -it --rm -v  ${PWD}:/eks -w /eks --entrypoint /bin/bash amazon/aws-cli:latest

4 - Install Terraform

    yum install -y jq gzip nano tar git unzip wget kubectl
    curl -o /tmp/amazon.zip -LO https://releases.hashicorp.com/terraform/1.1.3/terraform_1.1.3_linux_amd64.zip
    unzip /tmp/amazon.zip
    chmod +x terraform && mv terraform /usr/local/bin

5 - Configure aws cli

    aws configure

    You will need:
    - AWS Access Key ID
    - AWS Secret Key
    - Default region name
    - Default output format

6 - Execute the terraform commands

    Terraform init
    Terraform plan
    Terraform apply

7 - Once Terraform has finished provisioning the cluster, run the following command to obtain a kube config file.

    aws eks update-kubeconfig --name cluster_name --region your_aws_region

## IAM Policies

The cluster is configured to allow mapping of IAM Roles to pods.

To associate IAM policies to pod, you need to add the arn string to the annotations section of the Service Account yaml file like the exemple bellow.

    annotations:
        eks.amazonaws.com/role-arn: arn:aws:iam::1432384:role/my-iam-role