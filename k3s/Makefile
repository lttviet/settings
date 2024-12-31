default: bootstrap

.PHONY: bootstrap
bootstrap:
		# redirect http to https for traefik
		kubectl apply -f patches/traefik.yaml
		# install ArgoCD
		kubectl apply -n argocd -k argocd
		# restart argocd
		kubectl delete pod -n argocd -l app.kubernetes.io/name=argocd-server
		# create Secret for remote secret store
		sops -d remote-secret.enc.yaml | kubectl apply -f -
		# bootstrap the cluster with App of Apps
		kubectl apply -f root-app.yaml
