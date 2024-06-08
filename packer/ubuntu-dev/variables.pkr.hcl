variable "username" {
  type    = string
  default = "packer@pve"
}

variable "password" {
  type    = string
  default = "packer@pve"
  sensitive = true
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
  sensitive = true
}

variable "samba_server" {
  type    = string
  default = "192.168.100.1"
}

variable "samba_username" {
  type    = string
  default = "smbclient"
}

variable "samba_password" {
  type    = string
  default = "password"
  sensitive = true
}
