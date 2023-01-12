#!/usr/bin/env bash
##
# Bash `PS1` prompt via `PS1`.
#
# All globals have been prefixed with `p4t-` to scope them
# specifically to prompt handling; avoiding global pollution.
# Note: `p4t` is a numeronym for the word `prompt`.
##

##
# Gets current code status.
#
# @output string Current git status.
# @return int `0` (true) on success.
##
function :p4t-code-status() {
    if ! :in-git-repo; then
        return 0 # Not applicable.
    fi
    local in_git_repo_icon=''

    local in_npm_pkg_icon='' # Initialize.
    :in-npm-pkg && in_npm_pkg_icon=' '

    local git_ref_icon='' gif_ref_label=''
    git_ref_icon="" && gif_ref_label="$(:git-current-branch)"
    [[ -z "${gif_ref_label}" ]] && git_ref_icon="" && gif_ref_label="$(:git-current-tag)"
    [[ -z "${gif_ref_label}" ]] && git_ref_icon="" && gif_ref_label="$(:git-current-sha --short)"

    echo -ne " " && :chalk-white "${in_git_repo_icon}${in_npm_pkg_icon} ${git_ref_icon}" &&
        echo -ne " " && :chalk-black '[' && :chalk-gray "${gif_ref_label}" && :chalk-black ']'
}

##
# Exports `PS1` for bash prompt.
#
# @output void No output.
# @return int `0` (true) on success.
##
function :___closure() {
    local hostname="$(:chalk-white "\h")"                                         # Dynamic; based on hostname.
    local directory="$(:chalk-black '[' && :chalk-blue "\w" && :chalk-black ']')" # Dynamic; based on current directory.
    local code_status="\`:p4t-code-status\`"                                      # Dynamic; based on current code status.
    local prompt_symbol="$(:chalk-blue "\\$")"                                    # Dynamic; changes to `%` when running as `root` user.

    export PS1="${hostname} ${directory}\n${code_status} ${prompt_symbol} " # Bash prompt; pulling all of the above together.

} && :___closure && unset -f :___closure
