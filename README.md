# Ansible Role: Munin Node

BUILD STATUS (will go here).

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

### Munin Plugin Configuration

You can enable plugins using the `munin_node_plugins` list, like so:

    munin_node_plugins:
      - name: uptime

If the name of the resulting plugin does not match the name of the munin plugin from which it is generated (as is the case, say, with the `if_` plugin), you need to add a `plugin` field to the list item, like so:

    munin_node_plugins:
      - name: if_eth0
        plugin: if_

#### Plugin settings

If you need to add plugin configuration for plugins you've added via `munin_node_plugins`, you can do so with a simple hashmap that has the plugin name (which will be the `[plugin]` section in the resulting configuration file), and a list of variable names and values. For example:

    munin_node_config: {
      "ps_test": {
        "env.regex": "bash",
        "env.name": "bash"
      }
    }

This configuration will generate a configuration file at `/etc/munin/plugin-conf.d/ansible.conf` with the following contents:

    [ps_test]
    env.regex bash
    env.name bash

## Dependencies

None.

## Example Playbook

    - hosts: servers
      roles:
        - { role: geerlingguy.munin-node }

## License

MIT / BSD

## Author Information

This role was created in 2014 by [Jeff Geerling](http://jeffgeerling.com/), author of [Ansible for DevOps](http://ansiblefordevops.com/).

Munin plugin configuration was added by Rafał Trójniak <ansible-galaxy@trojniak.net>.
