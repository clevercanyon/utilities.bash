#!/usr/bin/env bash
# shellcheck disable=SC2034
# shellcheck disable=SC2181
##
# Utility function(s).
##

##
# Parses CLI options.
#
# @param string ${1}   CMD name; e.g., `my-command`.

# @param string ${2}   Short option letters passed through to `:getopt`.
#                      Example: `a:bcd:`. The `:` suffix indicates that an option value must be given.
#                      In this example, `a` and `d` require values. `b` and `c` are simply flags and not accept values.
#
# @param string ${3}   Comma-delimited long options passed through to `:getopt`.
#                      Example: `ack:,batch,csv,delimiter:`. The `:` suffix indicates that an option value must be given.
#                      In this example, `ack` and `delimiter` require values. `batch` and `csv` are simply flags and not accept values.
#
# @param string ${4}   Options array variable name, by reference.
#                      Use `declare -A opts` in your script, then pass `opts` in position `{$4}`.
#
# @param string ${5}   Options list marker. Always pass `--` to delimit options.
#
# @param string ${@:6} Remaining options are those to parse.
#
# @output string Errors are output to `stderr` by `:getopt` when there are problems.
# @return int `0` (true) on success.
# @exit   int `1` on any failure.
##
function :parse-opts() {
    local cmd_name="${1:-}"
    local short="${2:-}"
    local long="${3:-}"
    local opts_ref="${4:-}"
    local opts_list_marker="${5:-}"
    declare -a opts_list=("${@:6}")

    if [[ -z "${cmd_name}" ]]; then
        :chalk-danger ':parse-opts: Missing `cmd_name`.' >&2 && exit 1
    elif [[ -z "${opts_ref}" ]]; then
        :chalk-danger ':parse-opts: Missing `opts_ref`.' >&2 && exit 1
    elif [[ "${opts_list_marker}" != -- ]]; then
        :chalk-danger ':parse-opts: Missing `opts_list_marker`.' >&2 && exit 1
    fi
    declare -n opts_by_ref="${opts_ref}"               # Associative options array by reference.
    local _positional_index=-1 _opt_name _opt_var_name # Initializes variables used in loop below.
    local getopt_opts                                  # Initializes options parsed by `:getopt`.

    getopt_opts="$(:getopt --name="${cmd_name}" --options "${short}" --longoptions "${long}" -- "${opts_list[@]}")"
    [[ "${?}" == 0 ]] || exit 1 # Guard in loose mode. Failed to parse options. Error output already provided by `:getopt`.

    eval set -- "${getopt_opts}" && while true; do
        if [[ -z "${1:-}" ]]; then
            shift 1 || true
            break # End of loop.

        elif [[ "${1}" == -- && "${_positional_index}" == -1 ]]; then
            _positional_index=0
            shift 1 || true

        elif [[ "${_positional_index}" -ge 0 ]]; then
            ((_positional_index++)) || true
            opts_by_ref[_"${_positional_index}"]="${1}"
            shift 1 || true

        else
            _opt_name="$(echo -n "${1}" | perl -0wpe 's/^-+//u')"
            _opt_var_name="$(echo -n "${_opt_name}" | perl -0wpe 's/[^a-z0-9]/_/uig')"

            if [[ "${#_opt_name}" -eq 1 && "${short}" =~ "${_opt_name}": ]]; then
                opts_by_ref["${_opt_var_name}"]="${2:-}"
                shift 2 || true

            elif [[ "${#_opt_name}" -gt 1 && "${long}" =~ "${_opt_name}": ]]; then
                opts_by_ref["${_opt_var_name}"]="${2:-}"
                shift 2 || true
            else
                opts_by_ref["${_opt_var_name}"]=true
                shift 1 || true
            fi
        fi
    done
}
