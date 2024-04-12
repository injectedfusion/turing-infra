terraform {
  required_providers {
    talos = {
      source  = "siderolabs/talos"
      version = "0.4.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.29.0" // Specify a version that suits your requirements.
    }
    helm = {
      source  = "hashicorp/helm"
      version = ">= 2.13.0" // Specify a version that suits your requirements.
    }
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = ">= 1.14.0" // Use an appropriate version that supports your Kubernetes version.
    }
  }
}

provider "talos" {
  // Configuration for the Talos provider (if needed).
}

provider "kubernetes" {
  config_path = "/home/gabriel/.kube/config" // Adjust the path if necessary.
}

provider "helm" {
  kubernetes {
    config_path = "/home/gabriel/.kube/config" // Ensure this path is correctly pointing to your kubeconfig.
  }
}

provider "kubectl" {
  // You can specify additional configurations here if necessary.
}
