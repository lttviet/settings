# infrastructure

`/infrastructure` contains all the core components of the k3s cluster.

The current list is:

- `/infrastructure/metallb`: [MetalLB](https://metallb.io/) exposes 1 IP pool per service
  - `192.168.0.20/32` for HTTP(S)
  - `192.168.0.30/32` for DNS
- `/infrastructure/external-secrets-operator`: [External Secrets Operator](https://external-secrets.io/) to retrieve secrets from an external secret store
- `/infrastructure/dns`:
  - `/infrastructure/dns/blocky`: [Blocky](https://github.com/0xERR0R/blocky) to  block ads and resolve local DNS queries
  - `/infrastructure/dns/redis`: [Redis](https://redis.io/) to cache DNS queries for Blocky
  - `/infrastructure/dns/coredns`: use Blocky DNS for local DNS queries
