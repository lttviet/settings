terraform {
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "~> 0.89.0"
    }
    local = {
      source  = "hashicorp/local"
      version = "~> 2.6.0"
    }
    sops = {
      source  = "carlpett/sops"
      version = "~> 1.3.0"
    }
  }
}

provider "sops" {}

data "sops_file" "secrets" {
  source_file = "${path.module}/secrets-tf.enc.yaml"
}

locals {
  pve_endpoint   = data.sops_file.secrets.data["pve_endpoint"]
  pve_username   = data.sops_file.secrets.data["pve_username"]
  pve_password   = data.sops_file.secrets.data["pve_password"]
  samba_username = data.sops_file.secrets.data["samba_username"]
  samba_password = data.sops_file.secrets.data["samba_password"]
  k3s_token      = data.sops_file.secrets.data["k3s_token"]
  ssh_public_keys = yamldecode(data.sops_file.secrets.raw).ssh_public_keys
}

provider "proxmox" {
  endpoint = local.pve_endpoint
  username = local.pve_username
  password = local.pve_password
  insecure = true
}

# Download image to specified PVE nodes
resource "proxmox_virtual_environment_download_file" "cloud_images" {
  for_each = toset(var.pve_nodes)

  content_type = "iso"
  datastore_id = "local"
  node_name    = each.value
  url          = var.image_url
}

# Create snippets for NAS cloud config
resource "proxmox_virtual_environment_file" "nas_user_data" {
  content_type = "snippets"
  datastore_id = "local"
  node_name    = var.nas_pve_node

  source_raw {
    data = templatefile("${path.root}/cloud-init/nas-user-data.yaml.tftpl", {
      username        = var.username
      ssh_public_keys = local.ssh_public_keys
      samba_username  = local.samba_username
      samba_password  = local.samba_password
    })

    file_name = "${var.nas_hostname}-user-data.yaml"
  }
}

resource "proxmox_virtual_environment_file" "nas_meta_data" {
  content_type = "snippets"
  datastore_id = "local"
  node_name    = var.nas_pve_node

  source_raw {
    data = templatefile("${path.root}/cloud-init/meta-data.yaml.tftpl", {
      hostname = var.nas_hostname
    })

    file_name = "${var.nas_hostname}-meta-data.yaml"
  }
}

# Provision NAS VM
module "nas_server" {
  source = "./modules/ubuntu-vm"

  hostname     = var.nas_hostname
  username     = var.username
  pve_node     = var.nas_pve_node
  ipv4_address = var.nas_ipv4_address
  ipv4_gateway = var.nas_ipv4_gateway

  startup_order = "1"

  cpu_cores = 4
  memory    = 4096

  disk_datastore_id = "datapool"
  disk_size         = 500

  cloud_image_file_id = proxmox_virtual_environment_download_file.cloud_images[var.nas_pve_node].id
  user_data_file_id   = proxmox_virtual_environment_file.nas_user_data.id
  meta_data_file_id   = proxmox_virtual_environment_file.nas_meta_data.id
}

# Create snippets for K3S VM cloud configs
resource "proxmox_virtual_environment_file" "k3s_user_data_list" {
  for_each = var.k3s_nodes

  content_type = "snippets"
  datastore_id = "local"
  node_name    = each.value.pve_node

  source_raw {
    data = templatefile("${path.root}/cloud-init/base-user-data.yaml.tftpl", {
      username        = var.username
      ssh_public_keys = local.ssh_public_keys
      nas_server      = var.nas_ipv4_address
    })

    file_name = "${each.key}-user-data.yaml"
  }
}

resource "proxmox_virtual_environment_file" "k3s_meta_data_list" {
  for_each = var.k3s_nodes

  content_type = "snippets"
  datastore_id = "local"
  node_name    = each.value.pve_node

  source_raw {
    data = templatefile("${path.root}/cloud-init/meta-data.yaml.tftpl", {
      hostname = each.key
    })

    file_name = "${each.key}-meta-data.yaml"
  }
}

# Provision K3S VMs
module "k3s_vms" {
  for_each = var.k3s_nodes

  source = "./modules/ubuntu-vm"

  hostname     = each.key
  username     = var.username
  pve_node     = each.value.pve_node
  ipv4_address = each.value.ipv4_address
  ipv4_gateway = each.value.ipv4_gateway

  startup_order = "2"

  cpu_cores = each.value.cpu_cores
  memory    = each.value.memory

  disk_datastore_id = "local-zfs"
  disk_size         = 50

  cloud_image_file_id = proxmox_virtual_environment_download_file.cloud_images[each.value.pve_node].id
  user_data_file_id   = proxmox_virtual_environment_file.k3s_user_data_list[each.key].id
  meta_data_file_id   = proxmox_virtual_environment_file.k3s_meta_data_list[each.key].id
}

# Generate ansible inventory.yaml
locals {
  inventory_content = templatefile("${path.root}/../ansible/inventory.yaml.tftpl", {
    nodes = {
      for k, v in module.k3s_vms :
      k => {
        ip   = v.ipv4_address
        role = var.k3s_nodes[k].role
      }
    }
    k3s_token = data.sops_file.secrets.data["k3s_token"]
  })
}

resource "local_file" "inventory" {
  content  = local.inventory_content
  filename = "${path.root}/../ansible/inventory.yaml"
}

output "nas_ip" {
  value = module.nas_server.ipv4_address
}

output "k3s_ips" {
  value = [for vm in module.k3s_vms : vm.ipv4_address]
}
