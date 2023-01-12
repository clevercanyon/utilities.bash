#!/usr/bin/env bash
##
# Utilities.
##

##
# Loads utilities.
##
___dirname="$(cd "$(dirname "${BASH_SOURCE[0]}")" &> /dev/null && pwd)"
[[ -d "${___dirname}" ]] || { echo -e "\e[31m"'Missing `___dirname`.'"\e[0m" >&2 && exit 1; }

. "${___dirname}"/includes/strict-mode.bash
. "${___dirname}"/includes/shell-options.bash

for ___file in "${___dirname}"/functions/**.bash; do
    [[ -f "${___file}" ]] && . "${___file}"
done && unset ___dirname && unset ___file # Housekeeping.
