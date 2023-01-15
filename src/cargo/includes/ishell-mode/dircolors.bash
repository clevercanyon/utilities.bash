#!/usr/bin/env bash
# shellcheck disable=SC2034
##
# Utility include.
##

##
# Dircolors for interactive shell mode.
##

function :___ishell_dircolors_closure___() {
    ##
    # Gets this file’s directory.
    ##

    local __dirname="$(cd "$(dirname "${BASH_SOURCE[0]}")" &> /dev/null && pwd)"
    [[ -d "${__dirname}" ]] || { :chalk-danger ':___ishell_dircolors_closure___: Missing `__dirname`!' >&2 && return 1; }

    ##
    # Exports custom `LS_COLORS` environment var.
    ##

    if [[ -n "${BREW_PREFIX:-}" && -x "${BREW_PREFIX}"/opt/coreutils/libexec/gnubin/dircolors ]]; then
        eval "$("${BREW_PREFIX}"/opt/coreutils/libexec/gnubin/dircolors "${__dirname}"/bash.dircolors)" ||
            { :chalk-danger ':___ishell_dircolors_closure___: Missing dircolors!' >&2 && return 1; }

    elif :can-run dircolors; then
        eval "$(dircolors "${__dirname}"/bash.dircolors)" ||
            { :chalk-danger ':___ishell_dircolors_closure___: Missing dircolors!' >&2 && return 1; }
    fi

} && :___ishell_dircolors_closure___
