#!/usr/bin/env bash
##
# Utility function(s).
##

##
# Remove duplicates from a space-separated list.
#
# @param string ${1} Space-separated list.
#
# @output string Deduped space-separated list.
# @return int `0` (true) on success.
##
function :dedupe-list() {
    local list="${1:-}"
    echo "${list}" | xargs -n1 | sort -u | xargs
}
