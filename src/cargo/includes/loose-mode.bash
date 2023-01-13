#!/usr/bin/env bash
##
# Utility include.
##

##
# Note: All modes inherit strict mode.
# Here we adjust and/or add to strict mode.
##

##
# Partially reverts strict mode; to loose mode.
# `+` indicates reverse; i.e., disable.
##

set +o nounset
set +o errexit
set +o errtrace
set +o pipefail
trap - ERR
