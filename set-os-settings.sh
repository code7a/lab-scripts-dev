#set-os-settings.sh
#if core node
if [[ "$(hostname)" == *"core"* ]]; then
    echo 16384 > /proc/sys/net/core/somaxconn
    echo 1048576 > /proc/sys/net/nf_conntrack_max
#if data node
else
    echo 1 > /proc/sys/vm/overcommit_memory
fi
grep -qxF 'LimitCORE=0' /etc/systemd/system/illumio-pce.service.d/illumio-pce-limits.conf || echo 'LimitCORE=0' >> /etc/systemd/system/illumio-pce.service.d/illumio-pce-limits.conf
sysctl -p
