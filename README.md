# **ms_iptables**, a simple firewall configured via json written in python

- Idea is to Configure/Apply a set of rules via iptables or other security binary
  and ensure that they are not applied twice.
- A contrario to another stateful firewalls (shorewall/firewalld),
  this wont reset your current firewall state but will try to add the rules.
- Associated docs:
    - [usage](docs/usage.md)
    - [install](docs/install.md)
- Attention, to provide a patch, you need to edit `hacking/ms_iptables.py.in`.
- Remember the companion sysctls:
    - `net.ipv4.ip_forward`: 1
    - `net.ipv6.conf.all.forwarding`: 1
    
# Support development
- Ethereum: ``0xa287d95530ba6dcb6cd59ee7f571c7ebd532814e``
- Bitcoin: ``3GH1S8j68gBceTeEG5r8EJovS3BdUBP2jR``
- [paypal](https://paypal.me/kiorky)
