#!/usr/bin/env bash
##
# Utility function(s).
##

##
# Requires root user.
#
# @output void No output.
# @return int `0` (true) on success.
# @exit true   Exits if not `root` user.
##
function require-root() {
    if [[ "$(whoami)" != 'root' ]]; then
        chalk-danger 'Requires `root` user.' >&2 && exit 1
    fi
}
