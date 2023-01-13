#!/usr/bin/env bash
##
# Utility include.
##

##
# Sets up strict mode.
# @see https://o5p.me/pnUV7g
##
set -o nounset
set -o errexit
set -o errtrace
set -o pipefail

##
# Traps errors for debugging.
# @see https://o5p.me/8eGn9c
#
# @param int ${1} Exit status code.
##
function :stack-trace() {
    set +o xtrace

    # Checks global set by this function.
    if [[ true == "${___stack_traced:-}" ]]; then
        return 0 # One time only.
    fi
    ___stack_traced=true # Tracing now.

    local diagnostic_lines=()
    local diagnostic_report=''

    local last_command="${1:-}"
    local last_command_status_code="${2:-1}"

    # Dividing lines are exactly 75 bytes in length.
    diagnostic_lines+=('---------------------------------------------------------------------------')
    if [[ -n "${C10N_BASH_STACK_TRACE_SCRIPT_DESCRIPTION:-}" ]]; then
        diagnostic_lines+=("${C10N_BASH_STACK_TRACE_SCRIPT_DESCRIPTION}")
        diagnostic_lines+=('---------------------------------------------------------------------------')
    fi
    diagnostic_lines+=('Error in '"${BASH_SOURCE[1]}"':'"${BASH_LINENO[0]}")
    diagnostic_lines+=('`'"${last_command}"'` exited with status `'"${last_command_status_code}"'`.')

    if [[ ${#FUNCNAME[@]} -gt 2 ]]; then
        diagnostic_lines+=('Stack Trace:')

        for ((_i = 1; _i < ${#FUNCNAME[@]} - 1; _i++)); do
            diagnostic_lines+=(" ${_i}: ${BASH_SOURCE[${_i} + 1]}:${BASH_LINENO[${_i}]} ${FUNCNAME[${_i}]}(...)")
        done
    fi
    diagnostic_lines+=('Exiting with status `'"${last_command_status_code}"'`.')
    diagnostic_report="$(IFS=$'\n' && echo "${diagnostic_lines[*]}")"

    echo -e "\x01\e[90m\x02${diagnostic_report}\x01\e[0m\x02" >&2 # Lines from above.
    exit "${last_command_status_code}"                            # Preserves exit status.

} && trap ':stack-trace "${BASH_COMMAND}" "${?}"' ERR
