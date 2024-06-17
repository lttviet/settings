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
  default = "homelab1.lan:8006"
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

variable "samba_username" {
  type    = string
  default = "smbclient"
}

variable "samba_password" {
  type    = string
  default = "password"
}
