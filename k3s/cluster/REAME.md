# `/cluster`

`/cluster` contains all the core apps for the cluster.

## Apps

- [MetalLB](https://metallb.io/): replace default k3s load balancer
- [External Secrets Operator](https://external-secrets.io/): inject secrets from remote sources into cluster
- [cert-manager](https://cert-manager.io/): generate TLS certificates
- [Reloader](https://github.com/stakater/Reloader): watch for changes in ConfigMap and reload pods

## `/cluster/core`

Configuration for the core apps.
