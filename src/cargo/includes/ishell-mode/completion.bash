#!/usr/bin/env bash
##
# Utility include.
##

##
# Completion options for interactive shell mode.
##

function :___ishell_completion_closure___() {
    ##
    # Sets completion options.
    # See also: `./bash.inputrc` options.
    ##

    # shellcheck disable=SC2034
    BASH_COMPLETION_USER_FILE=~/.bash_completion

    ##
    # Loads bash completion script.
    # Use `~/.bash_completion` & `~/.inputrc` to customize further.
    ##

    if [[ -n "${BREW_PREFIX:-}" && -f "${BREW_PREFIX}"/etc/profile.d/bash_completion.sh ]]; then
        . "${BREW_PREFIX}"/etc/profile.d/bash_completion.sh
    fi
} && :___ishell_completion_closure___
