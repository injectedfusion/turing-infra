# Talos Cluster Setup with Terraform

This repository contains Terraform configurations for setting up a Talos cluster. This documentation will guide you through generating the necessary configuration files and applying the Terraform configuration.

## Prerequisites

1. **Install Talosctl:** Ensure you have `talosctl` installed on your machine. Follow the instructions [here](https://talos.dev/docs/v0.13/introduction/getting-started/#installing-talosctl).

2. **Install Terraform:** Ensure you have Terraform installed. Follow the instructions [here](https://learn.hashicorp.com/terraform/getting-started/install.html).

## Generating Configuration Files

First, generate the Talos and kubeconfig files using `talosctl`. **Replace the IP address** with your actual control plane node IP address.

1. **Set the Talos endpoint:**
   ```sh
   talosctl config endpoint 192.168.251.19
   ```

2. Set the Talos node:
   
   ```sh
   talosctl config node 192.168.251.19
   ```

3. talosctl config node 192.168.251.19

   ```sh
   talosctl config generate > files/talosconfig.yaml
   ```

4. Generate the kubeconfig file:

   ```sh
   talosctl kubeconfig -n 192.168.251.19 > files/kubeconfig.yaml
   ```

## Terraform Configuration

The main Terraform configuration file is main.tf. Ensure the generated configuration files are in the files directory.

### Variables

The variables for the Terraform configuration are defined in variables.tf. Here are the key variables:

- `cluster_name`: A name for the Talos cluster.
- `cluster_endpoint`: The endpoint for the Talos cluster.
- `node_data`: A map of node data, including control plane and worker nodes.

### Example `variables.tf`

```hcl
variable "cluster_name" {
  description = "A name to provide for the Talos cluster"
  type        = string
  default     = "turing-rk3588-cluster-1"
}

variable "cluster_endpoint" {
  description = "The endpoint for the Talos cluster"
  type        = string
  default     = "https://192.168.251.19:6443"
}

variable "node_data" {
  description = "A map of node data"
  type = object({
    controlplanes = map(object({
      install_disk = string
      hostname     = optional(string)
    }))
    workers = map(object({
      install_disk = string
      hostname     = optional(string)
    }))
  })
  default = {
    controlplanes = {
      "192.168.251.19" = {
        install_disk = "/dev/nvme0n1"
        hostname     = "node01-32gb"
      }
    }
    workers = {
      "192.168.251.15" = {
        install_disk = "/dev/nvme0n1"
        hostname     = "node02-16gb"
      },
      "192.168.251.2" = {
        install_disk = "/dev/nvme0n1"
        hostname     = "node03-16gb"
      },
      "192.168.251.17" = {
        install_disk = "/dev/nvme0n1"
        hostname     = "node04-8gb"
      }
    }
  }
}
```

## Apply the Terraform Configuration

1. **Initialize Terraform:**

   ```sh
   terraform init
   ```

2. Plan the Terraform Deployment

   ```sh
   terraform plan
   ```

3. Apply the Terraform Configuration

   ```sh
   terraform apply
   ```

This will set up the Talos cluster using the provided configuration.

- `files/`: Contains the generated Talos and kubeconfig files.
- `templates/`: Contains template files for configuration patches.
- `main.tf`: Main Terraform configuration file.
- `variables.tf`: Contains variable definitions.
- `outputs.tf`: Defines outputs from the Terraform deployment.
- `versions.tf`: Specifies the required Terraform version and provider versions.

## Troubleshooting

### Certificate Verification Error
If you encounter a TLS certificate verification error, ensure that the CA certificate used to sign the Talos certificates is trusted by the system or application trying to connect. You might need to explicitly provide the CA certificate in your configuration.

### Updating Configuration
If you need to update the configuration files, regenerate them using the talosctl commands and place the updated files in the files directory. Then, reapply the Terraform configuration.

## Additional Resources
- [Talos Documentation]()
- [Terraform Documentation]()   



