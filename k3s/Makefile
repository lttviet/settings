default: bootstrap

.PHONY: bootstrap
bootstrap:
		# install ArgoCD
		kubectl create namespace argocd
		kubectl apply -n argocd -k argocd
		# restart argocd
		kubectl delete pod -n argocd -l app.kubernetes.io/name=argocd-server
		# bootstrap the cluster with App of Apps
		kubectl apply -f root-app.yaml
