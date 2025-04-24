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
  default     = "https://cloud-images.ubuntu.com/noble/20250403/noble-server-cloudimg-amd64.img"
}

variable "nas_pve_node" {
  type        = string
  description = "PVE node to create the NAS VM"
  default     = "homelab2"
}

variable "nas_ipv4_address" {
  type        = string
  description = "IPv4 address for the NAS VM (CIDR notation)"
  default     = "192.168.1.40/24"
}

variable "nas_ipv4_gateway" {
  type        = string
  description = "IPv4 gateway for the NAS VM"
  default     = "192.168.1.1"
}

variable "nas_hostname" {
  type        = string
  description = "Hostname for the NAS VM"
  default     = "storage"
}

variable "k3s_nodes" {
  type = map(object({
    pve_node     = string
    cpu_cores    = number
    role         = string
    memory       = number
    ipv4_address = string
    ipv4_gateway = string
  }))
  description = "Map of k3s nodes to configuration"
  default = {
    alpha = {
      pve_node     = "homelab1",
      cpu_cores    = 8,
      role         = "server",
      memory       = 8192,
      ipv4_address = "192.168.1.20/24",
      ipv4_gateway = "192.168.1.1"
    },
    beta = {
      pve_node     = "homelab2",
      cpu_cores    = 8,
      role         = "agent",
      memory       = 16384,
      ipv4_address = "192.168.1.21/24",
      ipv4_gateway = "192.168.1.1"
    },
    gamma = {
      pve_node     = "homelab3",
      cpu_cores    = 4,
      role         = "agent",
      memory       = 12288,
      ipv4_address = "192.168.1.22/24",
      ipv4_gateway = "192.168.1.1"
    }
  }

  validation {
    condition     = alltrue([for node in values(var.k3s_nodes) : node.role == "server" || node.role == "agent"])
    error_message = "Invalid role. Must be 'server' or 'agent'."
  }
}

# variable "tailscale_nodes" {
#   type = map(object({
#     pve_node = string
#   }))
#   description = "Map of tailscale nodes to configuration"
#   default = {
#     ts1 = {
#       pve_node = "homelab1"
#     },
#     ts2 = {
#       pve_node = "homelab2"
#     },
#     ts3 = {
#       pve_node = "homelab3"
#     }
#   }
# }
