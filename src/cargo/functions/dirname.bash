#!/usr/bin/env bash
##
# Utility function(s).
##

##
# Gets directory name.
# Drop-in replacement for `dirname`.
#
# @param string  ${1} Filesystem path.
# @param int     {--times}|${2} Levels up. Default is `1`.
# @param boolean {--realpath} To resolve realpath.
#
# @output string Directory path.
# @return int `0` (true) on success.
##
function :dirname() {
    declare -A opts
    local long_opts='times:,realpath'
    :parse-opts ':dirname' '' "${long_opts}" opts -- "${@}"

    local dirname="${opts[_1]:-}"
    local times="${opts[times]:-${opts[_2]:-1}}"
    local realpath="${opts[realpath]:-}"

    if [[ "${times}" -lt 1 ]]; then
        times=1 # Must be >= `1`.
    fi
    if [[ "${realpath}" == true ]]; then
        dirname="$(realpath "${dirname}")"
    fi
    while [[ "${times}" -gt 0 ]]; do
        dirname="$(dirname "${dirname}")"
        ((times--)) || true
    done
    echo "${dirname}"
}
