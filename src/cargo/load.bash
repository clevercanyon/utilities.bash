#!/usr/bin/env bash
##
# Utilities.
##

##
# Loads utilities.
##

function :___load_closure___() {
    ##
    # Initializes local vars.
    ##

    local __dirname _function_file       # Initialize.
    local required_bash_version='5.2.15' # Checked below.

    ##
    # Gets this file’s directory.
    ##

    __dirname="$(cd "$(dirname "${BASH_SOURCE[0]}")" &> /dev/null && pwd)"
    [[ -d "${__dirname}" ]] || { echo ':___load_closure___: Missing `__dirname`!' >&2 && return 1; }

    ##
    # Checks bash version against minimum required version.
    ##

    [[ -n "${BASH_VERSION:-}" && "$(printf '%s\n' "${BASH_VERSION}" "${required_bash_version}" | sort -rV | head -n1)" == "${BASH_VERSION}" ]] || {
        echo ':___load_closure___: Minimum required bash version is `'"${required_bash_version}"'`. Currently running `'"${BASH_VERSION:-}"'`.' >&2 && return 1
    }

    ##
    # Loads strict mode w/ default baseline.
    ##

    . "${__dirname}"/includes/strict-mode.bash || { echo ':___load_closure___: Missing strict mode!' >&2 && return 1; }

    ##
    # Loads all utility functions.
    ##

    for _function_file in "${__dirname}"/functions/**.bash; do
        [[ -f "${_function_file}" ]] && . "${_function_file}"
    done
} && :___load_closure___
