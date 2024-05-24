variable "cluster_name" {
  description = "A name to provide for the Talos cluster"
  type        = string
  default     = "turingpi-k8s-cluster"
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