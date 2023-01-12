#!/usr/bin/env bash
##
# Utility function(s).
##

##
# Perl regexp search & replace line(s) in file.
#
# @param string ${1} Regular expression (PCRE).
# @param string ${2} Replacement string with optional backreferences.
# @param string ${3} File path to search & replace in.
#
# @output void No output.
# @return int `0` (true) on success.
##
function :preg-replace-lines-in-file() {
    local regexp="${1:-}"
    local replace="${2:-}"
    local file="${3:-}"

    perl -i -wpe 's/'"${regexp}"'/'"$(:esc-regexp-brs "${replace}")"'/ug' "${file}"
}

##
# Perl regexp search & replace line(s) in file (caSe-insensitive).
#
# @param string ${1} Regular expression (PCRE).
# @param string ${2} Replacement string with optional backreferences.
# @param string ${3} File path to search & replace in.
#
# @output void No output.
# @return int `0` (true) on success.
##
function :preg-ireplace-lines-in-file() {
    local regexp="${1:-}"
    local replace="${2:-}"
    local file="${3:-}"

    perl -i -wpe 's/'"${regexp}"'/'"$(:esc-regexp-brs "${replace}")"'/ugi' "${file}"
}
