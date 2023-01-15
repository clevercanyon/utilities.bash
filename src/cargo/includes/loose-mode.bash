#!/usr/bin/env bash
##
# Utility include.
##

##
# Loose mode.
# Note: All modes inherit strict mode.
# Here we adjust and/or add to strict mode.
##

trap - ERR # In global scope.

function :___loose_mode_closure___() {
    ##
    # Reverts all strict options.
    # i.e., `+` indicates reverse/disable.
    ##

    set +o nounset
    set +o errexit
    set +o errtrace
    set +o pipefail

} && :___loose_mode_closure___
