variable "proxmox_username" {
  type    = string
  default = "packer@pve"
}

variable "proxmox_password" {
  type    = string
  default = "packer@pve"
}

variable "pve_host" {
  type    = string
  default = "homelab.lan:8006"
}

variable "node" {
  type    = string
  default = "homelab2"
}

variable "ssh_username" {
  type    = string
  default = "viet"
}

variable "ssh_password" {
  type    = string
  default = "password"
}

variable "samba_server" {
  type    = string
  default = "192.168.100.1"
}

variable "samba_username" {
  type    = string
  default = "samba"
}

variable "samba_password" {
  type    = string
  default = "password"
}
