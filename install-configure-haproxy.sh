#install-configure-haproxy.sh
yum install -y haproxy
systemctl enable haproxy
cp /etc/haproxy/haproxy.cfg /etc/haproxy/haproxy.cfg.original
cat << EOF > /etc/haproxy/haproxy.cfg
frontend proxy
    bind *:443
    mode tcp
    default_backend pce
backend pce
    server localhost *:8443 check
    mode tcp
EOF
systemctl restart haproxy
