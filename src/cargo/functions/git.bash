#!/usr/bin/env bash
##
# Utility function(s).
##

##
# Checks if in a git repo.
#
# @output void No output.
# @return int `0` (true) if in a git repo.
##
function in-git-repo() {
    git rev-parse --is-inside-work-tree &> /dev/null
}

##
# Gets local git repo tree directory.
#
# @output string Git tree directory path.
# @return int `0` (true) on success.
##
function git-tree-dir() {
    local dir='' # Initialize.
    dir="$(git rev-parse --show-toplevel 2> /dev/null)"

    if [[ -z "${dir}" || ! -d "${dir}" ]]; then
        return 1 # False.
    fi
    echo "${dir}"
}

##
# Checks if git repo is dirty.
#
# @output void No output.
# @return int `0` (true) if repo is dirty.
##
function git-repo-is-dirty() {
    if [[ -n "$(git status --short 2> /dev/null)" ]]; then
        return 0 # True.
    else
        return 1 # False.
    fi
}

##
# Checks if local git branch exists.
#
# @param string ${1} Branch name.
#
# @output void No output.
# @return int `0` (true) if branch exists.
##
function git-branch-exists() {
    if [[ -z "${1:-}" ]]; then
        return 1 # False.
    fi
    git rev-parse --verify --quiet "${1}" &> /dev/null
}

##
# Checks if remote git branch exists.
#
# @param string ${1} Branch name.
#
# @output void No output.
# @return int `0` (true) if branch exists.
##
function git-remote-branch-exists() {
    if [[ -z "${1:-}" ]]; then
        return 1 # False.
    fi
    git ls-remote --exit-code origin refs/heads/"${1}" &> /dev/null
}

##
# Gets current local git branch.
#
# @output string Current local git branch.
# @return int `0` (true) on success.
##
function git-current-branch() {
    local branch='' # Initialize.
    branch="$(git symbolic-ref --short --quiet HEAD 2> /dev/null)"

    if [[ -z "${branch}" ]]; then
        return 1 # False.
    fi
    echo "${branch}"
}

##
# Produces GitHub issue ref.
#
# @param string ${1} GitHub owner.
# @param string ${2} GitHub repo.
# @param string ${3} GitHub issue.
#
# @output string GitHub issue ref.
# @return int `0` (true) on success.
##
function git-github-issue-ref() {
    local owner="${1:-}"
    local repo="${2:-}"
    local issue="${3:-}"

    if [[ -z "${owner}" || -z "${repo}" || -z "${issue}" || ! "${issue}" =~ ^[1-9][0-9]*$ ]]; then
        return 1 # False.
    fi
    echo "${owner}"'/'"${repo}"'#'"${issue}"
}

##
# Produces GitHub issue URL.
#
# @param string ${1} GitHub owner.
# @param string ${2} GitHub repo.
# @param string ${3} GitHub issue.
#
# @output string GitHub issue URL.
# @return int `0` (true) on success.
##
function git-github-issue-url() {
    local owner="${1:-}"
    local repo="${2:-}"
    local issue="${3:-}"

    if [[ -z "${owner}" || -z "${repo}" || -z "${issue}" || ! "${issue}" =~ ^[1-9][0-9]*$ ]]; then
        return 1 # False.
    fi
    echo 'https://github.com/'"${owner}"'/'"${repo}"'/issues/'"${issue}"
}

##
# Checks if local repo has a GitHub origin.
#
# @output void No output.
# @return int `0` (true) if local repo has a GitHub origin.
##
function git-repo-has-github-origin() {
    git remote -v | grep --perl-regexp --ignore-case '^origin\s.+?github\.com' &> /dev/null
}

##
# Parses local GitHub repo origin.
#
# @param string ${1} What to parse. One of: `owner` or `repo`.
#
# @output string Parsed value. One of `owner` or `repo`.
# @return int `0` (true) on success.
##
function git-repo-github-origin-parse() {
    local response=''
    local parse="${1:-}"
    local owner_repo_s_regexp='s/(.+?\bgithub\.com[\/:])([^\/]+?)\/([^\/]+?)(?:\.git)?\s+\((?:fetch|push)\)\s*$/$2\/$3/ui'
    local owner_repo="$(git remote -v | grep --perl-regexp --ignore-case '^origin\s.+?\bgithub\.com[\/:]' -m 1 | perl -wpe "${owner_repo_s_regexp}")"

    if [[ "${parse}" == 'owner' ]]; then
        response="$(echo "${owner_repo}" | perl -wpe 's/\/.+$//u')"
    elif [[ "${parse}" == 'repo' ]]; then
        response="$(echo "${owner_repo}" | perl -wpe 's/^.+?\///u')"
    fi
    if [[ -z "${response}" ]]; then
        return 1 # False.
    fi
    echo "${response}"
}
