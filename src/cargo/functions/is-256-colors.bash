#!/usr/bin/env bash
##
# Utility function(s).
##

##
# Does terminal support 256 colors?
#
# @output void No output.
# @return int `0` (true) if terminal supports 256 colors.
##
function is-256-colors() {
	if [[ -n "${TERM:-}" && "${TERM,,}" =~ 256[_\-]?color ]]; then
		return 0;
	else
		return 1;
	fi;
}
