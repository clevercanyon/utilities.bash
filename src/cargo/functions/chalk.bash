#!/usr/bin/env bash
##
# Utility function(s).
##

##
# Outputs a new line.
#
# @output string New line.
# @return int `0` (true) on success.
##
function chalk-new-line() { echo; }

##
# Outputs a horizontal line.
#
# @output string Horizontal line.
# @return int `0` (true) on success.
##
function chalk-horiz-line {
    echo '----------------------------------------------------------------------------------------------------'
}

##
# Outputs a string in default color.
#
# @param string ${1} String.
#
# @output string Colorized string.
# @return int `0` (true) on success.
##
function chalk-output() {
    local str="${1:-}"
    echo -e "${str}"
}

##
# Outputs a string in heading color.
#
# @param string ${1} String.
#
# @output string Colorized string.
# @return int `0` (true) on success.
##
function chalk-heading() {
    local str="${1:-}"

    if ! is-term-256-colors; then
        echo "${str}"
    elif is-term-on-dark-bg; then
        echo -e "\e[38;5;212m\e[1m${str}\e[0m\e[39m"
    else
        echo -e "\e[38;5;132m\e[1m${str}\e[0m\e[39m"
    fi
}

##
# Outputs a string in default color (dimmed).
#
# Typically used to output verbose details.
#
# @param string ${1} String.
#
# @output string Colorized string.
# @return int `0` (true) on success.
##
function chalk-log() {
    local str="${1:-}"

    if ! is-term-256-colors; then
        echo "${str}"
    elif is-term-on-dark-bg; then
        echo -e "\e[38;5;255m\e[2m${str}\e[0m\e[39m"
    else
        echo -e "\e[38;5;232m\e[2m${str}\e[0m\e[39m"
    fi
}

####
# Colorized output inspired by Bootstrap alerts: `info|warning|danger|success`.
##

# The hilite variants below use a background instead; i.e., behind white text to grab extra attention.
# Note: `info` = blue, `warning` = orange, `danger` = red, `success` = green.
# {@see https://getbootstrap.com/docs/4.0/components/alerts/}.

##
# Outputs string in a dynamic blue color.
#
# @param string ${1} String.
#
# @output string Colorized string.
# @return int `0` (true) on success.
##
function chalk-info() {
    local str="${1:-}"

    if ! is-term-256-colors; then
        echo "${str}"
    elif is-term-on-dark-bg; then
        echo -e "\e[38;5;39m\e[1m${str}\e[0m\e[39m"
    else
        echo -e "\e[38;5;26m\e[1m${str}\e[0m\e[39m"
    fi
}

##
# Outputs string in a dynamic blue color (hilite variant).
#
# Uses a background behind white text to grab extra attention.
#
# @param string ${1} String.
#
# @output string Colorized string.
# @return int `0` (true) on success.
##
function chalk-info-hilite() {
    local str="${1:-}"

    if ! is-term-256-colors; then
        echo "${str}"
    else
        echo -e "\e[38;5;255m\e[48;5;26m\e[1m${str}\e[0m\e[49m\e[39m"
    fi
}

##
# Outputs string in a dynamic orange color.
#
# @param string ${1} String.
#
# @output string Colorized string.
# @return int `0` (true) on success.
##
function chalk-warning() {
    local str="${1:-}"

    if ! is-term-256-colors; then
        echo "${str}"
    elif is-term-on-dark-bg; then
        echo -e "\e[38;5;214m\e[1m${str}\e[0m\e[39m"
    else
        echo -e "\e[38;5;130m\e[1m${str}\e[0m\e[39m"
    fi
}

##
# Outputs string in a dynamic orange color (hilite variant).
#
# Uses a background behind white text to grab extra attention.
#
# @param string ${1} String.
#
# @output string Colorized string.
# @return int `0` (true) on success.
##
function chalk-warning-hilite() {
    local str="${1:-}"

    if ! is-term-256-colors; then
        echo "${str}"
    else
        echo -e "\e[38;5;255m\e[48;5;130m\e[1m${str}\e[0m\e[49m\e[39m"
    fi
}

##
# Outputs string in a dynamic red color.
#
# @param string ${1} String.
#
# @output string Colorized string.
# @return int `0` (true) on success.
##
function chalk-danger() {
    local str="${1:-}"

    if ! is-term-256-colors; then
        echo "${str}"
    elif is-term-on-dark-bg; then
        echo -e "\e[38;5;203m\e[1m${str}\e[0m\e[39m"
    else
        echo -e "\e[38;5;124m\e[1m${str}\e[0m\e[39m"
    fi
}

##
# Outputs string in a dynamic red color (hilite variant).
#
# Uses a background behind white text to grab extra attention.
#
# @param string ${1} String.
#
# @output string Colorized string.
# @return int `0` (true) on success.
##
function chalk-danger-hilite() {
    local str="${1:-}"

    if ! is-term-256-colors; then
        echo "${str}"
    else
        echo -e "\e[38;5;255m\e[48;5;124m\e[1m${str}\e[0m\e[49m\e[39m"
    fi
}

##
# Outputs string in a dynamic green color.
#
# @param string ${1} String.
#
# @output string Colorized string.
# @return int `0` (true) on success.
##
function chalk-success() {
    local str="${1:-}"

    if ! is-term-256-colors; then
        echo "${str}"
    elif is-term-on-dark-bg; then
        echo -e "\e[38;5;41m\e[1m${str}\e[0m\e[39m"
    else
        echo -e "\e[38;5;28m\e[1m${str}\e[0m\e[39m"
    fi
}

##
# Outputs string in a dynamic green color (hilite variant).
#
# Uses a background behind white text to grab extra attention.
#
# @param string ${1} String.
#
# @output string Colorized string.
# @return int `0` (true) on success.
##
function chalk-success-hilite() {
    local str="${1:-}"

    if ! is-term-256-colors; then
        echo "${str}"
    else
        echo -e "\e[38;5;255m\e[48;5;28m\e[1m${str}\e[0m\e[49m\e[39m"
    fi
}
