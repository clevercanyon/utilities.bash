#!/usr/bin/env bash
##
# Utility function(s).
##

##
# Gets current UTC timestamp.
#
# @output string Current UTC timestamp.
# @return int `0` (true) on success.
##
function current-time() {
	date --utc +'%s';
}
