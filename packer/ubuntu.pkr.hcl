packer {
  required_plugins {
    name = {
      version = "~> 1"
      source  = "github.com/hashicorp/proxmox"
    }
  }
}

source "proxmox-iso" "ubuntu" {
  vm_name              = "ubuntu-vm"
  template_name        = "ubuntu-22.04.4"
  template_description = "Ubuntu 22.04.4, generated on ${timestamp()}"
  os                   = "l26"
  cores                = 4
  cpu_type             = "x86-64-v2-AES"
  memory               = 4096

  iso_file    = "local:iso/ubuntu-22.04.4-live-server-amd64.iso"
  unmount_iso = true

  node                     = var.node
  proxmox_url              = "https://${var.pve_host}/api2/json"
  insecure_skip_tls_verify = true
  username                 = var.username
  password                 = var.password

  http_directory = "http"
  boot_wait      = "5s"
  boot_command   = ["<wait>e<wait><down><down><down><end><wait> autoinstall ds=nocloud-net\\;s=http://{{.HTTPIP}}:{{.HTTPPort}}/<f10><wait>"]
  ssh_username   = var.ssh_username
  ssh_password   = var.ssh_password
  ssh_timeout    = "10m"

  disks {
    disk_size    = "10G"
    storage_pool = "local-zfs"
    type         = "scsi"
  }

  efi_config {
    efi_storage_pool  = "local-zfs"
    efi_type          = "4m"
    pre_enrolled_keys = true
  }

  network_adapters {
    bridge = "vmbr0"
    model  = "virtio"
  }
}

build {
  name = "build-ubuntu"
  sources = [
    "source.proxmox-iso.ubuntu"
  ]

  provisioner "shell" {
    inline = [
      "sudo curl -sfL https://get.k3s.io | sh -"
    ]
  }
}
