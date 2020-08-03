FROM corpusops/alpine-bare
RUN sh -exc '\
    apk update && apk add iptables python3 git ip6tables py-pip py-six\
    && rm -rf /var/cache/apk/*\
    && ln -sf /usr/bin/python3 /usr/bin/python\
    && git clone https://github.com/corpusops/ms_iptables /srv/msiptables\
    && /srv/msiptables/install.sh\
    && sed -i -re "s/policy.: .hard/policy\": \"open/g"  -e "s/(load_default_.*)true/\1false/g" /etc/ms_iptables.json'
VOLUME "/var/run"
ADD docker-init.sh /docker-init.sh
CMD ["/docker-init.sh"]
