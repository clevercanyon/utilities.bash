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
function in-npm-pkg() {
    if ! can-run npm; then
        return 1 # False.
    fi
    local prefix="$(npm prefix)"

    if [[ -n "${prefix}" && "${prefix}" != "${HOME}" && "${prefix}" != '/' && "${prefix}" != "$(npm prefix --global)" ]]; then
        return 0 # True.
    else
        return 1 # False.
    fi
}
