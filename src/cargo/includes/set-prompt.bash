#!/usr/bin/env bash
##
# Bash `PS1` prompt.
#
# This file include must remain entirely self-contained.
# All globals have been prefixed with `p4t-` to scope them
# specifically to prompt handling — avoiding global pollution.
#
# Note: `p4t` is a numeronym for the word `prompt`.
##

##
# CMD utilities.
##

##
# Can run a command?
#
# @param string ${1} Command name.
#
# @output void No output.
# @return int `0` (true) if can run command name.
##
function :p4t-can-run() {
    local name="${1:-}"

    if [[ -z "${name}" ]]; then
        return 1 # False.
    fi
    command -v "${name}" > /dev/null 2>&1
}

##
# Chalk utilities.
##

##
# Colorizes a string in default color.
#
# @param string ${1} String.
#
# @output string Colorized string.
# @return int `0` (true) on success.
##
function :p4t-chalk-default() {
    local str="${1:-}"
    echo -ne "\e[39m${str}\e[0m"
}

##
# Colorizes a string in gray color.
#
# @param string ${1} String.
#
# @output string Colorized string.
# @return int `0` (true) on success.
##
function :p4t-chalk-gray() {
    local str="${1:-}"
    echo -ne "\e[90m${str}\e[0m"
}

##
# Colorizes a string in black color.
#
# @param string ${1} String.
#
# @output string Colorized string.
# @return int `0` (true) on success.
##
function :p4t-chalk-black() {
    local str="${1:-}"
    echo -ne "\e[30m${str}\e[0m"
}

##
# Colorizes a string in red color.
#
# @param string ${1} String.
#
# @output string Colorized string.
# @return int `0` (true) on success.
##
function :p4t-chalk-red() {
    local str="${1:-}"
    echo -ne "\e[31m${str}\e[0m"
}

##
# Colorizes a string in green color.
#
# @param string ${1} String.
#
# @output string Colorized string.
# @return int `0` (true) on success.
##
function :p4t-chalk-green() {
    local str="${1:-}"
    echo -ne "\e[32m${str}\e[0m"
}

##
# Colorizes a string in yellow color.
#
# @param string ${1} String.
#
# @output string Colorized string.
# @return int `0` (true) on success.
##
function :p4t-chalk-yellow() {
    local str="${1:-}"
    echo -ne "\e[33m${str}\e[0m"
}

##
# Colorizes a string in blue color.
#
# @param string ${1} String.
#
# @output string Colorized string.
# @return int `0` (true) on success.
##
function :p4t-chalk-blue() {
    local str="${1:-}"
    echo -ne "\e[34m${str}\e[0m"
}

##
# Colorizes a string in magenta color.
#
# @param string ${1} String.
#
# @output string Colorized string.
# @return int `0` (true) on success.
##
function :p4t-chalk-magenta() {
    local str="${1:-}"
    echo -ne "\e[35m${str}\e[0m"
}

##
# Colorizes a string in cyan color.
#
# @param string ${1} String.
#
# @output string Colorized string.
# @return int `0` (true) on success.
##
function :p4t-chalk-cyan() {
    local str="${1:-}"
    echo -ne "\e[36m${str}\e[0m"
}

##
# Colorizes a string in light gray color.
#
# @param string ${1} String.
#
# @output string Colorized string.
# @return int `0` (true) on success.
##
function :p4t-chalk-light-gray() {
    local str="${1:-}"
    echo -ne "\e[37m${str}\e[0m"
}

##
# Colorizes a string in light red color.
#
# @param string ${1} String.
#
# @output string Colorized string.
# @return int `0` (true) on success.
##
function :p4t-chalk-light-red() {
    local str="${1:-}"
    echo -ne "\e[91m${str}\e[0m"
}

##
# Colorizes a string in light green color.
#
# @param string ${1} String.
#
# @output string Colorized string.
# @return int `0` (true) on success.
##
function :p4t-chalk-light-green() {
    local str="${1:-}"
    echo -ne "\e[92m${str}\e[0m"
}

##
# Colorizes a string in light yellow color.
#
# @param string ${1} String.
#
# @output string Colorized string.
# @return int `0` (true) on success.
##
function :p4t-chalk-light-yellow() {
    local str="${1:-}"
    echo -ne "\e[93m${str}\e[0m"
}

##
# Colorizes a string in light blue color.
#
# @param string ${1} String.
#
# @output string Colorized string.
# @return int `0` (true) on success.
##
function :p4t-chalk-light-blue() {
    local str="${1:-}"
    echo -ne "\e[94m${str}\e[0m"
}

##
# Colorizes a string in light magenta color.
#
# @param string ${1} String.
#
# @output string Colorized string.
# @return int `0` (true) on success.
##
function :p4t-chalk-light-magenta() {
    local str="${1:-}"
    echo -ne "\e[95m${str}\e[0m"
}

##
# Colorizes a string in light cyan color.
#
# @param string ${1} String.
#
# @output string Colorized string.
# @return int `0` (true) on success.
##
function :p4t-chalk-light-cyan() {
    local str="${1:-}"
    echo -ne "\e[96m${str}\e[0m"
}

##
# Colorizes a string in white color.
#
# @param string ${1} String.
#
# @output string Colorized string.
# @return int `0` (true) on success.
##
function :p4t-chalk-white() {
    local str="${1:-}"
    echo -ne "\e[97m${str}\e[0m"
}

##
# Git utilities.
##

##
# Checks if in a git repo.
#
# @output void No output.
# @return int `0` (true) if in a git repo.
##
function :p4t-in-git-repo() {
    if ! :p4t-can-run git; then
        return 1 # False.
    fi
    git rev-parse --is-inside-work-tree &> /dev/null
}

##
# Gets current local git branch.
#
# @output string Current local git branch.
# @return int `0` (true) on success.
##
function :p4t-git-current-branch() {
    local branch='' # Initialize.
    branch="$(git symbolic-ref --short --quiet HEAD 2> /dev/null)"

    if [[ -z "${branch}" ]]; then
        return 1 # False.
    fi
    echo "${branch}"
}

##
# Gets current local git tag.
#
# @output string Current local git tag.
# @return int `0` (true) on success.
##
function :p4t-git-current-tag() {
    local tag='' # Initialize.
    tag="$(git describe --tags --exact-match 2> /dev/null)"

    if [[ -z "${tag}" ]]; then
        return 1 # False.
    fi
    echo "${tag}"
}

##
# Gets current local git short SHA.
#
# @param string ${1} Pass `--short` to get short SHA.
#
# @output string Current local git short SHA.
# @return int `0` (true) on success.
##
function :p4t-git-current-sha() {
    local sha=''         # Initialize.
    local short="${1:-}" # Short SHA?

    if [[ "${short}" == '--short' ]]; then
        sha="$(git rev-parse --short HEAD 2> /dev/null)"
    else
        sha="$(git rev-parse HEAD 2> /dev/null)"
    fi
    if [[ -z "${sha}" ]]; then
        return 1 # False.
    fi
    echo "${sha}"
}

##
# NPM utilities.
##

##
# Checks if in an NPM package.
#
# @output void No output.
# @return int `0` (true) if in a git repo.
##
function :p4t-in-npm-pkg() {
    if ! :p4t-can-run npm; then
        return 1 # False.
    fi
    local prefix="$(npm prefix)"

    if [[ -n "${prefix}" && "${prefix}" != "${HOME}" && "${prefix}" != '/' && "${prefix}" != "$(npm prefix --global)" ]]; then
        return 0 # True.
    else
        return 1 # False.
    fi
}

##
# Prompt utilities.
##

##
# Gets current code status.
#
# @output string Current git status.
# @return int `0` (true) on success.
##
function :p4t-code-status() {
    if ! :p4t-in-git-repo; then
        return 0 # Not applicable.
    fi
    local in_git_repo_icon=''

    local in_npm_pkg_icon='' # Initialize.
    :p4t-in-npm-pkg && in_npm_pkg_icon=' '

    local git_ref_icon='' gif_ref_label=''
    git_ref_icon="" && gif_ref_label="$(:p4t-git-current-branch)"
    [[ -z "${gif_ref_label}" ]] && git_ref_icon="" && gif_ref_label="$(:p4t-git-current-tag)"
    [[ -z "${gif_ref_label}" ]] && git_ref_icon="" && gif_ref_label="$(:p4t-git-current-sha --short)"

    :p4t-chalk-white "${in_git_repo_icon}${in_npm_pkg_icon} ${git_ref_icon} " && :p4t-chalk-black '[' && :p4t-chalk-gray "${gif_ref_label}" && :p4t-chalk-black ']'
}

##
# Exports `PS1` for bash prompt value.
#
# @output void No output.
# @return int `0` (true) on success.
##
function :___closure() {
    local hostname="$(:p4t-chalk-white "\h")"                                                 # Dynamic; based on hostname.
    local directory="$(:p4t-chalk-black '[' && :p4t-chalk-blue "\w" && :p4t-chalk-black ']')" # Dynamic; based on current directory.
    local code_status="\`:p4t-code-status\`"                                                  # Dynamic; based on current code status.
    local prompt_symbol="$(:p4t-chalk-blue "\\$")"                                            # Dynamic; changes to `%` when running as `root` user.

    export PS1="${hostname} ${directory}\n${code_status} ${prompt_symbol} " # Bash prompt; pulling all of the above together.

} && :___closure
unset -f :___closure
