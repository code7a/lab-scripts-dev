#!/bin/bash
#install k3s - ubuntu
apt update -y
curl -sfL https://get.k3s.io | sh -
echo 'export KUBECONFIG=/etc/rancher/k3s/k3s.yaml' > .bash_profile
source .bash_profile
echo 'export KUBECONFIG=/etc/rancher/k3s/k3s.yaml' > /etc/profile.d/kubeconfig.sh
curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash
service k3s restart
#emoji vote sample app
git clone https://github.com/digitalocean/kubernetes-sample-apps.git
kubectl apply -k kubernetes-sample-apps/emojivoto-example/kustomize
#yelb sample app
git clone https://github.com/mreferre/yelb.git
kubectl create namespace yelb
curl -O https://raw.githubusercontent.com/code7a/lab-scripts-dev/main/sample-apps/yelb-with-annotations.yml
kubectl apply --namespace yelb -f yelb-with-annotations.yml
#illumio annotations
#haproxy
apt install haproxy -y
echo "frontend emojivote_frontend
 bind *:81
 mode tcp
 default_backend emojivote_backend
backend emojivote_backend
 mode tcp
 server localhost $(kubectl get service -n emojivoto | grep web-svc | cut -d' ' -f10):80 check
frontend yelb_frontend
 bind *:82
 mode tcp
 default_backend yelb_backend
backend yelb_backend
 mode tcp
 server localhost $(kubectl get service -n yelb | grep yelb-ui | cut -d' ' -f14):80 check" > /etc/haproxy/haproxy.cfg
service haproxy restart
#shutdown in 8 hours
shutdown +480
