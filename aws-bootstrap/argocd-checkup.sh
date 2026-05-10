#!/bin/bash

# just for testing at the moment, might be removed later

sudo kubectl port-forward svc/argocd-server -n argocd 8080:443 > /dev/null 2>&1 &

ARGOCD_PWD=$(sudo kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d)
argocd login localhost:8080 --username admin --password "$ARGOCD_PWD" --insecure

# setup ssh tunnel in two terminals
ssh -i .\.ssh\planet-hunter-key.pem -L 8080:localhost:8080 ubuntu@111.111.111.111
ssh -i .\.ssh\planet-hunter-key.pem ubuntu@111.111.111.111

sudo kubectl port-forward --address 0.0.0.0 svc/argocd-server -n argocd 8080:443
