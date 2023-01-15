#!/usr/bin/env bash
# shellcheck disable=SC2034
##
# Utility include.
##

##
# Completion opts for interactive shell mode.
##

function :___ishell_completion_closure___() {
    ##
    # Sets completion options.
    ##

    bind Space:magic-space

    bind 'set completion-ignore-case on'
    bind 'set completion-map-case on'

    bind 'set colored-stats on'
    bind 'set mark-symlinked-directories on'

    bind 'set show-all-if-ambiguous on'
    bind 'set completion-query-items 250'

    bind 'set colored-completion-prefix on'
    bind 'set menu-complete-display-prefix on'
    bind 'set completion-prefix-display-length 75'

    bind '"\e[B": history-search-forward'
    bind '"\eOB": history-search-forward'

    bind '"\e[A": history-search-backward'
    bind '"\eOA": history-search-backward'

    BASH_COMPLETION_DIR=/dev/null                # Don't use full set of completions.
    BASH_COMPLETION_COMPAT_DIR=/dev/null         # Don't use full set of completions.
    BASH_COMPLETION_USER_FILE=~/.bash_completion # Use only completions pulled in by user.

    ##
    # Loads bash completion script.
    ##

    # Note: Use `~/.bash_completion` to customize further.
    # i.e., Completion script pulls in `~/.bash_completion` automatically.

    if [[ -n "${BREW_PREFIX:-}" && -f "${BREW_PREFIX}"/etc/profile.d/bash_completion.sh ]]; then
        . "${BREW_PREFIX}"/etc/profile.d/bash_completion.sh
    fi
} && :___ishell_completion_closure___
