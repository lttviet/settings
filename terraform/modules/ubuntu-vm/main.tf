terraform {
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "~> 0.76.0"
    }
  }
}

locals {
  ipv4_gateway = var.ipv4_address == "dhcp" ? null : var.ipv4_gateway
}

resource "proxmox_virtual_environment_vm" "ubuntu_vm" {
  name      = var.hostname
  node_name = var.pve_node

  agent {
    enabled = true
  }

  startup {
    order = var.startup_order
  }

  initialization {
    ip_config {
      ipv4 {
        address = var.ipv4_address
        gateway = local.ipv4_gateway
      }
    }

    datastore_id      = "local-zfs"
    user_data_file_id = var.user_data_file_id
    meta_data_file_id = var.meta_data_file_id
  }

  disk {
    datastore_id = var.disk_datastore_id
    file_id      = var.cloud_image_file_id
    interface    = "scsi0"
    discard      = "on"
    size         = var.disk_size
    ssd          = true
  }

  memory {
    dedicated = var.memory
  }

  cpu {
    type  = "x86-64-v2-AES"
    cores = var.cpu_cores
  }

  network_device {
    bridge = "vmbr0"
  }
}
