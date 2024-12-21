terraform {
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "0.69.0"
    }
    local = {
      source  = "hashicorp/local"
      version = "2.5.2"
    }
    sops = {
      source  = "carlpett/sops"
      version = "1.1.1"
    }
  }
}

provider "sops" {}

data "sops_file" "secrets" {
  source_file = "${path.module}/secrets.yaml"
}

provider "proxmox" {
  endpoint = data.sops_file.secrets.data["pve_endpoint"]
  username = data.sops_file.secrets.data["pve_username"]
  password = data.sops_file.secrets.data["pve_password"]
  insecure = true
}

resource "proxmox_virtual_environment_download_file" "ubuntu_cloud_images" {
  for_each = var.k3s_nodes

  content_type = "iso"
  datastore_id = "local"
  node_name    = each.value.pve_node
  url          = "https://cloud-images.ubuntu.com/noble/20241210/noble-server-cloudimg-amd64.img"
}

resource "proxmox_virtual_environment_vm" "ubuntu_vms" {
  for_each = var.k3s_nodes

  name      = each.key
  node_name = each.value.pve_node
  vm_id     = each.value.vm_id

  agent {
    enabled = true
  }

  startup {
    order    = "3"
    up_delay = "60"
  }

  initialization {
    ip_config {
      ipv4 {
        address = "dhcp"
      }
    }

    datastore_id      = "local-zfs"
    user_data_file_id = proxmox_virtual_environment_file.user_data_cloud_configs[each.key].id
    meta_data_file_id = proxmox_virtual_environment_file.meta_data_cloud_configs[each.key].id
  }

  disk {
    datastore_id = "local-zfs"
    file_id      = proxmox_virtual_environment_download_file.ubuntu_cloud_images[each.key].id
    interface    = "scsi0"
    discard      = "on"
    size         = 10
    ssd          = true
  }

  memory {
    dedicated = 8192
  }

  cpu {
    type  = "x86-64-v2-AES"
    cores = each.value.cores
  }

  network_device {
    bridge = "vmbr0"
  }

  serial_device {
    device = "socket"
  }
}

locals {
  inventory_content = templatefile("${path.module}/../ansible/inventory.yaml.tftpl", {
    nodes = {
      for k, v in proxmox_virtual_environment_vm.ubuntu_vms :
      k => {
        ip   = one(flatten(v.ipv4_addresses[1]))
        role = var.k3s_nodes[k].role
      }
    }
    k3s_token = data.sops_file.secrets.data["k3s_token"]
  })
}

resource "local_file" "inventory" {
  content  = local.inventory_content
  filename = "${path.module}/../ansible/inventory.yaml"
}
