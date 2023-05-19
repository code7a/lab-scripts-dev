#create-pce-objects.sh
yum install -y jq
basic_auth_token=$(echo -n "$pce_admin_username_email_address:$pce_admin_password"|base64)
auth_token=$(curl -X POST -H "Authorization: Basic $basic_auth_token" https://$(hostname):8443/api/v2/login_users/authenticate?pce_fqdn=$(hostname) | jq -r '.auth_token')
login_response=$(curl -H "Authorization: Token token=$auth_token" https://$(hostname):8443/api/v2/users/login)
auth_username=$(echo $login_response | jq -r '.auth_username')
session_token=$(echo $login_response | jq -r '.session_token')
#update default pairing profile, selective, allow labels, allow enforcement
curl -u $auth_username:$session_token https://$(hostname):8443/api/v2/orgs/1/pairing_profiles/1 -X PUT -H 'Content-Type: application/json' --data-raw '{"name":"default","description":"Default Pairing Profile","labels":[],"enforcement_mode":"selective","visibility_level":"flow_summary","allowed_uses_per_key":"unlimited","agent_software_release":null,"key_lifespan":"unlimited","app_label_lock":false,"env_label_lock":false,"loc_label_lock":false,"role_label_lock":false,"enforcement_mode_lock":false,"visibility_level_lock":true,"enabled":true}'
#create nginx app label
curl -u $auth_username:$session_token https://$(hostname):8443/api/v2/orgs/1/labels -H 'Content-Type: application/json' --data-raw '{"key":"app","value":"A-NGINX"}'
#create httpd app label
curl -u $auth_username:$session_token https://$(hostname):8443/api/v2/orgs/1/labels -H 'Content-Type: application/json' --data-raw '{"key":"app","value":"A-HTTPD"}'
#create lighttpd app label
curl -u $auth_username:$session_token https://$(hostname):8443/api/v2/orgs/1/labels -H 'Content-Type: application/json' --data-raw '{"key":"app","value":"A-LIGHTTPD"}'
#create share app label
curl -u $auth_username:$session_token https://$(hostname):8443/api/v2/orgs/1/labels -H 'Content-Type: application/json' --data-raw '{"key":"app","value":"A-SHARE"}'
#get service
service_href=$(curl -u $auth_username:$session_token "https://$(hostname):8443/api/v2/orgs/1/sec_policy/active/services?name=S-NETBIOS" | jq -r .[].href)
#create enforcement boundry
curl -u $auth_username:$session_token https://$(hostname):8443/api/v2/orgs/1/sec_policy/draft/enforcement_boundaries -X POST -H 'Content-Type: application/json' --data-raw '{"name":"block-netbios","enabled":true,"providers":[{"actors":"ams"}],"consumers":[{"ip_list":{"href":"/orgs/1/sec_policy/draft/ip_lists/1"}}],"network_type":"brn","ingress_services":[{"href":"'$service_href'"}]}'
#provision
curl -u $auth_username:$session_token https://$(hostname):8443/api/v2/orgs/1/sec_policy -X POST -H 'Content-Type: application/json' --data-raw '{"update_description":"","change_subset":{"enforcement_boundaries":[{"href":"/orgs/1/sec_policy/draft/enforcement_boundaries/1"}]}}'
#enable ransomware dashboard
curl -u $auth_username:$session_token https://$(hostname):8443/api/v2/orgs/1/optional_features -X POST -H 'Content-Type: application/json' --data-raw '{"update_description":"","change_subset":{"enforcement_boundaries":[{"href":"/orgs/1/sec_policy/draft/enforcement_boundaries/1"}]}}'