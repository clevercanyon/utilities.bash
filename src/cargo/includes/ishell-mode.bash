#!/usr/bin/env bash
# shellcheck disable=SC2034
##
# Utility include.
##

##
# Interactive shell mode.
# Note: All modes inherit strict mode.
# Here we adjust and/or add to strict mode.
##
function :___ishell_mode_closure() {
    ##
    # Partially reverts strict options.
    # i.e., `+` indicates reverse/disable.
    ##

    set +o nounset
    set +o errexit
    set +o errtrace
    trap - ERR

    ##
    # Sets default umask.
    ##

    umask 0022 # 755 & 644.

    ##
    # Sets window options.
    ##

    shopt -s checkwinsize

    ##
    # Sets history options.
    ##

    shopt -s lithist
    shopt -s histappend

    HISTSIZE=10000
    HISTFILESIZE=20000

    HISTCONTROL=erasedups:ignoreboth
    HISTIGNORE='exit:ls:bg:fg:history:clear'

    ##
    # Sets completion options.
    # Use `~/.bash_completion` to customize.
    ##

    bind Space:magic-space

    bind 'set completion-ignore-case on'
    bind 'set completion-map-case on'

    bind 'set show-all-if-ambiguous on'
    bind 'set mark-symlinked-directories on'

    BASH_COMPLETION_DIR=/dev/null
    BASH_COMPLETION_COMPAT_DIR=/dev/null

    if [[ -f /opt/homebrew/etc/bash_completion ]]; then
        . /opt/homebrew/etc/bash_completion # Pulls in `~/.bash_completion`.

    elif [[ -f /usr/local/etc/bash_completion ]]; then
        . /usr/local/etc/bash_completion # Pulls in `~/.bash_completion`.

    elif [[ -f /etc/bash_completion ]]; then
        . /etc/bash_completion # Pulls in `~/.bash_completion`.

    elif [[ -f ~/.bash_completion ]]; then
        . ~/.bash_completion # Pulls in `~/.bash_completion`.
    fi

    ##
    # Exports custom `LS_COLORS`.
    ##

    local __dirname="$(cd "$(dirname "${BASH_SOURCE[0]}")" &> /dev/null && pwd)"
    [[ -d "${__dirname}" ]] || { echo -e "\x01\e[31m\x02"'Missing `__dirname`.'"\x01\e[0m\x02" >&2 && exit 1; }

    eval "$(dircolors "${__dirname}"/ishell.dircolors)"

    ##
    # Bash prompt via `PROMPT_COMMAND` & `PS1`.
    ##

    local p4t_hostname="$(:chalk-white "\h")"                                         # Dynamic; based on hostname.
    local p4t_directory="$(:chalk-black '[' && :chalk-blue "\w" && :chalk-black ']')" # Dynamic; based on current directory.
    local p4t_code_status="\`:p4t-code-status\`"                                      # Dynamic; based on current code status.
    local p4t_prompt_symbol="$(:chalk-blue "\\$")"                                    # Dynamic; changes to `%` when running as `root` user.

    PROMPT_DIRTRIM=3                                                                 # Trim long directories; see <https://o5p.me/uFdq76>.
    PROMPT_COMMAND=''                                                                # Not in use at this time; see <https://o5p.me/6F2qt2>.
    PS1="${p4t_hostname} ${p4t_directory}\n${p4t_code_status} ${p4t_prompt_symbol} " # Bash prompt; pulling all of the above together.

} && :___ishell_mode_closure && unset -f :___ishell_mode_closure
