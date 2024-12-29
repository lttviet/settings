# `/infrastructure`

`/infrastructure` contains all the core components of the k3s cluster.

## `/infrastructure/controllers`

- [MetalLB](https://metallb.io/): replace default k3s load balancer
- [External Secrets Operator](https://external-secrets.io/): inject secrets from remote sources into cluster

## `/infrastructure/configs`

It exposes 1 IP pool for Traefik.
