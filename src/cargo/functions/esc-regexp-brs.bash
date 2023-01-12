#!/usr/bin/env bash
##
# Utility function(s).
##

##
# Escapes regexp back-references in a replacement string.
#
# @param string ${1} String to escape.
#
# @output string Escaped string.
# @return int `0` (true) on success.
##
function :esc-regexp-brs() {
    local str="${1:-}"

    str="${str//@/\\@}"
    str="${str//$/\\$}"
    str="${str//\//\\/}"

    echo "${str}"
}
