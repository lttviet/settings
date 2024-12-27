# infrastructure

`/infrastructure` contains all the core components of the k3s cluster.

The current list is:

- `/infrastructure/metallb`: [MetalLB](https://metallb.io/) exposes 1 IP pool per service
  - `192.168.0.20/32` for HTTP(S)
  - `192.168.0.30/32` for DNS
