#!/usr/bin/env bash
##
# Utility include.
##

##
# Keychain for interactive shell mode.
##

function :___ishell_keychain_closure___() {
    ##
    # Loads apple keychain on macOS.
    ##

    if [[ -x /usr/bin/ssh-add ]]; then
        /usr/bin/ssh-add --apple-load-keychain &> /dev/null ||
            { :chalk-danger ':___ishell_keychain_closure___: Missing keychain!' >&2 && return 1; }
    fi

} && :___ishell_keychain_closure___
