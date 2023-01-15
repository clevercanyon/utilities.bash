#!/usr/bin/env bash
# shellcheck disable=SC2034
##
# Utility include.
##

##
# Prompt for interactive shell mode.
##

function :___ishell_prompt_closure___() {
    ##
    # Intializes local vars.
    ##

    local p4t_hostname="$(:chalk-white "\h")"                                         # Dynamic; based on hostname.
    local p4t_directory="$(:chalk-black '[' && :chalk-blue "\w" && :chalk-black ']')" # Dynamic; based on current directory.
    local p4t_code_status="\`:ishell-p4t-code-status\`"                               # Dynamic; based on current code status.
    local p4t_prompt_symbol="$(:chalk-blue "\\$")"                                    # Dynamic; changes to `%` when running as `root` user.

    ##
    # Configures `PROMPT_COMMAND` & `PS1`.
    ##

    PROMPT_DIRTRIM=3                                                                 # Trim long directories; see <https://o5p.me/uFdq76>.
    PROMPT_COMMAND=''                                                                # Not in use at this time; see <https://o5p.me/6F2qt2>.
    PS1="${p4t_hostname} ${p4t_directory}\n${p4t_code_status} ${p4t_prompt_symbol} " # Bash prompt; pulling all of the above together.

} && :___ishell_prompt_closure___
