#!/usr/bin/env bash
set -ex
cd $(dirname $0)
config=${config:-ms_iptables.d/lock.json}
bin=ms_iptables.py
dest=/usr/bin
changed=
if ! diff -q "$bin" "$dest/$bin";then
    cp -fv ms_iptables.py "$dest/$bin"
    changed=1
fi
if [ -e /etc/init.d ];then
    if [[ ! -e /etc/init.d/ms_iptables ]] || ! diff -q "init.d/ms_iptables" "/etc/init.d/ms_iptables";then
        cp -fv init.d/ms_iptables /etc/init.d/ms_iptables
        changed=1
    fi
fi
if [ -e /etc/init.d/ms_iptables ];then
    chmod +x /etc/init.d/ms_iptables
fi
if [ -e /etc/systemd/system ];then
    if [[ ! -e /etc/systemd/system/ms_iptables.service ]] || ! diff -q "systemd/ms_iptables.service" "/etc/systemd/system/ms_iptables.service";then
        cp -fv "systemd/ms_iptables.service" "/etc/systemd/system/ms_iptables.service"
        changed=1
    fi
fi
if [[ ! -e /etc/ms_iptables.d ]];then
    mkdir /etc/ms_iptables.d
fi
if [[ ! -e /etc/ms_iptables.json ]] || [ ! -e /etc/ms_iptables.json ];then
    cp -vf "$config" /etc/ms_iptables.json
    changed=1
fi

is_container_() {
    echo  "$(cat -e /proc/1/environ |grep container=|wc -l|sed -e "s/ //g")"
}
is_container() { [ "x$(is_container_)" != "x0" ]; }

# in lxc, dont put firewall in hard mode
if diff -q "$config" /etc/ms_iptables.json && (is_container) && grep -q '"hard"' /etc/ms_iptables.json;then
    sed -i -re 's/"hard"/"open"/g' /etc/ms_iptables.json
    changed=1
fi

if [[ -n $changed ]];then
    echo "changed=true"
else
    echo "changed=false"
fi
# vim:set et sts=4 ts=4 tw=80:
