#!/usr/bin/env bash
##
# Utility function(s).
##

##
# Traps errors for debugging.
#
# @param  int ${1} Last command’s name/args.
# @param  int ${2} Last command’s status code.
#
# @output string Diagnostic report.
# @exit   int    Last command’s status code.
#
# @see https://o5p.me/8eGn9c
##
function :stack-trace() {
    set +o xtrace # Don't trace this ↓.

    # Checks global set by this function.
    if [[ -n "${___stack_traced___:-}" &&
        "${___stack_traced___}" == true ]]; then
        return 0 # One time only.
    fi
    ___stack_traced___=true # Tracing now.

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

    echo -e "\x01\e[30m\x02${diagnostic_report}\x01\e[0m\x02" >&2 # Lines from above.
    exit "${last_command_status_code}"                            # Preserves exit status.
}
