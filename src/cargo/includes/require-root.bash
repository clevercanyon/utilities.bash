#!/usr/bin/env bash
##
# Utility include.
##

##
# Requires root user.
##
if [[ "$(whoami)" != 'root' ]]; then
    chalk-danger 'Requires `root` user.' >&2 && exit 1
fi
