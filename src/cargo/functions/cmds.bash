#!/usr/bin/env bash
##
# Utility function(s).
##

##
# Runs a command using `${PATH}`; ignoring functions.
# Uses current `${PATH}` as-is; no change.
#
# @param string ${1} Command name.
# @param mixed ...${@} Variadic.
#
# @output mixed Based on command being run.
# @return int Exit status of command being run.
##
function ::() {
    if [[ "$(type -t "${1:-}")" == builtin ]]; then
        builtin "${@}" # <https://ss64.com/bash/builtin.html>
    else
        command "${@}" # <https://ss64.com/bash/command.html>
    fi
}

##
# Runs a command using `${PATH}`; ignoring functions.
# Uses a `${PATH}` that excludes `${HOME}/.?bin`, `~/.?bin`.
#
# @param string ${1} Command name.
# @param mixed ...${@} Variadic.
#
# @output mixed Based on command being run.
# @return int Exit status of command being run.
##
function :::() {
    local path="${PATH}"
    local re='(?:'"$(esc-regexp "${HOME}")"'|~)\/\.?bin'
    path="$(echo "${path}" | perl -0wpe 's/^'"${re}"'\:|\:'"${re}"'$|\:'"${re}"'(?=\:)//ug')"

    if [[ "$(type -t "${1:-}")" == builtin ]]; then
        PATH="${path}" builtin "${@}" # <https://ss64.com/bash/builtin.html>
    else
        PATH="${path}" command "${@}" # <https://ss64.com/bash/command.html>
    fi
}

##
# Runs a command using `${PATH}`; ignoring functions.
# Uses a system default `${PATH}` via `/etc/paths` + `/etc/paths.d`.
# Similar behavior exhibited by `/usr/libexec/path_helper -s` on macOS, *except*;
# if `~/Brew|/opt/homebrew` exists, it will be additionally prepended to system default `${PATH}`.
#
# @param string ${1} Command name.
# @param mixed ...${@} Variadic.
#
# @output mixed Based on command being run.
# @return int Exit status of command being run.
##
function ::::() {
    # Concatenates paths, removes empty|comment lines, then joins lines with a `:` colon.
    local path="$(cat /etc/paths /etc/paths.d/* | no-empty-lines --no-comment-lines | tr '\n' ':')"
    if [[ -d ~/Brew ]]; then
        path=~/Brew/bin:~/Brew/sbin:"${path}"
    elif [[ -d /opt/homebrew ]]; then
        path=/opt/homebrew/bin:/opt/homebrew/sbin:"${path}"
    fi
    if [[ "$(type -t "${1:-}")" == builtin ]]; then
        PATH="${path}" builtin "${@}" # <https://ss64.com/bash/builtin.html>
    else
        PATH="${path}" command "${@}" # <https://ss64.com/bash/command.html>
    fi
}

##
# Runs a command using `${PATH}`; ignoring functions.
# Uses a system default `${PATH}` via `/etc/paths` + `/etc/paths.d`.
# Same behavior exhibited by `/usr/libexec/path_helper -s` on macOS; no change.
#
# @param string ${1} Command name.
# @param mixed ...${@} Variadic.
#
# @output mixed Based on command being run.
# @return int Exit status of command being run.
##
function :::::() {
    # Concatenates paths, removes empty|comment lines, then joins lines with a `:` colon.
    local path="$(cat /etc/paths /etc/paths.d/* | no-empty-lines --no-comment-lines | tr '\n' ':')"

    if [[ "$(type -t "${1:-}")" == builtin ]]; then
        PATH="${path}" builtin "${@}" # <https://ss64.com/bash/builtin.html>
    else
        PATH="${path}" command "${@}" # <https://ss64.com/bash/command.html>
    fi
}

##
# Runs a command using `${PATH}`; ignoring functions.
# Uses a POSIX system default `${PATH}` via `getconf PATH`.
#
# @param string ${1} Command name.
# @param mixed ...${@} Variadic.
#
# @output mixed Based on command being run.
# @return int Exit status of command being run.
##
function ::::::() {
    local path="$(getconf PATH)" # POSIX path; see <https://o5p.me/AcT7Pr>.

    if [[ "$(type -t "${1:-}")" == builtin ]]; then
        PATH="${path}" builtin "${@}" # <https://ss64.com/bash/builtin.html>
    else
        PATH="${path}" command "${@}" # <https://ss64.com/bash/command.html>
    fi
}
