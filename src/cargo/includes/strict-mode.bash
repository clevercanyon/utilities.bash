#!/usr/bin/env bash
##
# Utility include.
##

##
# Strict mode.
# Note: All modes inherit strict mode.
# The settings below establish a baseline.
##

trap ':stack-trace "${BASH_COMMAND}" "${?}"' ERR # In global scope.

function :___strict_mode_closure___() {
    ##
    # Strict options.
    ##

    set -o nounset
    set -o errexit
    set -o errtrace
    set -o pipefail

    ##
    # Other baseline options.
    ##

    shopt -s extglob
    shopt -s dotglob
    shopt -s globstar
    shopt -s nullglob

} && :___strict_mode_closure___
