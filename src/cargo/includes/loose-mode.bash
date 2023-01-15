#!/usr/bin/env bash
##
# Utility include.
##

##
# Loose mode.
# Note: All modes inherit strict mode.
# Here we adjust and/or add to strict mode.
##
function :___loose_mode_closure___() {
    ##
    # Reverts all strict options.
    # i.e., `+` indicates reverse/disable.
    ##

    set +o nounset
    set +o errexit
    set +o errtrace
    set +o pipefail

    trap - ERR

} && :___loose_mode_closure___
