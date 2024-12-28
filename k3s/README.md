# k3s cluster

My homelab cluster.

`make bootstrap` to bootstrap the cluster with Argo CD.
Argo CD will manage itself, infrastructure apps and client facing apps.

## Requirements

### `remote-secret.enc.yaml` file

I use [External Secrets](https://external-secrets.io/) to manage secrets,
with [Doppler](https://external-secrets.io/latest/provider/doppler/)
as a remote secrets store.
A service account token is needed for authentication.
To keep the token inside git repo for version control, I encrypted it with [SOPS](https://github.com/mozilla/sops).

`make bootstrap` decrypts the file and creates a secret with the decrypted token in the cluster.

An alternative approach is to use [kustomize-sops](https://github.com/viaduct-ai/kustomize-sops#argo-cd-integration) and keep all my secrets as encrypted files in repo.
However, I recently lost my local Terraform state file while moving folders around, so I'd prefer remote storage for all important data.
