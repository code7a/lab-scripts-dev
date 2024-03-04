#!/bin/bash
#install k3s - ubuntu
apt update -y
curl -sfL https://get.k3s.io | sh -
echo 'export KUBECONFIG=/etc/rancher/k3s/k3s.yaml' > .bash_profile
source .bash_profile
echo 'export KUBECONFIG=/etc/rancher/k3s/k3s.yaml' > /etc/profile.d/kubeconfig.sh
curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash
service k3s restart
#shutdown in 8 hours
shutdown +480
