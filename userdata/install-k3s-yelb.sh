#!/bin/bash
#install k3s
curl -sfL https://get.k3s.io | sh -s - --write-kubeconfig-mode 644
#install helm
curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash
service k3s restart
#yelb sample app
git clone https://github.com/mreferre/yelb.git
kubectl create namespace yelb
curl -O https://raw.githubusercontent.com/code7a/lab-scripts-dev/main/sample-apps/yelb-with-custom-label-annotations.yml
kubectl apply --namespace yelb -f yelb-with-custom-label-annotations.yml
#install and configure haproxy
apt install haproxy -y
echo "frontend front
 bind *:81
 mode tcp
 default_backend back
backend back
 mode tcp
 server localhost $(kubectl get service -n yelb | grep yelb-ui | cut -d' ' -f14):80 check" > /etc/haproxy/haproxy.cfg
service haproxy restart
#shutdown in 8 hours
shutdown +480
