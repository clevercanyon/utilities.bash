#!/usr/bin/env bash
##
# Utility include.
##

##
# Note: All modes inherit strict mode.
# Here we adjust and/or add to strict mode.
##

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

HISTSIZE=1000
HISTFILESIZE=2000
HISTCONTROL=ignoreboth
shopt -s histappend

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
    local in_git_repo_icon="$(:chalk-white '')"
    :git-repo-has-github-origin && in_git_repo_icon="$(:chalk-white '')"
    :git-repo-is-dirty && in_git_repo_icon+=" $(:chalk-black '')"

    local in_npm_pkg_icon='' # Initialize NPM pkg icon.
    :in-npm-pkg && in_npm_pkg_icon=" $(:chalk-red '')"

    local git_ref_icon='' gif_ref_label='' # Initialize.
    git_ref_icon="" && gif_ref_label="$(:git-current-branch)"
    [[ -z "${gif_ref_label}" ]] && git_ref_icon="" && gif_ref_label="$(:git-current-tag)"
    [[ -z "${gif_ref_label}" ]] && git_ref_icon="" && gif_ref_label="$(:git-current-sha --short)"

    echo -ne " " && echo -ne "${in_git_repo_icon}${in_npm_pkg_icon}" &&
        echo -ne "  " && :chalk-black "${git_ref_icon}" && echo -ne " " && :chalk-gray "${gif_ref_label}"
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

    export PROMPT_COMMAND=''                                                # Not in use at this time; see <https://o5p.me/HyG7sF>.
    export PS1="${hostname} ${directory}\n${code_status} ${prompt_symbol} " # Bash prompt; pulling all of the above together.
} && :___closure && unset -f :___closure
