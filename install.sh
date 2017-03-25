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

if [[ -n $changed ]];then
    echo "changed=true"
else
    echo "changed=false"
fi
# vim:set et sts=4 ts=4 tw=80:
