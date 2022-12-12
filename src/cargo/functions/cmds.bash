#!/usr/bin/env bash
##
# Utility function(s).
##

##
# Runs a command using `${PATH}`; ignoring functions.
#
# Takes `${PATH}` into consideration.
#
# @param string ${1} Command name.
# @param mixed ...${@} Variadic.
#
# @output mixed Based on command being run.
# @return int Exit status of command being run.
##
function ::() {
  if [[ "${1:-}" == cd || "${1:-}" == dirs ]]; then
    builtin "${@}";
  else
    command "${@}"; # <https://askubuntu.com/q/512770>
  fi;
};

##
# Runs a command using `${PATH}`; ignoring functions.
#
# Forces a system default `${PATH}` via `-p` option.
#
# @param string ${1} Command name.
# @param mixed ...${@} Variadic.
#
# @output mixed Based on command being run.
# @return int Exit status of command being run.
##
function :::() {
  if [[ "${1:-}" == cd || "${1:-}" == dirs ]]; then
    builtin "${@}";
  else
    command -p "${@}"; # <https://askubuntu.com/q/512770>
  fi;
};
