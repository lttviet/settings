# k3s cluster

My homelab cluster.

`make bootstrap` to bootstrap the cluster with Argo CD.
Argo CD will manage itself, infrastructure apps and client facing apps.

## Requirements

### `infiscial-secret.enc.yaml` file

I use [External Secrets](https://external-secrets.io/) to manage secrets,
with [Infisical](https://external-secrets.io/latest/provider/infisical/)
as a remote secrets store.
To connect to Infisical, tokens need to be passed to the cluster.
To keep the tokens inside git repo for version control, I encrypted it with [SOPS](https://github.com/mozilla/sops).

`make bootstrap` decrypts the file and creates a secret with the tokens in the cluster.

An alternative approach is to use [kustomize-sops](https://github.com/viaduct-ai/kustomize-sops#argo-cd-integration) and keep all my secrets as encrypted files in repo.
However, I recently lost my local Terraform state file while moving folders around, so I'd prefer remote storage for all important data.
