#!/usr/bin/env bash
##
# Utility function(s).
##

##
# Performs a y|n confirmation.
#
# @param string ${1} Question to ask.
#
# @output string Question.
# @return int `0` (true) if `y` (yes).
##
function :confirm() {
    local question="${1:-}"

    if [[ -z "${question}" ]]; then
        question='Are you sure?'
    fi
    read -p "${question}"' [y|n] ' -n 1 -r

    if [[ "${REPLY:-}" =~ ^[Yy]$ ]]; then
        return 0 # True.
    fi
    return 1 # False.
}
