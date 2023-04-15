variable "aws_region" {
  description = "The AWS region to deploy the resources in."
  type        = string
  default     = ""
}

variable "environment" {
  description = "The environment name to use in resource names."
  type        = string
  default     = ""
}

variable "vpc_cidr_block" {
  description = "The CIDR block to use for the VPC."
  type        = string
  default     = ""
}


variable "public_subnet_cidr_blocks" {
  description = "Available cidr blocks for public subnets."
  type        = string
  default     = ""
}

variable "private_subnet_cidr_blocks" {
  description = "Available cidr blocks for private subnets."
  type        = string
  default     = ""
}

