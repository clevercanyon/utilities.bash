#!/usr/bin/env bash
##
# Utility function(s).
##

##
# Can run a command?
#
# @param string ${1} Command name.
#
# @return int `0` (true) if can run command name.
##
function can-run() {
  command -v "${1}" >/dev/null 2>&1;
};
