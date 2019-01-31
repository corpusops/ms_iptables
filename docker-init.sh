#!/usr/bin/env bash
set -e
SDEBUG=${SDEBUG-}
log() { echo "$@" >&2; }
vv() { log "$@";"$@"; }
if [[ -n $SDEBUG ]];then set -x;fi
if [ ! -e rules ];then mkdir /rules;fi
while read f;do
    bf=$(basename $f)
    vv frep --overwrite "$f:/etc/ms_iptables.d/$bf"
done < <(find rules -type f -name "*.json")
exec ms_iptables.py $@
# vim:set et sts=4 ts=4 tw=80:
