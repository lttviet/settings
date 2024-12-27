default: bootstrap

.PHONY: bootstrap
bootstrap:
		# install ArgoCD
		kubectl apply -k argocd
		# restart argocd
		kubectl delete pod -n argocd -l app.kubernetes.io/name=argocd-server

