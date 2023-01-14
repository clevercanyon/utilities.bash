#!/usr/bin/env bash
##
# Utility include.
##

##
# Strict mode.
# Note: All modes inherit strict mode.
# The settings below establish a baseline.
##
function :___strict_mode_closure() {
    ##
    # Strict options.
    ##

    set -o nounset
    set -o errexit
    set -o errtrace
    set -o pipefail

    trap ':stack-trace "${BASH_COMMAND}" "${?}"' ERR

    ##
    # Other baseline options.
    ##

    shopt -s extglob
    shopt -s dotglob
    shopt -s globstar
    shopt -s nullglob

} && :___strict_mode_closure && unset -f :___strict_mode_closure
