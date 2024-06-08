packer {
  required_plugins {
    name = {
      version = "~> 1"
      source  = "github.com/hashicorp/proxmox"
    }
  }
}

source "proxmox-iso" "ubuntu" {
  vm_name              = "ubuntu-dev"
  template_name        = "ubuntu-24.04"
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
    source      = "./upload/key.txt"
    destination = "/home/viet/"
  }

  provisioner "file" {
    source      = "./upload/init.sh"
    destination = "/home/viet/"
  }

  provisioner "shell" {
    inline = [
      "sudo bash /home/viet/init.sh",
      "rm /home/viet/init.sh",
      # TODO move credentials to a file
      "echo '//${var.samba_server}/configs /mnt/configs cifs username=${var.samba_username},password=${var.samba_password},uid=1000,gid=1000 0 0' | sudo tee -a /etc/fstab",
      "echo '//${var.samba_server}/repos /mnt/repos cifs username=${var.samba_username},password=${var.samba_password},uid=1000,gid=1000 0 0' | sudo tee -a /etc/fstab"
    ]
  }
}
