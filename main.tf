
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}
locals {
  workspace_name = "${terraform.workspace}"
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}

resource "aws_vpc" "main" {
    cidr_block = var.vpc_cidr_block
    instance_tenancy = "default"
    tags =  {
        Name = "my-vpc-${var.environment}"
    }
}
# Declare the data source
data "aws_availability_zones" "available" {
  state = "available"
}

# e.g., Create subnets in the first two available availability zones

resource "aws_subnet" "primary" {
  vpc_id     = aws_vpc.main.id
  availability_zone = data.aws_availability_zones.available.names[0]
  cidr_block = var.private_subnet_cidr_blocks# Specify the CIDR block for the primary subnet
  tags = {
    Name = "${var.environment}-private-subnet"
  }

  # ...
}

resource "aws_subnet" "secondary" {
  vpc_id     = aws_vpc.main.id
  availability_zone = data.aws_availability_zones.available.names[1]
  cidr_block =var.public_subnet_cidr_blocks# Specify the CIDR block for the primary subnet
  tags = {
    Name = "${var.environment}-public-subnet"
  }

  # ...
}
resource "aws_eks_cluster" "eks_cluster" {
  name     = "cluster-${var.environment}"
  role_arn = aws_iam_role.example.arn

  vpc_config {
    subnet_ids = [aws_subnet.primary.id, aws_subnet.secondary.id]
  }

  # Ensure that IAM Role permissions are created before and deleted after EKS Cluster handling.
  # Otherwise, EKS will not be able to properly delete EKS managed EC2 infrastructure such as Security Groups.
  depends_on = [
    aws_iam_role_policy_attachment.example-AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.example-AmazonEKSVPCResourceController,
  ]
}

data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["eks.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "example" {
  name               = "eks-cluster-${var.environment}"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

resource "aws_iam_role_policy_attachment" "example-AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.example.name
}

# Optionally, enable Security Groups for Pods
# Reference: https://docs.aws.amazon.com/eks/latest/userguide/security-groups-for-pods.html
resource "aws_iam_role_policy_attachment" "example-AmazonEKSVPCResourceController" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
  role       = aws_iam_role.example.name
}
