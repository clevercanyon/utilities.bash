#!/usr/bin/env bash
# shellcheck disable=SC2034
##
# Utility include.
##

##
# Options for interactive shell mode.
##
function :___ishell_options_closure() {

    local __dirname="$(cd "$(dirname "${BASH_SOURCE[0]}")" &> /dev/null && pwd)"
    [[ -d "${__dirname}" ]] || { :chalk-danger 'Missing `__dirname`!' >&2 && return 1; }

    . "${__dirname}"/dircolors.bash
    . "${__dirname}"/history.bash
    . "${__dirname}"/completion.bash
    . "${__dirname}"/prompt.bash

} && :___ishell_options_closure && unset -f :___ishell_options_closure
