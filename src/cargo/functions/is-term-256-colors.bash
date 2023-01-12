#!/usr/bin/env bash
##
# Utility function(s).
##

##
# Checks if terminal supports 256 colors.
#
# @output void No output.
# @return int `0` (true) if terminal supports 256 colors.
##
function :is-term-256-colors() {
    if :is-term-16m-colors; then
        return 0 # True.

    elif [[ -n "${COLORTERM:-}" && "${COLORTERM,,}" =~ true[_\-]?color|24[_\-]?bit|256[_\-]?color ]]; then
        return 0 # True.

    elif [[ -n "${TERM:-}" && "${TERM,,}" =~ 256[_\-]?color ]]; then
        return 0 # True.

    elif :can-run tput && (($(tput colors 2> /dev/null) >= 256)); then
        return 0 # True.
    else
        return 1 # False.
    fi
}
