variable "username" {
  type        = string
  description = "Username for the VM"
  default     = "viet"
}

variable "pve_nodes" {
  type        = list(string)
  description = "A list of all PVE nodes"
  default     = ["homelab1", "homelab2", "homelab3"]
}

variable "image_url" {
  type        = string
  description = "Cloud image URL"
  default     = "https://cloud-images.ubuntu.com/noble/20241210/noble-server-cloudimg-amd64.img"
}

variable "nas_pve_node" {
  type        = string
  description = "PVE node to create the NAS VM"
  default     = "homelab2"
}

variable "nas_ipv4_address" {
  type        = string
  description = "IPv4 address for the NAS VM (CIDR notation)"
  default     = "192.168.0.40/32"
}

variable "nas_ipv4_gateway" {
  type        = string
  description = "IPv4 gateway for the NAS VM"
  default     = "192.168.0.1"
}

variable "nas_hostname" {
  type        = string
  description = "Hostname for the NAS VM"
  default     = "storage"
}

variable "k3s_nodes" {
  type = map(object({
    pve_node  = string
    cpu_cores = number
    role      = string
    memory    = number
  }))
  description = "Map of k3s nodes to configuration"
  default = {
    alpha = {
      pve_node  = "homelab1",
      cpu_cores = 8,
      role      = "server",
      memory    = 8192
    },
    beta = {
      pve_node  = "homelab2",
      cpu_cores = 8,
      role      = "agent",
      memory    = 16384
    },
    gamma = {
      pve_node  = "homelab3",
      cpu_cores = 4,
      role      = "agent",
      memory    = 12288
    }
  }

  validation {
    condition     = alltrue([for node in values(var.k3s_nodes) : node.role == "server" || node.role == "agent"])
    error_message = "Invalid role. Must be 'server' or 'agent'."
  }
}
