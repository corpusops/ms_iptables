# **ms_iptables**, a simple firewall configured via json written in python


DISCLAIMER
============

**UNMAINTAINED/ABANDONED CODE / DO NOT USE**

Due to the new EU Cyber Resilience Act (as European Union), even if it was implied because there was no more activity, this repository is now explicitly declared unmaintained.

The content does not meet the new regulatory requirements and therefore cannot be deployed or distributed, especially in a European context.

This repository now remains online ONLY for public archiving, documentation and education purposes and we ask everyone to respect this.

As stated, the maintainers stopped development and therefore all support some time ago, and make this declaration on December 15, 2024.

We may also unpublish soon (as in the following monthes) any published ressources tied to the corpusops project (pypi, dockerhub, ansible-galaxy, the repositories).
So, please don't rely on it after March 15, 2025 and adapt whatever project which used this code.





- Idea is to Configure/Apply a set of rules via iptables or other security binary
  and ensure that they are not applied twice.
- A contrario to another stateful firewalls (shorewall/firewalld),
  this wont reset your current firewall state but will try to add the rules.
- Associated docs:
    - [usage](docs/usage.md)
    - [install](docs/install.md)
    - [usage in docker context](docs/docker.md)
- Attention, to provide a patch, you need to edit `hacking/ms_iptables.py.in`.
- Remember the companion sysctls:
    - `net.ipv4.ip_forward`: 1
    - `net.ipv6.conf.all.forwarding`: 1
