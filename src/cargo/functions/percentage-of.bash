#!/usr/bin/env bash
##
# Utility function(s).
##

##
# Calculates a% of b.
#
# @param string ${1} Percentage as number. Default is `100`.
# @param string ${2} Value to calculate percentage of. Default is `100`.
# @param string ${3} Rounding direction; `up` or `down`. Default is `up`.
#
# @output int Percentage rounded to an integer.
# @return int `0` (true) on success.
##
function :percentage-of() {
    local percent="${1:-100}"
    local of="${2:-100}"
    local round="${3:-up}"

    if [[ "${round}" == down ]]; then
        awk 'BEGIN { p=('"${percent}"'/100)*'"${of}"'; print int(p); }'
    else
        awk 'BEGIN { p=('"${percent}"'/100)*'"${of}"'; print int(p+0.5); }'
    fi
}
