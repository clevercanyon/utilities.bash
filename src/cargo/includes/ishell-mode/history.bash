#!/usr/bin/env bash
##
# Utility include.
##

##
# History opts for interactive shell mode.
##
function :___ishell_history_closure() {
    ##
    # Sets history options.
    ##

    shopt -s lithist
    shopt -s histappend

    HISTSIZE=10000
    HISTFILESIZE=20000

    HISTCONTROL=erasedups:ignoreboth
    HISTIGNORE='exit:ls:bg:fg:history:clear'

} && :___ishell_history_closure && unset -f :___ishell_history_closure