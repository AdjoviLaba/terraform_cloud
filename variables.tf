variable "aws_region" {
  description = "The AWS region to deploy the resources in."
  type        = string
  default     = "us-east-1"
}

variable "environment" {
  description = "The environment name to use in resource names."
  type        = string
  default     = "dev"
}

variable "vpc_cidr_block" {
  description = "The CIDR block to use for the VPC."
  type        = string
  default     = "10.0.0.0/16"
}
variable "public_subnet_count" {
  description = "Number of public subnets."
  type        = number
}

variable "private_subnet_count" {
  description = "Number of private subnets."
  type        = number
}

variable "public_subnet_cidr_blocks" {
  description = "Available cidr blocks for public subnets."
  type        = list(string)
}

variable "private_subnet_cidr_blocks" {
  description = "Available cidr blocks for private subnets."
  type        = list(string)
}

