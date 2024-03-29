#!/usr/bin/env bash
##
# Utility function(s).
##

##
# Is shell interactive?
#
# @output void No output.
# @return int `0` (true) if shell is interactive.
##
function :is-interactive() {
    if [[ "${-}" == *i* ]]; then
        return 0 # True.
    fi
    return 1 # False.
}
