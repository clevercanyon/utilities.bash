#!/usr/bin/env bash
##
# Utility function(s).
##

##
# Gets file modification time.
#
# @param string ${1} File to check.
#
# @output string Modification time (UTC).
# @return int `0` (true) on success.
##
function :filemtime() {
    local file="${1:-}"
    stat -c '%Y' "${file}" # UTC time.
}
