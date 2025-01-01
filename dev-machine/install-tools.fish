#!/usr/bin/env bash

echo 'Installing system utilities'
sudo apt install -y net-tools make yq unzip
pipx install xxh-xxh

# Security tools
echo 'Installing security tools'
curl -LO https://github.com/getsops/sops/releases/download/v3.9.2/sops-v3.9.2.linux.amd64
sudo mv sops-v3.9.2.linux.amd64 /usr/local/bin/sops
sudo chmod +x /usr/local/bin/sops

sudo apt install -y age
set -Ux SOPS_AGE_KEY_FILE /home/viet/.key.age

# Python pipx cli
echo 'Installing pipx'
sudo apt install -y pipx
pipx ensurepath
register-python-argcomplete --shell fish pipx >~/.config/fish/completions/pipx.fish

# provisioning tools
echo 'Installing provisioning tools'
sudo snap install --classic opentofu
pipx install --include-deps ansible

# k3s tools
echo 'Installing k3s tools'

## core
sudo snap install --classic opentofu kubectl helm

## ArgoCD
set ARGO_VERSION v2.14.0-rc3
echo "Installing ArgoCD CLI version ${ARGO_VERSION}..."
curl -sSL -o /tmp/argocd-linux-amd64 "https://github.com/argoproj/argo-cd/releases/download/${ARGO_VERSION}/argocd-linux-amd64"
sudo install -m 555 /tmp/argocd-linux-amd64 /usr/local/bin/argocd
rm /tmp/argocd-linux-amd64

## K9s
set K9S_VERSION v0.32.7
echo "Installing K9s version ${K9S_VERSION}..."
curl -sSL -o /tmp/k9s.deb "https://github.com/derailed/k9s/releases/download/${K9S_VERSION}/k9s_linux_amd64.deb"
sudo apt install -y /tmp/k9s.deb
rm /tmp/k9s.deb

# nodejs
echo 'Installing fnm, node 22 and pnpm'
curl -o- https://fnm.vercel.app/install | bash
fnm completions > ~/.config/fish/completions/fnm.fish
fnm install 22
corepack enable pnpm
pnpm -v

# media tools
echo 'Installing tools for downloading audible'
sudo apt install -y jq ffmpeg
pipx install audible-cli
mkdir -p $HOME/scripts
curl -o $HOME/scripts/audible-convert.sh \
  https://raw.githubusercontent.com/jvanbruegge/nix-config/refs/heads/master/scripts/audible-convert.sh
sed -i 's/language\.\[0:3\]/language[0:3]/g' \
  $HOME/scripts/audible-convert.sh

# https://learn.microsoft.com/en-us/archive/blogs/wsl/file-system-improvements-to-the-windows-subsystem-for-linux
# echo 'Mounting windows network drives to WSL'
# sudo mkdir /mnt/z
# sudo mount -t drvfs Z: /mnt/z
