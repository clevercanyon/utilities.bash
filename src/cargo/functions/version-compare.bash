#!/usr/bin/env bash
##
# Utility function(s).
##

##
# Perfoms a version comparison.
#
# @param string ${1} Version to compare; i.e., left side of operand.
# @param string ${2} Version to compare to; i.e., right side of operand.
# @param string ${3} Comparison operator. Same as PHP’s `version_compare()`.
#                    One of: `==|=|eq`, `!=|<>|ne`, `>=|ge`, `>|gt`, `<=|le`, `<|lt`.
#
# @output void No output.
# @return int `0` (true) if comparison is true.
##
function :version-compare() {
    local v1="'${1:-}'" # Version 1.
    local v2="'${2:-}'" # Version 2.
    local op="'${3:-}'" # Comparison operator.

    if :can-run php; then # Favor PHP, which does a better of comparing versions.
        [[ "$(php -r 'echo (int) version_compare('"${v1}"', '"${v2}"', '"${op}"');')" == 1 ]]
        return # Returns last command exist status.
    fi
    case "${op}" in
        "'=='" | "'='" | "'eq'")
            [[ "${v1}" == "${v2}" ]]
            return
            ;;
        "'!='" | "'<>'" | "'ne'")
            [[ "${v1}" != "${v2}" ]]
            return
            ;;
        "'>='" | "'ge'")
            [[ "$(printf '%s\n' "${v1}" "${v2}" | sort -rV | head -n1)" == "${v1}" ]]
            return
            ;;
        "'>'" | "'gt'")
            [[ "${v1}" != "${v2}" && "$(printf '%s\n' "${v1}" "${v2}" | sort -rV | head -n1)" == "${v1}" ]]
            return
            ;;
        "'<='" | "'le'")
            [[ "$(printf '%s\n' "${v1}" "${v2}" | sort -rV | head -n1)" == "${v2}" ]]
            return
            ;;
        "'<'" | "'lt'")
            [[ "${v1}" != "${v2}" && "$(printf '%s\n' "${v1}" "${v2}" | sort -rV | head -n1)" == "${v2}" ]]
            return
            ;;
        *)
            :chalk-danger ':version-compare: Invalid comparsion operator: `'"${op}"'`.' >&2
            return 1 # False.
            ;;
    esac
}
