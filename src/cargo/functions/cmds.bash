#!/usr/bin/env bash
##
# Utility function(s).
##

##
# An array of all bash builtins.
# Acquired by running `$ help` in bash.
##
___builtins___=()
___builtins___+=(':')
___builtins___+=('.')
___builtins___+=('alias')
___builtins___+=('bg')
___builtins___+=('bind')
___builtins___+=('break')
___builtins___+=('builtin')
___builtins___+=('caller')
___builtins___+=('case')
___builtins___+=('cd')
___builtins___+=('command')
___builtins___+=('compgen')
___builtins___+=('complete')
___builtins___+=('compopt')
___builtins___+=('continue')
___builtins___+=('coproc')
___builtins___+=('declare')
___builtins___+=('dirs')
___builtins___+=('disown')
___builtins___+=('echo')
___builtins___+=('enable')
___builtins___+=('eval')
___builtins___+=('exec')
___builtins___+=('exit')
___builtins___+=('export')
___builtins___+=('false')
___builtins___+=('fc')
___builtins___+=('fg')
___builtins___+=('for')
___builtins___+=('function')
___builtins___+=('getopts')
___builtins___+=('hash')
___builtins___+=('help')
___builtins___+=('history')
___builtins___+=('if')
___builtins___+=('jobs')
___builtins___+=('kill')
___builtins___+=('let')
___builtins___+=('local')
___builtins___+=('logout')
___builtins___+=('mapfile')
___builtins___+=('popd')
___builtins___+=('printf')
___builtins___+=('pushd')
___builtins___+=('pwd')
___builtins___+=('read')
___builtins___+=('readarray')
___builtins___+=('readonly')
___builtins___+=('return')
___builtins___+=('select')
___builtins___+=('set')
___builtins___+=('shift')
___builtins___+=('shopt')
___builtins___+=('source')
___builtins___+=('suspend')
___builtins___+=('test')
___builtins___+=('time')
___builtins___+=('times')
___builtins___+=('trap')
___builtins___+=('true')
___builtins___+=('type')
___builtins___+=('typeset')
___builtins___+=('ulimit')
___builtins___+=('umask')
___builtins___+=('unalias')
___builtins___+=('unset')
___builtins___+=('until')
___builtins___+=('variables')
___builtins___+=('wait')
___builtins___+=('while')

##
# Checks if a CMD is a shell builtin.
# Acquired by running `$ help` in latest bash.
#
# @param string ${1} Command name.
#
# @output void No output.
# @return int `0` (true) if CMD is a builtin.
##
function :is-builtin() {
    local cmd="${1:-}"  # First argument.
    local ___builtin___ # Used in loop below.

    for ___builtin___ in "${___builtins___[@]}"; do
        if [[ "${cmd}" == "${___builtin___}" ]]; then
            return 0 # True.
        fi
    done
    return 1 # False.
}

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
    local cmd="${1:-}" # First argument.

    if :is-builtin "${cmd}"; then
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
    local cmd="${1:-}"   # First argument.
    local path="${PATH}" # Local working path.

    local re='(?:'"$(:esc-regexp "${HOME}")"'|~)\/\.?bin'
    path="$(echo "${path}" | perl -0wpe 's/^'"${re}"'\:|\:'"${re}"'$|\:'"${re}"'(?=\:)//ug')"

    if :is-builtin "${cmd}"; then
        PATH="${path}" builtin "${@}" # <https://ss64.com/bash/builtin.html>
    else
        PATH="${path}" command "${@}" # <https://ss64.com/bash/command.html>
    fi
}

##
# Runs a command using `${PATH}`; ignoring functions.
# Uses a system default `${PATH}` via `/etc/paths` + `/etc/paths.d`.
# Similar behavior exhibited by `/usr/libexec/path_helper -s` on macOS, *except*;
# if `/opt/homebrew` exists, it will be additionally prepended to system default `${PATH}`.
#
# @param string ${1} Command name.
# @param mixed ...${@} Variadic.
#
# @output mixed Based on command being run.
# @return int Exit status of command being run.
##
function ::::() {
    local cmd="${1:-}" # First argument.
    # Concatenates paths, removes empty|comment lines, then joins lines with a `:` colon.
    local path="$(cat /etc/paths /etc/paths.d/* | :no-empty-lines --no-comment-lines | tr '\n' ':')"

    if [[ -d /opt/homebrew ]]; then
        path=/opt/homebrew/bin:/opt/homebrew/sbin:"${path}"
    fi
    if :is-builtin "${cmd}"; then
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
    local cmd="${1:-}" # First argument.
    # Concatenates paths, removes empty|comment lines, then joins lines with a `:` colon.
    local path="$(cat /etc/paths /etc/paths.d/* | :no-empty-lines --no-comment-lines | tr '\n' ':')"

    if :is-builtin "${cmd}"; then
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
    local cmd="${1:-}"           # First argument.
    local path="$(getconf PATH)" # POSIX path; see <https://o5p.me/AcT7Pr>.

    if :is-builtin "${cmd}"; then
        PATH="${path}" builtin "${@}" # <https://ss64.com/bash/builtin.html>
    else
        PATH="${path}" command "${@}" # <https://ss64.com/bash/command.html>
    fi
}
