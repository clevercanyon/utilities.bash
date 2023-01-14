#!/usr/bin/env bash
##
# Utility function(s).
##

##
# Trims a string or stdin.
#
# @param string ${1}      String to trim; or `/dev/stdin`.
#                         `/dev/stdin`, when exists, takes precedence.
#
# @param string {--chars} Additional chars to trim from string.
#                         Whitespace is always trimmed, regardless.
#
# @output string Trimmed string.
# @return int `0` (true) on success.
##
function :trim() {
    declare -A opts
    local long_opts='chars'
    :parse-opts ':trim' '' "${long_opts}" opts -- "${@}"

    local str="${opts[_1]:-}"
    local chars="${opts[chars]:-}"

    [[ -n "${chars}" ]] && chars="$(:esc-regexp "${chars}")"
    chars+='\s' # Always trim whitespace, regardless.

    if [[ -p /dev/stdin ]]; then
        perl -0wpe 's/(?:^['"${chars}"']+|['"${chars}"']+$)//ug'
    else
        echo -n "${str}" | perl -0wpe 's/(?:^['"${chars}"']+|['"${chars}"']+$)//ug'
    fi
}
