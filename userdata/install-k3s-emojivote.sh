#!/bin/bash
#install k3s
curl -sfL https://get.k3s.io | sh -
echo 'export KUBECONFIG=/etc/rancher/k3s/k3s.yaml' > .bash_profile
source .bash_profile
echo 'export KUBECONFIG=/etc/rancher/k3s/k3s.yaml' > /etc/profile.d/kubeconfig.sh
curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash
service k3s restart
#emoji vote sample app
yum install git -y
git clone https://github.com/digitalocean/kubernetes-sample-apps.git
kubectl apply -k kubernetes-sample-apps/emojivoto-example/kustomize
#haproxy
yum install haproxy -y
echo "frontend front
 bind *:81
 mode tcp
 default_backend back
backend back
 mode tcp
 server localhost $(kubectl get service -n emojivoto | grep web-svc | cut -d' ' -f10):80 check" > /etc/haproxy/haproxy.cfg
service haproxy restart
#shutdown in 8 hours
shutdown +480
