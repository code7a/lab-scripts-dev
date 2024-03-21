#!/bin/bash
#get pce cert
curl -O http://$PublicDnsName:80/server.crt
cp server.crt /usr/local/share/ca-certificates/
update-ca-certificates
#wait till pce is up
while true; do
    http_response_code=$(curl -s -o /dev/null -I -w "%{http_code}" https://$PublicDnsName:8443/login)
    echo $http_response_code
    if [ "$http_response_code" == "200" ];then
        break
    fi
    sleep 300
done
#create pce objects
#auth
basic_auth_token=$(echo -n "$pce_admin_username_email_address:$pce_admin_password"|base64)
auth_token=$(curl -X POST -H "Authorization: Basic $basic_auth_token" "https://$PublicDnsName:8443/api/v2/login_users/authenticate?pce_fqdn=$PublicDnsName" | jq -r '.auth_token')
login_response=$(curl -H "Authorization: Token token=$auth_token" https://$PublicDnsName:8443/api/v2/users/login)
auth_username=$(echo $login_response | jq -r '.auth_username')
session_token=$(echo $login_response | jq -r '.session_token')
#create labels
#create node role label
labels_node_href=$(curl -u $auth_username:$session_token https://$PublicDnsName:8443/api/v2/orgs/1/labels -H 'Content-Type: application/json' --data-raw '{"key":"role","value":"R-NODE"}' | jq -r '.href')
echo $? | grep 0 || labels_node_href=$(curl -s -u $auth_username:$session_token "https://$PublicDnsName:8443/api/v2/orgs/1/labels?key=role&value=R-NODE" | jq -r .[].href)
#create container role label
labels_container_href=$(curl -u $auth_username:$session_token https://$PublicDnsName:8443/api/v2/orgs/1/labels -H 'Content-Type: application/json' --data-raw '{"key":"role","value":"R-CONTAINER"}' | jq -r '.href')
echo $? | grep 0 || labels_container_href=$(curl -s -u $auth_username:$session_token "https://$PublicDnsName:8443/api/v2/orgs/1/labels?key=role&value=R-CONTAINER" | jq -r .[].href)
#create redis role label
labels_redis_href=$(curl -u $auth_username:$session_token https://$PublicDnsName:8443/api/v2/orgs/1/labels -H 'Content-Type: application/json' --data-raw '{"key":"role","value":"R-REDIS"}' | jq -r '.href')
echo $? | grep 0 || labels_redis_href=$(curl -s -u $auth_username:$session_token "https://$PublicDnsName:8443/api/v2/orgs/1/labels?key=role&value=R-REDIS" | jq -r .[].href)
#create app role label
labels_app_href=$(curl -u $auth_username:$session_token https://$PublicDnsName:8443/api/v2/orgs/1/labels -H 'Content-Type: application/json' --data-raw '{"key":"role","value":"R-APP"}' | jq -r '.href')
echo $? | grep 0 || labels_app_href=$(curl -s -u $auth_username:$session_token "https://$PublicDnsName:8443/api/v2/orgs/1/labels?key=role&value=R-APP" | jq -r .[].href)
#create db role label
labels_db_href=$(curl -u $auth_username:$session_token https://$PublicDnsName:8443/api/v2/orgs/1/labels -H 'Content-Type: application/json' --data-raw '{"key":"role","value":"R-DB"}' | jq -r '.href')
echo $? | grep 0 || labels_db_href=$(curl -s -u $auth_username:$session_token "https://$PublicDnsName:8443/api/v2/orgs/1/labels?key=role&value=R-DB" | jq -r .[].href)
#create web role label
labels_web_href=$(curl -u $auth_username:$session_token https://$PublicDnsName:8443/api/v2/orgs/1/labels -H 'Content-Type: application/json' --data-raw '{"key":"role","value":"R-WEB"}' | jq -r '.href')
echo $? | grep 0 || labels_web_href=$(curl -s -u $auth_username:$session_token "https://$PublicDnsName:8443/api/v2/orgs/1/labels?key=role&value=R-WEB" | jq -r .[].href)
#create k3s app label
labels_k3s_href=$(curl -u $auth_username:$session_token https://$PublicDnsName:8443/api/v2/orgs/1/labels -H 'Content-Type: application/json' --data-raw '{"key":"app","value":"A-K3S"}' | jq -r '.href')
echo $? | grep 0 || labels_k3s_href=$(curl -s -u $auth_username:$session_token "https://$PublicDnsName:8443/api/v2/orgs/1/labels?key=app&value=A-K3S" | jq -r .[].href)
#create yelb app label
labels_yelb_href=$(curl -u $auth_username:$session_token https://$PublicDnsName:8443/api/v2/orgs/1/labels -H 'Content-Type: application/json' --data-raw '{"key":"app","value":"A-YELB"}' | jq -r '.href')
echo $? | grep 0 || labels_yelb_href=$(curl -s -u $auth_username:$session_token "https://$PublicDnsName:8443/api/v2/orgs/1/labels?key=app&value=A-YELB" | jq -r .[].href)
#get prod label href
labels_prod_href=$(curl -u $auth_username:$session_token "https://$PublicDnsName:8443/api/v2/orgs/1/labels?key=env&value=Production" | jq -r .[].href)
#get amazon label href
labels_amazon_href=$(curl -u $auth_username:$session_token "https://$PublicDnsName:8443/api/v2/orgs/1/labels?key=loc&value=Amazon" | jq -r .[].href)
#create containter cluster
container_clusters_response=$(curl -u $auth_username:$session_token https://$PublicDnsName:8443/api/v2/orgs/1/container_clusters -X POST -H 'content-type: application/json' --data-raw '{"name":"k3s-beta","description":""}')
pce_container_clusters_cluster_id=$(echo $container_clusters_response | jq -r .href | cut -d/ -f5)
pce_container_clusters_cluster_token=$(echo $container_clusters_response | jq -r .container_cluster_token)
#create container pairing profile
pairing_profiles_response=$(curl -u $auth_username:$session_token https://$PublicDnsName:8443/api/v2/orgs/1/pairing_profiles -X POST -H 'content-type: application/json' --data-raw '{"name":"pp-container_nodes","description":"","labels":[{"href":"'$labels_node_href'"},{"href":"'$labels_k3s_href'"},{"href":"'$labels_prod_href'"},{"href":"'$labels_amazon_href'"}],"enforcement_mode":"visibility_only","visibility_level":"flow_summary","allowed_uses_per_key":"unlimited","agent_software_release":null,"key_lifespan":"unlimited","app_label_lock":true,"env_label_lock":true,"loc_label_lock":true,"role_label_lock":true,"enforcement_mode_lock":true,"visibility_level_lock":true,"enabled":true,"ven_type":"server"}')
pairing_profiles_response_href=$(echo $pairing_profiles_response | jq -r .href)
#if error, already exists, get href
pairing_profiles_response_message=$(echo $pairing_profiles_response | jq -r .[].message)
if [ "$pairing_profiles_response_message" == "Name must be unique" ]; then
    pairing_profiles_response_href=$(curl -u $auth_username:$session_token https://$PublicDnsName:8443/api/v2/orgs/1/pairing_profiles?name=pp-container_nodes | jq -r .[].href)
fi
pairing_key_response=$(curl -u $auth_username:$session_token https://$PublicDnsName:8443/api/v2$pairing_profiles_response_href/pairing_key -X POST -H 'content-type: application/json' --data-raw '{}')
pce_container_clusters_activation_code=$(echo $pairing_key_response | jq -r .activation_code)
#get container default workload profile id
container_workload_profiles=$(curl -u $auth_username:$session_token https://$PublicDnsName:8443/api/v2/orgs/1/container_clusters/$pce_container_clusters_cluster_id/container_workload_profiles)
container_workload_profiles_default_id=$(echo $container_workload_profiles | jq -r .[].href | cut -d/ -f7)
#update container workload default profile
curl -u $auth_username:$session_token https://$PublicDnsName:8443/api/v2/orgs/1/container_clusters/$pce_container_clusters_cluster_id/container_workload_profiles/$container_workload_profiles_default_id -X PUT -H 'content-type: application/json' --data-raw '{"managed":true,"labels":[],"enforcement_mode":"visibility_only","visibility_level":"flow_summary"}'
#create containter cluster illumio-values.yaml
cat << EOF > illumio-values.yaml
pce_url: $PublicDnsName:8443
cluster_id: $pce_container_clusters_cluster_id
cluster_token: $pce_container_clusters_cluster_token
cluster_code: $pce_container_clusters_activation_code
containerRuntime: k3s_containerd
containerManager: kubernetes
ignore_cert: true
clusterMode: clas
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
helm install illumio -f illumio-values.yaml oci://quay.io/illumio/illumio --namespace illumio-system --version 5.1.0
