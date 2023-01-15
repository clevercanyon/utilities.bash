#!/usr/bin/env bash
# shellcheck disable=SC2034
##
# Utility include.
##

##
# Environment vars for interactive shell mode.
##

function :___ishell_env_vars_closure___() {
    ##
    # Sets locale vars.
    ##

    if [[ -z "${LANG:-}" ]]; then
        export LANG=en_US.UTF-8
    fi
    if [[ -z "${LC_ALL:-}" ]]; then
        export LC_ALL=en_US.UTF-8
    fi

    ##
    # Set brew prefix var when applicable.
    ##

    if [[ -z "${BREW_PREFIX:-}" ]]; then
        if [[ -x /opt/homebrew/bin/brew ]]; then
            export BREW_PREFIX=/opt/homebrew
        elif [[ -x /usr/local/bin/brew ]]; then
            export BREW_PREFIX=/usr/local
        elif :can-run brew; then
            export BREW_PREFIX="$(brew --prefix)"
        fi
    fi

    ##
    # Set (n)ode prefix var when applicable.
    ##

    if [[ -z "${N_PREFIX:-}" ]]; then
        if [[ -n "${BREW_PREFIX:-}" && -d "${BREW_PREFIX}"/opt/n ]]; then
            export N_PREFIX="${BREW_PREFIX}"/opt/n.node
        fi
    fi

    ##
    # Sets default text editor var when applicable.
    ##

    if [[ -z "${EDITOR:-}" ]]; then
        if [[ -n "${BREW_PREFIX:-}" && -x "${BREW_PREFIX}"/bin/vim ]]; then
            export EDITOR="${BREW_PREFIX}"/bin/vim
        fi
    fi
} && :___ishell_env_vars_closure___
