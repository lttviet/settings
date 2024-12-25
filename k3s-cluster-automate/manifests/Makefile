default: init

.PHONY: init
init:
		kubectl apply -f namespace.yaml
		sops -d secrets-k3s.yaml | kubectl apply -f -
		kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/v1.15.1/cert-manager.yaml
		kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.14.9/config/manifests/metallb-native.yaml
		kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/v2.14.0-rc3/manifests/install.yaml
		kubectl patch configmap argocd-cmd-params-cm -n argocd --type merge -p '{"data":{"server.insecure":"true"}}'
		kubectl delete pod -n argocd -l app.kubernetes.io/name=argocd-server

		# cert-manager webhoook takes some time to be ready
		sleep 60
		kubectl apply -f cert.yaml
		kubectl apply -f metallb.yaml

.PHONY: init-argocd
init-argocd:
		argocd admin initial-password -n argocd
		argocd login argocd.local.lttviet.com --grpc-web
		argocd account update-password
		kubectl delete secret argocd-initial-admin-secret -n argocd

.PHONY: deploy-dns
deploy-dns:
		kubectl apply -f redis.yaml
		kubectl apply -f blocky.yaml

.PHONY: deploy-web
deploy-web:
		kubectl apply -f homepage.yaml
		kubectl apply -f sillytavern.yaml
		kubectl apply -f navidrome.yaml
		kubectl apply -f cloudflared.yaml
		kubectl apply -f oai.yaml

.PHONY: deploy
deploy: deploy-web deploy-dns

.PHONY: deploy-argocd-apps
deploy-argocd-apps:
		kubectl config set-context --current --namespace=argocd
		argocd app create manga-server \
			--repo https://github.com/lttviet/settings \
			--path k3s-cluster-automate/manifests/manga-server \
			--dest-server https://kubernetes.default.svc \
			--dest-namespace manga-server \
			--sync-policy automated \
 			--sync-option CreateNamespace=true
