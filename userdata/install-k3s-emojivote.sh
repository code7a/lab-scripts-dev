#!/bin/bash
#install k3s
curl -sfL https://get.k3s.io | sh -s - --write-kubeconfig-mode 644
#install helm
curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash
service k3s restart
#emoji vote sample app
git clone https://github.com/digitalocean/kubernetes-sample-apps.git
kubectl apply -k kubernetes-sample-apps/emojivoto-example/kustomize
#install and configure haproxy
apt install haproxy -y
echo "frontend front
 bind *:80
 mode tcp
 default_backend back
backend back
 mode tcp
 server localhost $(kubectl get service -n emojivoto | grep web-svc | cut -d' ' -f10):80 check" > /etc/haproxy/haproxy.cfg
service haproxy restart
#shutdown in 8 hours
shutdown +480
