#!/bin/bash

# just for testing at the moment, might be removed later

sudo apt-get install -y socat

sudo kubectl port-forward svc/argocd-server -n argocd 8080:443 > /dev/null 2>&1 &
sudo kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d

ARGOCD_PWD=$(sudo kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d)
argocd login localhost:8080 --username admin --password "$ARGOCD_PWD" --insecure

# setup ssh tunnel in two terminals
ssh -i .\.ssh\planet-hunter-key.pem -L 8080:localhost:8080 ubuntu@111.111.111.111
ssh -i .\.ssh\planet-hunter-key.pem ubuntu@111.111.111.111

sudo kubectl port-forward --address 0.0.0.0 svc/argocd-server -n argocd 8080:443

aws ssm get-parameter --name "/k3s/cloudflare-token" \
  --with-decryption --query "Parameter.Value" \
  --output text | tr -d '[:space:]' | \
  xargs -I {} sudo kubectl create secret generic cloudflare-api-token-secret -n cert-manager --from-literal=api-token={}
