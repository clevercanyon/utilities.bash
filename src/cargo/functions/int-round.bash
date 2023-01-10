#!/usr/bin/env bash
##
# Utility function(s).
##

##
# Rounds to an integer.
#
# @param string ${1} Number to round. Default is `0`.
# @param string ${2} Direction; `up` or `down`. Default is `up`.
#
# @output int Number rounded to an integer.
# @return int `0` (true) on success.
##
function int-round() {
    local int="${1:-0}"
    local round="${2:-up}"

    if [[ "${round}" == down ]]; then
        awk 'BEGIN { print int('"${int}"'); }'
    else
        awk 'BEGIN { print int('"${int}"'+0.5); }'
    fi
}
