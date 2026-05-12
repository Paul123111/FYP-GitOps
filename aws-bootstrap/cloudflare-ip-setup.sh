#!/bin/bash

# Get your Security Group ID
SG_ID="sg-0c2082b242c5082b5"

# Fetch Cloudflare IPs and add them to the Security Group
for ip in $(curl -s https://www.cloudflare.com/ips-v4); do
  aws ec2 authorize-security-group-ingress \
    --group-id $SG_ID \
    --protocol tcp \
    --port 443 \
    --cidr $ip
done
