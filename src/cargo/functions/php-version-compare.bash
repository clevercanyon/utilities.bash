#!/usr/bin/env bash
##
# Utility function(s).
##

##
# Perfoms a PHP version comparison.
#
# @param string ${1} Version to compare.
# @param string ${2} Version to compare to.
# @param string ${3} Operator for comparison.
#
# @output void No output.
# @return int `0` (true) if comparison is true.
##
function php-version-compare() {
    local v1="'${1:-}'" # Version 1.
    local v2="'${2:-}'" # Version 2.
    local op="'${3:-}'" # Comparison operator.

    if can-run php && [[ "$(php -r 'echo (int) version_compare('"${v1}"', '"${v2}"', '"${op}"');')" == 1 ]]; then
        return 0 # True.
    else
        return 1 # False.
    fi
}
