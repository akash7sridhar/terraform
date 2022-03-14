locals {
  region = "ap-south-1"
}

################################################################################
# VPC Module
################################################################################

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "tf-vpc"

  cidr                  = "10.0.0.0/16"
  secondary_cidr_blocks = ["10.1.0.0/16", "10.2.0.0/16"]

  azs             = ["${local.region}a", "${local.region}b", "${local.region}c"]
  private_subnets = ["10.0.1.0/24", "10.1.2.0/24", "10.2.3.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.1.102.0/24", "10.2.103.0/24"]

  enable_ipv6 = true

  enable_nat_gateway = true
  single_nat_gateway = true

  public_subnet_tags = {
    Name = "tf-public-subnet"
  }

  tags = {
    Owner       = "akash"
    Environment = "tf-dev"
  }

  vpc_tags = {
    Name = "tf-vpc"
  }
}