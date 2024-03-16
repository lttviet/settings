packer
===

PVE user will need at least the following roles to build a template.

```bash
pveum useradd packer@pve
pveum passwd packer@pve

pveum roleadd Packer -privs "VM.Config.Disk VM.Config.CPU VM.Config.Memory Datastore.AllocateTemplate Datastore.Audit Datastore.AllocateSpace Sys.Modify VM.Config.Options VM.Allocate VM.Audit VM.Console VM.Config.CDROM VM.Config.Cloudinit VM.Config.Network VM.PowerMgmt VM.Config.HWType VM.Monitor SDN.Use"

pveum acl modify / -user 'packer@pve' -role Packer
```
