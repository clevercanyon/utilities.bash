#!/usr/bin/env bash
##
# Utility include.
##

##
# Loose mode.
# Note: All modes inherit strict mode.
# Here we adjust and/or add to strict mode.
##
function :___loose_mode_closure() {
    ##
    # Partially reverts strict options.
    # i.e., `+` indicates reverse/disable.
    ##

    set +o nounset
    set +o errexit
    set +o errtrace
    set +o pipefail

    ##
    # Removes strict mode error trap.
    # We don't trap errors in loose mode.
    ##

    trap - ERR

} && :___loose_mode_closure && unset -f :___loose_mode_closure
