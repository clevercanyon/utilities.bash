#!/usr/bin/env bash
##
# Utility function(s).
##

##
# Generates a random key.
#
# @param string ${1} Length of key. Default is `64`.
# @param string ${2} Alphabet for `tr` to use. Default is `a-zA-Z0-9`.
#
# @output string Random key.
# @return int `0` (true) on success.
##
function :keygen() {
    local length="${1:-64}"
    local alphabet="${2:-a-zA-Z0-9}"
    tr -dc "${alphabet}" < /dev/urandom | fold -w "${length}" | head -n 1
}
