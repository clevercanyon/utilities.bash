#!/usr/bin/env bash
##
# Utility function(s).
##

##
# Trims a string or stdin.
#
# @param string ${1} String to trim.
# @param string ${2} Chars to trim. Default is whitespace.
#
# Alternate signature for `/dev/stdin`, which obviates the need for first argument.
#     @param string ${1} Chars to trim. Default is whitespace.
#
# @output string Trimmed string.
# @return int `0` (true) on success.
##
function :trim() {
    local str=''
    local chars=''

    if [[ -p /dev/stdin ]]; then
        # /dev/stdin as `str`
        chars="${1:-}"

        if [[ -n "${chars}" ]]; then
            chars="$(:esc-regexp "${chars}")"
            perl -0wpe 's/(?:^['"${chars}"']+|['"${chars}"']+$)//ug'
        else
            perl -0wpe 's/(?:^\s+|\s+$)//ug'
        fi
    else
        str="${1:-}"
        chars="${2:-}"

        if [[ -n "${chars}" ]]; then
            chars="$(:esc-regexp "${chars}")"
            echo -n "${str}" | perl -0wpe 's/(?:^['"${chars}"']+|['"${chars}"']+$)//ug'
        else
            echo -n "${str}" | perl -0wpe 's/(?:^\s+|\s+$)//ug'
        fi
    fi
}
