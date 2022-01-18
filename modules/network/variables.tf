variable "tags" {
  type = map
  description = "List of Tags"
}

variable "pub_sn_tags" {
  type = map
  description = "List of Tags to Public Networks"
}

variable "prv_sn_tags" {
  type = map
  description = "List of Tags to Private Networks"
}

variable "vpc_id" {
  type = string
  description = "VPC ID"
}

variable "availability_zone_names" {
  type = list(string)
  description = "Availability zone name list"
}

variable "private_subnets" {
  type        = list(string)
  description = "Private Networks list"
}

variable "public_subnets" {
  type        = list(string)
  description = "Public Networks list"
}