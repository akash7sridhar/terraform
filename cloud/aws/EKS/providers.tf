terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "ap-south-1"
}


provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
#   host                   = module.eks.cluster_endpoint
#   token                  = module.eks.cluster_token
#   cluster_ca_certificate = base64decode(module.eks.cluster_ca_certificate)
  }

}

provider "kubernetes" {
  config_path    = "~/.kube/config"
  config_context = "my-context"
#   host                   = module.eks.cluster_endpoint
#   token                  = module.eks.cluster_token
#   cluster_ca_certificate = base64decode(module.eks.cluster_ca_certificate)
}