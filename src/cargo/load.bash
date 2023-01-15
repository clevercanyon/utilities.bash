#!/usr/bin/env bash
##
# Utilities.
##

##
# Includes at top level main context.
# Top level required for proper loading.
##

##
# Minimum required version.
##

___load_required_bash_version___='5.2.15'

##
# Gets this file’s directory.
##

___load_dirname___="$(cd "$(dirname "${BASH_SOURCE[0]}")" &> /dev/null && pwd)"
[[ -d "${___load_dirname___}" ]] || { echo ':load.bash: Missing `___load_dirname___`!' >&2 && return 1; }

##
# Checks bash version against minimum required version.
##

[[ -n "${BASH_VERSION:-}" && "$(printf '%s\n' "${BASH_VERSION}" "${___load_required_bash_version___}" | sort -rV | head -n1)" == "${BASH_VERSION}" ]] || {
    echo ':load.bash: Minimum required bash version is `'"${___load_required_bash_version___}"'`. Currently running `'"${BASH_VERSION:-}"'`.' >&2 && return 1
}

##
# Loads strict mode w/ default baseline.
##

. "${___load_dirname___}"/includes/strict-mode.bash || { echo ':load.bash: Missing strict mode!' >&2 && return 1; }

##
# Loads all utility functions.
##

for ___load_function_file___ in "${___load_dirname___}"/functions/**.bash; do
    [[ -f "${___load_function_file___}" ]] && . "${___load_function_file___}"
done

##
# Housekeeping.
##

unset ___load_dirname___
unset ___load_function_file___
unset ___load_required_bash_version___
