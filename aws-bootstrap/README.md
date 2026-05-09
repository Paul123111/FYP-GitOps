# AWS-Bootstrap

This directory sets up a master node, and two worker nodes as EC2 instances on AWS

A secret K3s token will need to be set up to connect the worker nodes to the
cluster.

Bash: (note - if using Windows, add `export MSYS_NO_PATHCONV=1` before running
code below)
```
K3S_TOKEN="$(openssl rand -base64 32)"
aws ssm put-parameter \
    --name "/k3s/fyp-token" \
    --value "$K3S_TOKEN" \
    --type "SecureString" \
    --description "Shared secret for K3s worker nodes" \
    --overwrite
```

Powershell:
```
Set-Variable -Name "K3S_TOKEN" -Value (openssl rand -base64 32)
aws ssm put-parameter `
    --name "/k3s/fyp-token" `
    --value "$K3S_TOKEN" `
    --type "SecureString" `
    --description "Shared secret for K3s worker nodes" `
    --overwrite
```

