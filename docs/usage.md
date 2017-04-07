- ms_iptables.py provides a default set of rules that will not block http(s)/ping/dns/ssh
  and any section not declared will default to the default config defined in
  DEFAULT_FIREWALL variable (see: [ms_iptables.py](ms_iptables.py))
- ms_iptables.py is configurable via a json configuration file

    ```
    {
        "policy": "hard" / "open", => default firewall policy,
        "ipv6": true / false, => if false, do not apply ip6tables rules
        "open_policies": ["List of iptables commands to flush the fw"],
        "hard_policies": ["List of iptables commands to make the fw harden"],
        "flush_rules": ["List of iptables commands to flush the fw"],
        "rules": ["List of iptables commands to apply tp the firewall"],
        "load_default_rules": [true]/false, =>
           if true, the default rules will be
           appended to any defined rules
        "load_default_flush_rules": [true]/false, =>
           if true, the default flush_rules rules will be
           appended to any defined rules
        "load_default_open_policies": [true]/false, =>
           if true, the default open_policies rules
           will be appended to any defined rules
        "load_default_hard_policies": [true]/false, =>
           if true, the default hard_policies rules
           will be appended to any defined rules
        "no_rules": null / true / false, if true, do not apply control rules
    }
    ```

- **USAGE**
    - `ms_iptables.py [--config=f] [--config-dir=d]`
        - Configuration file is in the **JSON** format
        - multiple config files can be given (merged)
        - set the 'harden rules', by default: INPUT policy is **DROP**
        - apply the default rules (accept loopback traffic, and
          input ping dns, ssh, http(s)
    - `ms_iptables.py --clear [--config=f] [--config-dir=d]`
        - set all iptables policies to ACCEPT and remove any rule
    - `ms_iptables.py --stop [--config=f] [--config-dir=d]`
        - set all iptables policies to ACCEPT and remove any rule
        - remove any defined rule that are configured
        - this must leave the firewall with other tools iptables left as-is
    - `ms_iptables.py --open [--config=f] [--config-dir=d]`
        - set the firewall policy to OPEN
    - `ms_iptables.py --hard [--config=f] [--config-dir=d]`
        - set the firewall policy to hard (prevalent on open mode)
    - `ms_iptables.py --flush [--config=f] [--config-dir=d]`
        - same as called without argument, but flush any existing rule
          before applying anything
    - `ms_iptables.py --no-rules [--config=f] [--config-dir=d]`
        - Launch firewall with configured policy mode, but do not load rules

- Please use 'ip*tables -w' to get a lock and avoid misconfigurations

- EG: to add the port 8080 , place a custom rule /etc/ms_iptables.d/foo.json:
    ```
    {"rules": ["ip6tables -w -t filter -I  INPUT 1 -p tcp --dport 8080 -j ACCEPT",
               "iptables  -w -t filter -I  INPUT 1 -p tcp --dport 8080 -j ACCEPT"]}
    ```
- EG: to add a log/drop on masquerade/input, place custom rule /etc/ms_iptables.d/foo.json:

    ```
    {"rules": ["iptables  -w -t filter -A POSTROUTING -s 192.168.122.0/24 ! -d 192.168.122.0/24 -j MASQUERADE"]}
    ```

