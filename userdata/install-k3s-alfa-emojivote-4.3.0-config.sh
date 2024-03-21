#!/bin/bash
#get pce cert
curl -k -O http://$PublicDnsName:80/server.crt
cp server.crt /usr/local/share/ca-certificates/
update-ca-certificates
#install k3s
curl -k -sfL https://get.k3s.io | sh -s - --write-kubeconfig-mode 644
#install helm
curl -k https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash
service k3s restart
#emoji vote sample app
git clone https://github.com/digitalocean/kubernetes-sample-apps.git
kubectl apply -k kubernetes-sample-apps/emojivoto-example/kustomize
#install and configure haproxy
apt install haproxy -y
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
#wait till pce is up
while true; do
  http_response_code=$(curl -k -s -o /dev/null -I -w "%{http_code}" https://$PublicDnsName:8443/login)
  echo $http_response_code
  if [ "$http_response_code" == "200" ];then
    break
  fi
  sleep 300
done
update-ca-certificates
#create pce objects
#auth
basic_auth_token=$(echo -n "$pce_admin_username_email_address:$pce_admin_password"|base64)
auth_token=$(curl -v -k -X POST -H "Authorization: Basic $basic_auth_token" https://$PublicDnsName:8443/api/v2/login_users/authenticate?pce_fqdn=$PublicDnsName | jq -r '.auth_token')
login_response=$(curl -k -H "Authorization: Token token=$auth_token" https://$PublicDnsName:8443/api/v2/users/login)
auth_username=$(echo $login_response | jq -r '.auth_username')
session_token=$(echo $login_response | jq -r '.session_token')
#create labels
#create node role label
labels_node_href=$(curl -k -u $auth_username:$session_token https://$PublicDnsName:8443/api/v2/orgs/1/labels -H 'Content-Type: application/json' --data-raw '{"key":"role","value":"R-NODE"}' | jq -r '.href')
echo $? | grep 0 || labels_node_href=$(curl -k -s -u $auth_username:$session_token "https://$PublicDnsName:8443/api/v2/orgs/1/labels?key=role&value=R-NODE" | jq -r .[].href)
#create container role label
labels_container_href=$(curl -k -u $auth_username:$session_token https://$PublicDnsName:8443/api/v2/orgs/1/labels -H 'Content-Type: application/json' --data-raw '{"key":"role","value":"R-CONTAINER"}' | jq -r '.href')
echo $? | grep 0 || labels_container_href=$(curl -k -s -u $auth_username:$session_token "https://$PublicDnsName:8443/api/v2/orgs/1/labels?key=role&value=R-CONTAINER" | jq -r .[].href)
#create web role label
labels_web_href=$(curl -k -u $auth_username:$session_token https://$PublicDnsName:8443/api/v2/orgs/1/labels -H 'Content-Type: application/json' --data-raw '{"key":"role","value":"R-WEB"}' | jq -r '.href')
echo $? | grep 0 || labels_web_href=$(curl -k -s -u $auth_username:$session_token "https://$PublicDnsName:8443/api/v2/orgs/1/labels?key=role&value=R-WEB" | jq -r .[].href)
#create list role label
labels_list_href=$(curl -k -u $auth_username:$session_token https://$PublicDnsName:8443/api/v2/orgs/1/labels -H 'Content-Type: application/json' --data-raw '{"key":"role","value":"R-LIST"}' | jq -r '.href')
echo $? | grep 0 || labels_list_href=$(curl -k -s -u $auth_username:$session_token "https://$PublicDnsName:8443/api/v2/orgs/1/labels?key=role&value=R-LIST" | jq -r .[].href)
#create vote role label
labels_vote_href=$(curl -k -u $auth_username:$session_token https://$PublicDnsName:8443/api/v2/orgs/1/labels -H 'Content-Type: application/json' --data-raw '{"key":"role","value":"R-VOTE"}' | jq -r '.href')
echo $? | grep 0 || labels_vote_href=$(curl -k -s -u $auth_username:$session_token "https://$PublicDnsName:8443/api/v2/orgs/1/labels?key=role&value=R-VOTE" | jq -r .[].href)
#create bot role label
labels_bot_href=$(curl -k -u $auth_username:$session_token https://$PublicDnsName:8443/api/v2/orgs/1/labels -H 'Content-Type: application/json' --data-raw '{"key":"role","value":"R-BOT"}' | jq -r '.href')
echo $? | grep 0 || labels_bot_href=$(curl -k -s -u $auth_username:$session_token "https://$PublicDnsName:8443/api/v2/orgs/1/labels?key=role&value=R-BOT" | jq -r .[].href)
#create k3s app label
labels_k3s_href=$(curl -k -u $auth_username:$session_token https://$PublicDnsName:8443/api/v2/orgs/1/labels -H 'Content-Type: application/json' --data-raw '{"key":"app","value":"A-K3S"}' | jq -r '.href')
echo $? | grep 0 || labels_k3s_href=$(curl -k -s -u $auth_username:$session_token "https://$PublicDnsName:8443/api/v2/orgs/1/labels?key=app&value=A-K3S" | jq -r .[].href)
#create emojivote app label
labels_emojivote_href=$(curl -k -u $auth_username:$session_token https://$PublicDnsName:8443/api/v2/orgs/1/labels -H 'Content-Type: application/json' --data-raw '{"key":"app","value":"A-EMOJIVOTE"}' | jq -r '.href')
echo $? | grep 0 || labels_emojivote_href=$(curl -k -s -u $auth_username:$session_token "https://$PublicDnsName:8443/api/v2/orgs/1/labels?key=app&value=A-EMOJIVOTE" | jq -r .[].href)
#get prod label href
labels_prod_href=$(curl -k -u $auth_username:$session_token "https://$PublicDnsName:8443/api/v2/orgs/1/labels?key=env&value=Production" | jq -r .[].href)
#get amazon label href
labels_amazon_href=$(curl -k -u $auth_username:$session_token "https://$PublicDnsName:8443/api/v2/orgs/1/labels?key=loc&value=Amazon" | jq -r .[].href)
#create containter cluster
container_clusters_response=$(curl -k -u $auth_username:$session_token https://$PublicDnsName:8443/api/v2/orgs/1/container_clusters -X POST -H 'content-type: application/json' --data-raw '{"name":"k3s-alfa","description":""}')
pce_container_clusters_cluster_id=$(echo $container_clusters_response | jq -r .href | cut -d/ -f5)
pce_container_clusters_cluster_token=$(echo $container_clusters_response | jq -r .container_cluster_token)
#create container pairing profile
pairing_profiles_response=$(curl -k -u $auth_username:$session_token https://$PublicDnsName:8443/api/v2/orgs/1/pairing_profiles -X POST -H 'content-type: application/json' --data-raw '{"name":"pp-container_nodes","description":"","labels":[{"href":"'$labels_node_href'"},{"href":"'$labels_k3s_href'"},{"href":"'$labels_prod_href'"},{"href":"'$labels_amazon_href'"}],"enforcement_mode":"visibility_only","visibility_level":"flow_summary","allowed_uses_per_key":"unlimited","agent_software_release":null,"key_lifespan":"unlimited","app_label_lock":true,"env_label_lock":true,"loc_label_lock":true,"role_label_lock":true,"enforcement_mode_lock":true,"visibility_level_lock":true,"enabled":true,"ven_type":"server"}')
echo $? | grep 0 || pairing_profiles_response=$(curl -k -s -u $auth_username:$session_token "https://$PublicDnsName:8443/api/v2/orgs/1/pairing_profiles?name=pp-container_nodes" | jq -r .[].href)
pairing_profiles_response_href=$(echo $pairing_profiles_response | jq -r .href)
pairing_key_response=$(curl -k -u $auth_username:$session_token https://$PublicDnsName:8443/api/v2$pairing_profiles_response_href/pairing_key -X POST -H 'content-type: application/json' --data-raw '{}')
pce_container_clusters_activation_code=$(echo $pairing_key_response | jq -r .activation_code)
#get container default workload profile id
container_workload_profiles=$(curl -k -u $auth_username:$session_token https://$PublicDnsName:8443/api/v2/orgs/1/container_clusters/$pce_container_clusters_cluster_id/container_workload_profiles)
container_workload_profiles_default_id=$(echo $container_workload_profiles | jq -r .[].href | cut -d/ -f7)
#update container workload default profile
curl -k -u $auth_username:$session_token https://$PublicDnsName:8443/api/v2/orgs/1/container_clusters/$pce_container_clusters_cluster_id/container_workload_profiles/$container_workload_profiles_default_id -X PUT -H 'content-type: application/json' --data-raw '{"managed":true,"labels":[{"key":"env","assignment":{"href":"'$labels_prod_href'"}},{"key":"role","assignment":{"href":"'$labels_container_href'"}}],"enforcement_mode":"visibility_only","visibility_level":"flow_summary"}'
#create containter cluster illumio-values.yaml
cat << EOF > illumio-values.yaml
pce_url: $PublicDnsName:8443
cluster_id: $pce_container_clusters_cluster_id
cluster_token: $pce_container_clusters_cluster_token
cluster_code: $pce_container_clusters_activation_code
containerRuntime: k3s_containerd
containerManager: kubernetes
ignore_cert: true
extraVolumeMounts:
  - name: root-ca
    mountPath: /etc/pki/tls/ilo_certs/
    readOnly: false
extraVolumes:
  - name: root-ca
    configMap:
      name: root-ca-config
EOF
#helm install
export KUBECONFIG=/etc/rancher/k3s/k3s.yaml
kubectl create ns illumio-system
kubectl --namespace illumio-system create configmap root-ca-config --from-file=/usr/local/share/ca-certificates/server.crt
helm install illumio -f illumio-values.yaml oci://quay.io/illumio/illumio --namespace illumio-system --version 4.3.0
sleep 60
#get emoji vote workload profile
container_workload_profiles=$(curl -k -u $auth_username:$session_token https://$PublicDnsName:8443/api/v2/orgs/1/container_clusters/$pce_container_clusters_cluster_id/container_workload_profiles)
#get emoji vote workload profile id
container_workload_profiles_emojivote=$(echo $container_workload_profiles|jq -r '.[]|select(.namespace=="emojivoto") | .href')
#update container workload default profile
curl -k -u $auth_username:$session_token https://$PublicDnsName:8443/api/v2$container_workload_profiles_emojivote -X PUT -H 'content-type: application/json' --data-raw '{"managed":true,"labels":[{"key":"env","assignment":{"href":"'$labels_prod_href'"}},{"key":"role","assignment":{"href":"'$labels_container_href'"}},{"key":"app","assignment":{"href":"'$labels_emojivote_href'"}},{"key":"loc","assignment":{"href":"'$labels_amazon_href'"}}],"enforcement_mode":"visibility_only","visibility_level":"flow_summary","name":null,"description":""}'
