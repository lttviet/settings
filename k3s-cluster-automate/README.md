# K3s Automation

`/terraform` provisions 3 VMs in my Proxmox cluster and create `inventory.yaml` for Ansible to install K3s cluster.
After running Ansible, it copies the cluster config to local `.kube/config` file for `kubectl` to work.

`/manifests` deploys cluster's resources.
