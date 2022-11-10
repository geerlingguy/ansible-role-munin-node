# Ansible Role: Munin Node

[![CI](https://github.com/geerlingguy/ansible-role-munin-node/workflows/CI/badge.svg?event=push)](https://github.com/geerlingguy/ansible-role-munin-node/actions?query=workflow%3ACI)

Installs munin-node, a monitoring system endpoint, on RedHat/CentOS, Arch Linux, or Debian/Ubuntu Linux servers.

## Requirements

If using RedHat/CentOS, make sure you have the EPEL repository installed prior to using this role (you can install it using the [`geerlingguy.repo-epel`](https://galaxy.ansible.com/list#/roles/436) role).

## Role Variables

Available variables are listed below, along with default values:

    munin_node_bind_host: "*"
    munin_node_bind_port: "4949"

The host and port to which munin-node will bind. Common host options are `127.0.0.1` (localhost), or `*` (bind to all IP addresses). `4949` is the default Munin port.

    munin_node_host_name: ''

Set this explicitly if the munin master doesn't report the correct hostname when telnetting in to munin-node. In most cases, the default should work fine.

    munin_node_allowed_ips:
      - '^127\.0\.0\.1$'
      - '^::1$'

A list of IP addresses formatted as a python-style regular expression. Must use single quotes to allow the proper regex escaping to pass through to the configuration file. Hosts with these IP addresses will be allowed to connect to the server and get detailed system stats via munin-node.

    munin_node_allowed_cidrs: []

A list of IP networks in CIDR format, for instance `10.0.0.0/8`. Hosts with an IP address in one of these networks will be allowed to connect to the server and get detailed system stats via munin-node.

    munin_node_denied_cidrs: []

A list of IP networks in CIDR format, for instance `10.42.0.0/16`. Hosts with an IP address in one of these networks will be denied access to the server. This takes precedence over `munin_node_allowed_cidrs`: an IP address that matches both a network in `munin_node_allowed_cidrs` and a network in `munin_node_denied_cidrs` will be denied access.

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

#### Install external plugins

You can install external plugins via `munin_node_install_plugins`.
Those plugins can be copied from local files or downloaded. For example:

    munin_node_install_plugins: []
      - src: files/munin/redis_
      - remote_src: https://raw.githubusercontent.com/ohitz/phpfpm-multi-munin-plugin/master/phpfpm-multi


## Dependencies

None.

## Example Playbook

    - hosts: servers
      roles:
        - { role: geerlingguy.munin-node }

## License

MIT / BSD

## Author Information

This role was created in 2014 by [Jeff Geerling](https://www.jeffgeerling.com/), author of [Ansible for DevOps](https://www.ansiblefordevops.com/).

Munin plugin configuration was added by Rafał Trójniak <ansible-galaxy@trojniak.net>.
