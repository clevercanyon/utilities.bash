#!/usr/bin/env bash
##
# Utility function(s).
##

##
# Removes empty lines and/or comment lines.
#
# @param string ${1} String to remove empty lines from.
# @param string ${2} Pass `--no-comment-lines` to also remove comment lines.
#
# Alternate signature for `/dev/stdin`, which obviates the need for first argument.
#     @param string ${1} Pass `--no-comment-lines` to also remove comment lines.
#
# @output String w/o empty lines.
# @return int `0` (true) on success.
##
function :no-empty-lines() {
    local str=''
    local no_comment_lines=''

    if [[ -p /dev/stdin ]]; then
        # /dev/stdin as `str`
        no_comment_lines="${1:-}"

        if [[ "${no_comment_lines}" == '--no-comment-lines' ]]; then
            perl -0wpe 's/^\h*#.*\v*//umg' | perl -0wpe 's/^\h*\v*$//umg' | :trim
        else
            perl -0wpe 's/^\h*\v*$//umg' | :trim
        fi

    else
        str="${1:-}"
        no_comment_lines="${2:-}"

        if [[ "${no_comment_lines}" == '--no-comment-lines' ]]; then
            echo -n "${str}" | perl -0wpe 's/^\h*#.*\v*//umg' | perl -0wpe 's/^\h*\v*$//umg' | :trim
        else
            echo -n "${str}" | perl -0wpe 's/^\h*\v*$//umg' | :trim
        fi
    fi
}
