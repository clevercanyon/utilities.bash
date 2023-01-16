#!/usr/bin/env bash
##
# Utility include.
##

##
# Loads interactive shell mode.
##

function :___ishell_mode_closure___() {
    ##
    # Sets options.
    ##

    set -o pipefail

    ##
    # Sets default umask.
    ##

    umask 0022 # 755 & 644.

    ##
    # Sets window options.
    ##

    shopt -s checkwinsize

    ##
    # Gets this file’s directory.
    ##

    local __dirname="$(cd "$(dirname "${BASH_SOURCE[0]}")" &> /dev/null && pwd)"
    [[ -d "${__dirname}" ]] || { :chalk-danger ':___ishell_mode_closure___: Missing `__dirname`!' >&2 && return 1; }

    ##
    # Sources the environment vars include file.
    ##

    . "${__dirname}"/ishell-mode/env-vars.bash ||
        { :chalk-danger ':___ishell_mode_closure___: Missing environment vars!' >&2 && return 1; }

} && :___ishell_mode_closure___
