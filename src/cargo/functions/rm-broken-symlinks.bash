#!/usr/bin/env bash
##
# Utility function(s).
##

##
# Removes broken symlinks.
#
# @param string ${1} Directory to scan.
#
# @output void No output.
# @return int `0` (true) if is CI server.
##
function rm-broken-symlinks() {
    local dir="${1:-}"

    if [[ -n "${dir}" && -d "${dir}" ]]; then
        find -L "${dir}" -type l -delete
    fi
}
