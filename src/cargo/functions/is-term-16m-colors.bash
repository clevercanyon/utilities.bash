#!/usr/bin/env bash
##
# Utility function(s).
##

##
# Checks if terminal supports 16M colors.
#
# @output void No output.
# @return int `0` (true) if terminal supports 16M colors.
##
function is-term-16m-colors() {
    if [[ -n "${COLORTERM:-}" && "${COLORTERM,,}" =~ true[_\-]?color|24[_\-]?bit ]]; then
        return 0 # True.

    elif [[ -n "${TERM:-}" && "${TERM,,}" =~ true[_\-]?color|24[_\-]?bit ]]; then
        return 0 # True.

    elif can-run tput && (($(tput colors 2> /dev/null) >= 16000000)); then
        return 0 # True.
    else
        return 1 # False.
    fi
}
