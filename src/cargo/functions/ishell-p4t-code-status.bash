#!/usr/bin/env bash
##
# Utility function(s).
##

##
# Gets current code status for prompt.
#
# @output string Current code status for prompt.
# @return int `0` (true) on success.
##
function :ishell-p4t-code-status() {
    if ! :in-git-repo; then
        return 0 # Not applicable.
    fi
    local git_repo_icon="$(:chalk-white '')" git_status_icon="$(:chalk-white '')"
    :git-repo-has-github-origin && git_repo_icon="$(:chalk-white '')"
    :git-repo-is-dirty && git_status_icon="$(:chalk-white '')"

    local npm_pkg_icon='' # Initialize.
    :in-npm-pkg && npm_pkg_icon=" $(:chalk-red '')"

    local git_ref_icon='' gif_ref_label="$(:git-current-branch)"
    [[ -z "${gif_ref_label}" ]] && git_ref_icon='' && gif_ref_label="$(:git-current-tag)"
    [[ -z "${gif_ref_label}" ]] && git_ref_icon='' && gif_ref_label="$(:git-current-sha --short)"
    git_ref_icon="$(:chalk-black "${git_ref_icon}")" && gif_ref_label="$(:chalk-gray "${gif_ref_label}")"

    echo -ne " " && echo -ne "${git_repo_icon}${npm_pkg_icon}" &&
        echo -ne "  " && echo -ne "${git_status_icon} ${git_ref_icon}" &&
        echo -ne " " && echo -ne "${gif_ref_label}"
}
