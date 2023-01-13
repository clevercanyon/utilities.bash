#!/usr/bin/env bash
##
# Utilities.
##

##
# Loads utilities.
##
___dirname="$(cd "$(dirname "${BASH_SOURCE[0]}")" &> /dev/null && pwd)"
[[ -d "${___dirname}" ]] || { echo -e "\x01\e[31m\x02"'Missing `___dirname`.'"\x01\e[0m\x02" >&2 && exit 1; }

. "${___dirname}"/includes/strict-mode.bash

for ___file in "${___dirname}"/functions/**.bash; do
    [[ -f "${___file}" ]] && . "${___file}"
done && unset ___dirname && unset ___file # Housekeeping.
