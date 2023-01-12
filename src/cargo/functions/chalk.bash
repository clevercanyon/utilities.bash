#!/usr/bin/env bash
##
# Utility function(s).
##

##
# Default + 16 most basic named colorizers.
# Actual colors vary based on terminal configuration.
##

##
# Colorizes a string in default color.
#
# @param string ${1} String.
#
# @output string Colorized string.
# @return int `0` (true) on success.
##
function :chalk-default() {
    local str="${1:-}"
    echo -ne "\e[39m${str}\e[0m"
}

##
# Colorizes a string in dark gray color.
#
# @param string ${1} String.
#
# @output string Colorized string.
# @return int `0` (true) on success.
##
function :chalk-gray() {
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
function :chalk-black() {
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
function :chalk-red() {
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
function :chalk-green() {
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
function :chalk-yellow() {
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
function :chalk-blue() {
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
function :chalk-magenta() {
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
function :chalk-cyan() {
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
function :chalk-light-gray() {
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
function :chalk-light-red() {
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
function :chalk-light-green() {
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
function :chalk-light-yellow() {
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
function :chalk-light-blue() {
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
function :chalk-light-magenta() {
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
function :chalk-light-cyan() {
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
function :chalk-white() {
    local str="${1:-}"
    echo -ne "\e[97m${str}\e[0m"
}

##
# Named output utilities following Bootstrap convention.
# Colors are explicit, but adapt to light|dark backgrounds.
##

##
# Outputs a new line.
#
# @output string New line.
# @return int `0` (true) on success.
##
function :chalk-new-line() { echo; }

##
# Outputs a horizontal line.
#
# @output string Horizontal line.
# @return int `0` (true) on success.
##
function :chalk-horiz-line {
    local color="${1:-}"
    local line='----------------------------------------------------------------------------------------------------'

    if [[ -n "${color}" ]]; then
        echo -e "$(:chalk-"${color}" "${line}")"
    else
        echo -e "${line}"
    fi
}

##
# Outputs a string in default color.
#
# @param string ${1} String.
#
# @output string Colorized string.
# @return int `0` (true) on success.
##
function :chalk-output() {
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
function :chalk-heading() {
    local str="${1:-}"

    if ! :is-term-256-colors; then
        echo -e "${str}"
    elif :is-term-on-dark-bg; then
        echo -e "\e[38;5;212m\e[1m${str}\e[0m"
    else
        echo -e "\e[38;5;132m\e[1m${str}\e[0m"
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
function :chalk-log() {
    local str="${1:-}"

    if ! :is-term-256-colors; then
        echo -e "${str}"
    elif :is-term-on-dark-bg; then
        echo -e "\e[38;5;255m\e[2m${str}\e[0m"
    else
        echo -e "\e[38;5;232m\e[2m${str}\e[0m"
    fi
}

##
# Outputs string in a dynamic blue color.
#
# @param string ${1} String.
#
# @output string Colorized string.
# @return int `0` (true) on success.
##
function :chalk-info() {
    local str="${1:-}"

    if ! :is-term-256-colors; then
        echo -e "${str}"
    elif :is-term-on-dark-bg; then
        echo -e "\e[38;5;39m\e[1m${str}\e[0m"
    else
        echo -e "\e[38;5;26m\e[1m${str}\e[0m"
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
function :chalk-info-hilite() {
    local str="${1:-}"

    if ! :is-term-256-colors; then
        echo -e "${str}"
    else
        echo -e "\e[38;5;255m\e[48;5;26m\e[1m${str}\e[0m"
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
function :chalk-warning() {
    local str="${1:-}"

    if ! :is-term-256-colors; then
        echo -e "${str}"
    elif :is-term-on-dark-bg; then
        echo -e "\e[38;5;214m\e[1m${str}\e[0m"
    else
        echo -e "\e[38;5;130m\e[1m${str}\e[0m"
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
function :chalk-warning-hilite() {
    local str="${1:-}"

    if ! :is-term-256-colors; then
        echo -e "${str}"
    else
        echo -e "\e[38;5;255m\e[48;5;130m\e[1m${str}\e[0m"
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
function :chalk-danger() {
    local str="${1:-}"

    if ! :is-term-256-colors; then
        echo -e "${str}"
    elif :is-term-on-dark-bg; then
        echo -e "\e[38;5;203m\e[1m${str}\e[0m"
    else
        echo -e "\e[38;5;124m\e[1m${str}\e[0m"
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
function :chalk-danger-hilite() {
    local str="${1:-}"

    if ! :is-term-256-colors; then
        echo -e "${str}"
    else
        echo -e "\e[38;5;255m\e[48;5;124m\e[1m${str}\e[0m"
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
function :chalk-success() {
    local str="${1:-}"

    if ! :is-term-256-colors; then
        echo -e "${str}"
    elif :is-term-on-dark-bg; then
        echo -e "\e[38;5;41m\e[1m${str}\e[0m"
    else
        echo -e "\e[38;5;28m\e[1m${str}\e[0m"
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
function :chalk-success-hilite() {
    local str="${1:-}"

    if ! :is-term-256-colors; then
        echo -e "${str}"
    else
        echo -e "\e[38;5;255m\e[48;5;28m\e[1m${str}\e[0m"
    fi
}
