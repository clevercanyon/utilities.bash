#!/usr/bin/env bash
##
# Utility function(s).
##

##
# Gets directory name. Drop-in replacement for `dirname`.
#
# @param string ${1} Space-separated list.
#
# @output string Directory path.
# @return int `0` (true) on success.
##
function dirname() {
    local dirname="${1:-}"
    local times="${2:-}"
    local realpath="${3:-}"

    if [[ -z "${times}" || "${times}" -lt 1 ]]; then
        times=1 # Must be >= `1`.
    fi
    if [[ "${realpath}" == '--realpath' ]]; then
        dirname="$(realpath "${dirname}")"
    fi
    while [[ "${times}" -gt 0 ]]; do
        dirname="$(command dirname "${dirname}")"
        ((times--)) # Decrementer.
    done
    echo "${dirname}"
}
