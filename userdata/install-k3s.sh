#!/bin/bash
#install k3s
curl -sfL https://get.k3s.io | sh -s - --write-kubeconfig-mode 644
#install helm
curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash
service k3s restart
#shutdown in 8 hours
shutdown +480