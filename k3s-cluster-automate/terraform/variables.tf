variable "vm_username" {
  type        = string
  description = "VM username"
  default     = "viet"
}

variable "k3s_nodes" {
  type        = map(any)
  description = "Map of k3s server nodes to configuration"
  default = {
    alpha = {
      pve_node = "homelab1",
      vm_id    = 3001,
      cores    = 8,
      role     = "server",
    },
    beta = {
      pve_node = "homelab2",
      vm_id    = 3002,
      cores    = 8,
      role     = "agent",
    },
    gamma = {
      pve_node = "homelab3",
      vm_id    = 3003,
      cores    = 4,
      role     = "agent",
    }
  }
}
