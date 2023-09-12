#install configure k3s
curl -sfL https://get.k3s.io | sh -
echo "export KUBECONFIG=/etc/rancher/k3s/k3s.yaml" >> .bash_profile
source .bash_profile
curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash
rm -rf /etc/machine-id; systemd-machine-id-setup;
service k3s restart
#get illumio-values.yaml
pce="$(echo $(hostname) | cut -d. -f1).snc.$(echo $(hostname) | cut -d. -f2-4).$(echo $(hostname) | cut -d. -f6-8)"
curl $pce/illumio-values.yaml -o illumio-values.yaml
curl $pce/chain.pem -o /chain.crt
cat /chain.crt >> /etc/pki/tls/certs/ca-bundle.crt
#helm install
kubectl create ns illumio-system
kubectl --namespace illumio-system create configmap root-ca-config --from-file=/chain.crt
helm install illumio -f illumio-values.yaml oci://quay.io/illumio/illumio --namespace illumio-system
#create nginx deployment
kubectl create deployment nginx-alpha --image=nginx
kubectl create service nodeport nginx-alpha --tcp=80:80
