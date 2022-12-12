#!/usr/bin/env bash
##
# Utilities.
##

##
# Loads utilities.
##
___cwd="$(pwd)"; # Remember CWD.

if ! cd "$(dirname "${BASH_SOURCE[0]}")"; then
	echo -e "\e[38;5;255m\e[48;5;124m\e[1mFailed to CD into: ${BASH_SOURCE[0]}\e[0m\e[49m\e[39m";
	exit 1; # Exit w/ error status.
fi;
. ./includes/strict-mode.bash;
. ./includes/shell-options.bash;

for ___file in ./functions/**.bash; do
	# shellcheck source=functions/**.bash;
	[[ -f "${___file}" ]] && . "${___file}";
done;
cd "${___cwd}" || exit 1;    # Restore.
unset ___cwd; unset ___file; # Housekeeping.
