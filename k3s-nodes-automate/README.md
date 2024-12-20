# K3S Automation

`/terraform` provisions 3 VMs in my Proxmox cluster.

`/ansible` installs and configures K3S cluster on them.
It copies the cluster config to local `/tmp/k3s.yaml` file.
I manually update server and copy it to `.kube/config` file for `kubectl` to work locally.

`/manifests` deploys cluster's resources.
