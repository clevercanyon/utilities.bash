#!/usr/bin/env bash
# shellcheck disable=SC2034
##
# Utility include.
##

##
# Interactive shell mode.
# Note: All modes inherit strict mode.
# Here we adjust and/or add to strict mode.
##
function :___ishell_mode_closure___() {
    ##
    # Mostly reverts strict options.
    # i.e., `+` indicates reverse/disable.
    ##

    set +o nounset
    set +o errexit
    set +o errtrace
    set -o pipefail

    trap - ERR

    ##
    # Sets default umask.
    ##

    umask 0022 # 755 & 644.

    ##
    # Sets window options.
    ##

    shopt -s checkwinsize

    ##
    # Gets this file’s directory.
    ##

    local __dirname="$(cd "$(dirname "${BASH_SOURCE[0]}")" &> /dev/null && pwd)"
    [[ -d "${__dirname}" ]] || { :chalk-danger ':___ishell_mode_closure___: Missing `__dirname`!' >&2 && return 1; }

    ##
    # Sources the environment vars include file.
    ##

    . "${__dirname}"/includes/ishell-mode/env-vars.bash ||
        { :chalk-danger ':___ishell_mode_closure___: Missing environment vars!' >&2 && return 1; }

} && :___ishell_mode_closure___
