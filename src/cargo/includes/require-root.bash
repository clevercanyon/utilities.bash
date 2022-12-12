#!/usr/bin/env bash
##
# Utility include.
##

##
# Requires root user.
##
if [[ "$(whoami)" != 'root' ]]; then
  echo 'Requires `root` user.'; exit 1;
fi;
