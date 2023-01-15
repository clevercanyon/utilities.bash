#!/usr/bin/env bash
##
# Utility include.
##

##
# Loose mode.
# Note: All modes inherit strict mode.
# Here we adjust and/or add to strict mode.
##

##
# Untrap at top level global scope.
# Top level required for proper handling.
##

trap - ERR # Reverts.

##
# Runs loose mode closure.
# Not needing top level global scope.
##

function :___loose_mode_closure___() {
    ##
    # Reverts all strict options.
    # i.e., `+` indicates revert/disable.
    ##

    set +o nounset  # Reverts.
    set +o errexit  # Reverts.
    set +o errtrace # Reverts.
    set +o pipefail # Reverts.

} && :___loose_mode_closure___
