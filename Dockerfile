FROM corpusops/alpine-bare
RUN sh -exc '\
    apk add iptables python git ip6tables py-pip py-six\
    && git clone https://github.com/corpusops/ms_iptables /srv/msiptables\
    && /srv/msiptables/install.sh\
    && sed -i -re "s/policy.: .hard/policy\": \"open/g"  -e "s/(load_default_.*)true/\1false/g" /etc/ms_iptables.json'
VOLUME "/var/run"
ADD docker-init.sh /docker-init.sh
CMD ["/docker-init.sh"]
