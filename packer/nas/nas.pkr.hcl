packer {
  required_plugins {
    name = {
      version = "~> 1"
      source  = "github.com/hashicorp/proxmox"
    }
  }
}

source "proxmox-iso" "ubuntu" {
  vm_name              = "nas"
  template_name        = "nas"
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
    disk_size    = "50G"
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
    source      = "./upload/smb.conf"
    destination = "/tmp/"
  }

  provisioner "shell" {
    inline = [
      "echo 'debconf debconf/frontend select Noninteractive' | sudo debconf-set-selections",
      "sudo apt-get install samba -y",
      "sudo mkdir -p /shares/configs /shares/download /shares/repos /shares/media /shares/logs",
      "sudo adduser --system --group ${var.samba_username}",
      "sudo chmod 775 -R /shares",
      "sudo chown ${var.samba_username}:${var.samba_username} -R /shares",
      "echo '${var.samba_password}\n${var.samba_password}' | sudo smbpasswd -a -s ${var.samba_username}",
      "sudo mv /etc/samba/smb.conf /etc/samba/smb.conf.old",
      "sudo mv /tmp/smb.conf /etc/samba/smb.conf"
    ]
  }
}
