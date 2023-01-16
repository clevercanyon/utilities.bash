#!/usr/bin/env bash
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

    export LANG=en_US.UTF-8
    export LC_ALL=en_US.UTF-8

    ##
    # Set brew prefix var when applicable.
    ##

    if [[ -x /opt/homebrew/bin/brew ]]; then
        export BREW_PREFIX=/opt/homebrew

    elif [[ -x /usr/local/bin/brew ]]; then
        export BREW_PREFIX=/usr/local

    elif :can-run brew; then
        export BREW_PREFIX="$(brew --prefix)"
    fi

    ##
    # Set (n)ode prefix var when applicable.
    ##

    if [[ -n "${BREW_PREFIX:-}" && -d "${BREW_PREFIX}"/opt/n ]]; then
        export N_PREFIX="${BREW_PREFIX}"/opt/n.node
    fi

    ##
    # Sets default text editor var when applicable.
    ##

    if [[ -n "${BREW_PREFIX:-}" && -x "${BREW_PREFIX}"/bin/vim ]]; then
        export EDITOR="${BREW_PREFIX}"/bin/vim
    fi
} && :___ishell_env_vars_closure___
