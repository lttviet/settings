packer {
  required_plugins {
    name = {
      version = "~> 1"
      source  = "github.com/hashicorp/proxmox"
    }
  }
}

source "proxmox-iso" "ubuntu" {
  vm_name              = "composer"
  template_name        = "composer"
  template_description = "Ubuntu 24.04, generated on ${timestamp()}"
  os                   = "l26"
  cores                = 8
  cpu_type             = "x86-64-v2-AES"
  memory               = 8192
  scsi_controller      = "virtio-scsi-single"

  iso_file    = "local:iso/ubuntu-24.04-live-server-amd64.iso"
  unmount_iso = true

  node                     = var.node
  proxmox_url              = "https://${var.pve_host}/api2/json"
  insecure_skip_tls_verify = true
  username                 = var.proxmox_username
  password                 = var.proxmox_password

  http_directory = "http"
  boot_wait      = "5s"
  boot_command   = ["<wait>e<wait><down><down><down><end><wait> autoinstall ds=nocloud-net\\;s=http://{{.HTTPIP}}:{{.HTTPPort}}/<f10><wait>"]
  ssh_username   = var.ssh_username
  ssh_password   = var.ssh_password
  ssh_timeout    = "10m"

  disks {
    disk_size    = "20G"
    storage_pool = "datapool"
    type         = "scsi"
    discard      = true
    ssd          = true
    io_thread    = true
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

  provisioner "file" {
    content     = "username=${var.samba_username}\npassword=${var.samba_password}"
    destination = "/home/viet/.smbcredentials"
  }

  provisioner "shell" {
    script          = "./upload/init.sh"
    execute_command = "sudo bash -c '{{ .Vars }} {{ .Path }}'"
    environment_vars = [
      "SAMBA_SERVER=${var.samba_server}",
      "SSH_USERNAME=${var.ssh_username}"
    ]
  }
}
