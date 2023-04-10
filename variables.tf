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
variable "private_subnet_cidr_blocks" {
    description = "The CIDR block of the private subnet"
  type = list(string)
  default = [
    "10.0.1.0/24",
    "10.0.2.0/24",
  ]
}

variable "public_subnet_cidr_blocks" {
  type = list(string)
  default = [
    "10.0.101.0/24",
    "10.0.102.0/24",
  ]
}
