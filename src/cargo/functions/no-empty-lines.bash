#!/usr/bin/env bash
##
# Utility function(s).
##

##
# Removes empty lines and/or comment lines.
#
# @param string  ${1}                 String to remove empty lines from; or `/dev/stdin`.
#                                     `/dev/stdin`, when exists, takes precedence.
#
# @param boolean {--no-comment-lines} To also remove comment lines.
#
# @output String w/o empty lines.
# @return int `0` (true) on success.
##
function :no-empty-lines() {
    declare -A opts
    local long_opts='no-comment-lines'
    :parse-opts ':no-empty-lines' '' "${long_opts}" opts -- "${@}"

    local str="${opts[_1]:-}" # Initialize.
    local no_comment_lines="${opts[no_comment_lines]:-}"

    if [[ -p /dev/stdin ]]; then
        if [[ "${no_comment_lines}" == true ]]; then
            perl -0wpe 's/^\h*#.*\v*//umg' | perl -0wpe 's/^\h*\v*$//umg' | :trim
        else
            perl -0wpe 's/^\h*\v*$//umg' | :trim
        fi
    else
        if [[ "${no_comment_lines}" == true ]]; then
            str="$(echo -n "${str}" | perl -0wpe 's/^\h*#.*\v*//umg')"
        fi
        echo -n "${str}" | perl -0wpe 's/^\h*\v*$//umg' | :trim
    fi
}
