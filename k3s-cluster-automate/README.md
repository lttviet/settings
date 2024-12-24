# K3s Automation

`/terraform` provisions 1 NAS VM and 3 VMs in my Proxmox cluster.
It also creates `inventory.yaml` for Ansible to install K3s cluster to the 3 VMs.
After running Ansible, it copies the cluster config to local `.kube/config` file for `kubectl` to work locally.

`/manifests` contains plain k8s manifests to be deployed by `kubectl`.
