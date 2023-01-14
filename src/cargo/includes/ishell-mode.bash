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
function :___ishell_mode_closure() {
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

} && :___ishell_mode_closure && unset -f :___ishell_mode_closure
