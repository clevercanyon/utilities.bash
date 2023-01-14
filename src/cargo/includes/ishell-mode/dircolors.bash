#!/usr/bin/env bash
# shellcheck disable=SC2034
##
# Utility include.
##

##
# Dircolors for interactive shell mode.
##
function :___ishell_dircolors_closure() {
    ##
    # Exports custom `LS_COLORS`.
    ##

    local __dirname="$(cd "$(dirname "${BASH_SOURCE[0]}")" &> /dev/null && pwd)"
    [[ -d "${__dirname}" ]] || { :chalk-danger 'Missing `__dirname`!' >&2 && return 1; }

    if [[ -n "${BREW_PREFIX:-}" && -x "${BREW_PREFIX}"/opt/coreutils/libexec/gnubin/dircolors ]]; then
        eval "$("${BREW_PREFIX}"/opt/coreutils/libexec/gnubin/dircolors "${__dirname}"/bash.dircolors)"

    elif [[ -x /opt/homebrew/opt/coreutils/libexec/gnubin/dircolors ]]; then
        eval "$(/opt/homebrew/opt/coreutils/libexec/gnubin/dircolors "${__dirname}"/bash.dircolors)"

    elif [[ -x /usr/local/opt/coreutils/libexec/gnubin/dircolors ]]; then
        eval "$(/usr/local/opt/coreutils/libexec/gnubin/dircolors "${__dirname}"/bash.dircolors)"

    elif can-run dircolors; then
        eval "$(dircolors "${__dirname}"/bash.dircolors)"
    fi

} && :___ishell_dircolors_closure && unset -f :___ishell_dircolors_closure
