#!/usr/bin/env bash
# shellcheck disable=SC2034
##
# Utility include.
##

##
# Options for interactive shell mode.
##

function :___ishell_options_closure___() {
    ##
    # Gets this file’s directory.
    ##

    local __dirname="$(cd "$(dirname "${BASH_SOURCE[0]}")" &> /dev/null && pwd)"
    [[ -d "${__dirname}" ]] || { :chalk-danger ':___ishell_options_closure___: Missing `__dirname`!' >&2 && return 1; }

    ##
    # Loads all option include files.
    ##

    . "${__dirname}"/dircolors.bash || { :chalk-danger ':___ishell_options_closure___: Missing dircolors!' >&2 && return 1; }
    . "${__dirname}"/history.bash || { :chalk-danger ':___ishell_options_closure___: Missing history!' >&2 && return 1; }
    . "${__dirname}"/completion.bash || { :chalk-danger ':___ishell_options_closure___: Missing completion!' >&2 && return 1; }
    . "${__dirname}"/keychain.bash || { :chalk-danger ':___ishell_options_closure___: Missing keychain!' >&2 && return 1; }
    . "${__dirname}"/prompt.bash || { :chalk-danger ':___ishell_options_closure___: Missing prompt!' >&2 && return 1; }

} && :___ishell_options_closure___
