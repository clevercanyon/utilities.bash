#!/usr/bin/env bash
##
# Utility function(s).
##

##
# Perl regexp search and replace file contents.
#
# Regarding `-0`; {@see https://unix.stackexchange.com/a/555955/259383}.
# It causes the search/replace to occur throughout the entire file contents.
# Without `-0` it would be searching on a line-by-line basis.
#
# @param string ${1} Regular expression (PCRE).
# @param string ${2} Replacement string with optional backreferences.
# @param string ${3} File path to search & replace in.
#
# @output void No output.
# @return int `0` (true) on success.
##
function :preg-replace-in-file() {
    local regexp="${1:-}"
    local replace="${2:-}"
    local file="${3:-}"

    perl -i -0wpe 's/'"${regexp}"'/'"$(:esc-regexp-brs "${replace}")"'/ug' "${file}"
}

##
# Perl regexp search and replace file contents (caSe-insensitive).
#
# Regarding `-0`; {@see https://unix.stackexchange.com/a/555955/259383}.
# It causes the search/replace to occur throughout the entire file contents.
# Without `-0` it would be searching on a line-by-line basis.
#
# @param string ${1} Regular expression (PCRE).
# @param string ${2} Replacement string with optional backreferences.
# @param string ${3} File path to search & replace in.
#
# @output void No output.
# @return int `0` (true) on success.
##
function :preg-ireplace-in-file() {
    local regexp="${1:-}"
    local replace="${2:-}"
    local file="${3:-}"

    perl -i -0wpe 's/'"${regexp}"'/'"$(:esc-regexp-brs "${replace}")"'/ugi' "${file}"
}
