#!/usr/bin/env bash
##
# Utilities.
##

##
# Loads utilities.
##
__dirname="$(cd "$(dirname "${BASH_SOURCE[0]}")" &> /dev/null && pwd)"
[[ -d "${__dirname}" ]] || { echo -e "\e[0;31m"'Missing `__dirname`.'"\e[0m" >&2 && exit 1; }

. "${__dirname}"/includes/strict-mode.bash
. "${__dirname}"/includes/shell-options.bash

for ___file in "${__dirname}"/functions/**.bash; do
    [[ -f "${___file}" ]] && . "${___file}"
done
unset ___file # Housekeeping.
