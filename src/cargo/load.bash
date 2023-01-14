#!/usr/bin/env bash
##
# Utilities.
##

##
# Loads utilities.
##
function :___load_closure() {
    local __dirname _function_file # Initialize.

    __dirname="$(cd "$(dirname "${BASH_SOURCE[0]}")" &> /dev/null && pwd)"
    [[ -d "${__dirname}" ]] || { echo 'Missing `__dirname`!' >&2 && exit 1; }

    . "${__dirname}"/includes/strict-mode.bash

    for _function_file in "${__dirname}"/functions/**.bash; do
        [[ -f "${_function_file}" ]] && . "${_function_file}"
    done
} && :___load_closure && unset -f :___load_closure
