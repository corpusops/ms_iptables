# docker

- Sometimes you need to do custom iptables stuff from within a docker container.
- Most of the time, it's to add custom rules to the host with a privileged docker (devil inside).
- We made a small docker image that:
    - Process all json files inside ``/rules`` with frep and output them inside ``/etc/ms_iptables.d``
    - Run **msiptables**.


- Here is a sample on how to use it
    - ``./docker-compose.yml``

        ```yaml
        ---
        version: "3.6"
        services:
          testfw:
            environment:
                SUBNET: 192.168.3.0
                OUTNIP: 1.2.3.4
            image: corpusops/ms_iptables
            cap_add: [NET_ADMIN]
            network_mode: "host"
            volumes:
            - "./docker.json:/rules/docker.json"
            - "msiptables:/var/run"
        ```

    - ``./docker.json``

        ```json
        {
          "rules": [
             "iptables -w -t nat -A POSTROUTING -s {{.Env.SUBNET}}.0/24 ! -d {{.Env.SUBNET}}.0/24 -j SNAT --to-source {{.Env.OUTIP}}"
        ]}
        ```
