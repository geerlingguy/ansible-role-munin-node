# Ansible Role: Munin Node

Installs munin-node, a monitoring system endpoint, on Debian/Ubuntu.

## Requirements

None.

## Role Variables

Available variables are listed below, along with default values (see `vars/main.yml`):

    munin_node_bind_host: "*"
    munin_node_bind_port: "4949"

The host and port to which munin-node will bind. Common host options are `127.0.0.1` (localhost), or `*` (bind to all IP addresses). `4949` is the default Munin port.

    munin_node_allowed_ips:
      - '^127\.0\.0\.1$'

A list of IP addresses formatted as a python-style regular expression. Must use single quotes to allow the proper regex escaping to pass through to the configuration file. Hosts with these IP addresses will be allowed to connect to the server and get detailed system stats via munin-node.

## Dependencies

None.

## Example Playbook

    - hosts: servers
      roles:
        - { role: geerlingguy.munin-node }

## License

MIT / BSD

## Author Information

This role was created in 2014 by Jeff Geerling (@geerlingguy), author of Ansible for DevOps. You can find out more about the book at http://ansiblefordevops.com/, and learn about the author at http://jeffgeerling.com/.
