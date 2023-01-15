#!/usr/bin/env bash
# shellcheck disable=SC2034
##
# Utility include.
##

##
# Completion opts for interactive shell mode.
##
function :___ishell_completion_closure() {
    ##
    # Sets completion options.
    # Use `~/.bash_completion` to customize.
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

    BASH_COMPLETION_DIR=/dev/null        # Don't use full set of completions.
    BASH_COMPLETION_COMPAT_DIR=/dev/null # Don't use full set of completions.

    if [[ -n "${BREW_PREFIX:-}" && -f "${BREW_PREFIX}"/etc/bash_completion ]]; then
        . "${BREW_PREFIX}"/etc/bash_completion # Pulls in `~/.bash_completion`.

    elif [[ -f /opt/homebrew/etc/bash_completion ]]; then
        . /opt/homebrew/etc/bash_completion # Pulls in `~/.bash_completion`.

    elif [[ -f /usr/local/etc/bash_completion ]]; then
        . /usr/local/etc/bash_completion # Pulls in `~/.bash_completion`.

    elif [[ -f /etc/bash_completion ]]; then
        . /etc/bash_completion # Pulls in `~/.bash_completion`.

    elif [[ -f ~/.bash_completion ]]; then
        . ~/.bash_completion # Pulls in `~/.bash_completion`.
    fi

} && :___ishell_completion_closure && unset -f :___ishell_completion_closure
