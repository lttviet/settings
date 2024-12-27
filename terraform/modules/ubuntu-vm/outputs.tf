output "ipv4_address" {
  value = one(flatten(proxmox_virtual_environment_vm.ubuntu_vm.ipv4_addresses[1]))
}
