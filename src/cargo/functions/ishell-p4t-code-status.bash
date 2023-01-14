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
