#!/usr/bin/env bash
##
# Utility function(s).
##

##
# Is CI server?
#
# @output void No output.
# @return int `0` (true) if is CI server.
##
function :is-ci() {
    if [[ -n "${CI:-}" && "${CI}" == true ]]; then
        return 0 # True.
    else
        return 1 # False.
    fi
}
