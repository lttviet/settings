resource "proxmox_virtual_environment_file" "user_data_cloud_configs" {
  for_each = var.k3s_nodes

  content_type = "snippets"
  datastore_id = "local"
  node_name    = each.value.pve_node

  source_raw {
    data = <<-EOF
    #cloud-config
    users:
      - default
      - name: ${var.vm_username}
        groups:
          - sudo
        shell: /bin/bash
        ssh_authorized_keys:
          - ${data.sops_file.secrets.data["ssh_public_key"]}
        sudo: ALL=(ALL) NOPASSWD:ALL
    runcmd:
        - apt update
        - apt upgrade -y
        - apt install -y qemu-guest-agent net-tools # need this for guest mode
        - apt install -y curl ca-certificates unattended-upgrades
        # Setup nfs mounts
        - apt install -y cifs-utils nfs-common autofs
        - echo "/nfs   /etc/auto.nfs" | tee -a /etc/auto.master
        - echo "configs  -fstype=nfs4  ${data.sops_file.secrets.data["nfs_server"]}:/configs" | tee -a /etc/auto.nfs
        - echo "configs  -fstype=nfs4  ${data.sops_file.secrets.data["nfs_server"]}:/media" | tee -a /etc/auto.nfs
        - echo "configs  -fstype=nfs4  ${data.sops_file.secrets.data["nfs_server"]}:/download" | tee -a /etc/auto.nfs
        - echo "configs  -fstype=nfs4  ${data.sops_file.secrets.data["nfs_server"]}:/logs" | tee -a /etc/auto.nfs
        - service autofs reload
        - timedatectl set-timezone America/New_York
        - systemctl enable qemu-guest-agent
        - systemctl start qemu-guest-agent
        - echo "done" > /tmp/cloud-config.done
    EOF

    file_name = "user-data-cloud-config.yaml"
  }
}

resource "proxmox_virtual_environment_file" "meta_data_cloud_configs" {
  for_each = var.k3s_nodes

  content_type = "snippets"
  datastore_id = "local"
  node_name    = each.value.pve_node

  source_raw {
    data = <<-EOF
    #cloud-config
    local-hostname: ${each.key}
    EOF

    file_name = "metadata-cloud-config.yaml"
  }
}
