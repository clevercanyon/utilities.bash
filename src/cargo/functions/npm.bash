#!/usr/bin/env bash
##
# Utility function(s).
##

##
# Checks if in an NPM package.
#
# @output void No output.
# @return int `0` (true) if in a git repo.
##
function :in-npm-pkg() {
    if ! :can-run npm; then
        return 1 # False.
    fi
    if [[ -f "$(pwd)"/package.json ]]; then
        return 0 # True.
    fi
    local prefix="$(npm prefix)" # Current prefix.

    if [[ -n "${prefix}" && -f "${prefix}"/package.json ]]; then
        return 0 # True.
    fi
    return 1 # False.
}
