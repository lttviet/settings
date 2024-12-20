default: deploy

.PHONY: deploy
deploy:
		kubectl apply -f namespace.yaml
		sops -d secrets.yaml | kubectl apply -f -
		kubectl apply -f homepage.yaml
		kubectl apply -f sillytavern.yaml
		kubectl apply -f navidrome.yaml
		kubectl apply -f cloudflared.yaml

# May fail 1st time because it takes a while to create webhook
.PHONY: cert
cert:
		kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/v1.15.1/cert-manager.yaml
		kubectl apply -f cert.yaml
