#!/usr/bin/env bash
##
# Utility function(s).
##

##
# Escapes a string for regexp inclusion.
#
# @param string ${1} String to escape.
#
# @output string Escaped string.
# @return int `0` (true) on success.
##
function :esc-regexp() {
    local str="${1:-}"

    echo "${str}" | perl -0wpe 's/([.\/\\+*?[\^\]$(){}=!<>|:\-])/\\$1/ug'
}
