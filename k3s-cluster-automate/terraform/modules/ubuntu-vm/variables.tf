variable "hostname" {
  type        = string
  description = "Hostname for VM"
}

variable "username" {
  type        = string
  description = "Username for the VM"
}

variable "pve_node" {
  type        = string
  description = "Proxmox node to deploy the VM on"
}

variable "ipv4_address" {
  type        = string
  description = "IPv4 address of the VM (CIDR notation)"
}

variable "ipv4_gateway" {
  type        = string
  description = "IPv4 gateway for the VM"
  default = null
}

variable "cpu_cores" {
  type        = number
  description = "Number of CPU cores for the VM"
}

variable "memory" {
  type        = number
  description = "Amount of RAM for the VM (in MB)"
}

variable "disk_datastore_id" {
  type        = string
  description = "Datastore ID for the VM's disk"
}

variable "disk_size" {
  type        = number
  description = "Disk size for the VM (in GB)"
}

variable "startup_order" {
  type        = string
  description = "Start up order for the VM"
  default = "1"
}

variable "cloud_image_file_id" {
  type        = string
  description = "ID for cloud image file in Proxmox"
}

variable "user_data_file_id" {
  type        = string
  description = "ID for user-data snippet in Proxmox"
}

variable "meta_data_file_id" {
  type        = string
  description = "ID for meta-data snippet in Proxmox"
}
