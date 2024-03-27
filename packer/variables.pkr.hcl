variable "username" {
  type    = string
  default = "packer@pve"
}

variable "password" {
  type    = string
  default = "packer@pve"
}

variable "pve_host" {
  type    = string
  default = "homelab.lan:8006"
}

variable "node" {
  type    = string
  default = "homelab"
}

variable "ssh_username" {
  type    = string
  default = "viet"
}

variable "ssh_password" {
  type    = string
  default = "vietviet"
}

variable "samba_server" {
  type    = string
  default = "fileserver.lan"
}

variable "samba_username" {
  type    = string
  default = "samba"
}

variable "samba_password" {
  type    = string
  default = "samba_password"
}
