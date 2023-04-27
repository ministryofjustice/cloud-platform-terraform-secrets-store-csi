terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
    kubernetes = {
      source = "hashicorp/kubernetes"
    }
    helm = {
      source = "hashicorp/helm"
      version = "~> 2.6.0"
    }
  }
  required_version = ">= 1.2.5"
}
