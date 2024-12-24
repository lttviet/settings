default: init

.PHONY: init
init:
		kubectl apply -f namespace.yaml
		sops -d secrets-k3s.yaml | kubectl apply -f -
		kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/v1.15.1/cert-manager.yaml
		kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.14.9/config/manifests/metallb-native.yaml
		kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
    # webhoook takes some time to be ready
		sleep 60
		kubectl apply -f cert.yaml
		kubectl apply -f metallb.yaml

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
