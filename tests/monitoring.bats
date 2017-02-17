#!/usr/bin/env bats

@test "munin mysql symlink is present" {
    [ -h "/etc/munin/plugins/mysql" ]
}




