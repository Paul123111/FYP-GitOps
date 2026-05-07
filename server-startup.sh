#!/bin/bash

#####################
# infra-startup.sh
#####################
# This script starts up a new infrastructure/master node
# It installs and runs k3s and argocd
#
# ArgoCD takes the results
#
#####################

ARGOCD_REPO_APP=https://raw.githubusercontent.com/Paul123111/FYP-GitOps/refs/heads/main/bootstrap/root-app.yaml

# swapfile for stability
fallocate -l 2G /swapfile && chmod 600 /swapfile && mkswap /swapfile && swapon /swapfile
echo '/swapfile none swap sw 0 0' >> /etc/fstab

curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="--disable traefik" sh -
export KUBECONFIG=/etc/rancher/k3s/k3s.yaml

kubectl create namespace argocd
kubectl apply -n argocd -f https://githubusercontent.com

kubectl apply -f https://raw.githubusercontent.com/Paul123111/FYP-GitOps/refs/heads/main/bootstrap/root-app.yaml


