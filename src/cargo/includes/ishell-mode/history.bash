#!/usr/bin/env bash
##
# Utility include.
##

##
# History opts for interactive shell mode.
##

function :___ishell_history_closure___() {
    ##
    # Sets history options.
    ##

    shopt -s lithist
    shopt -s histappend

    HISTSIZE=10000
    HISTFILESIZE=20000
    HISTFILE=~/.bash_history

    HISTCONTROL=erasedups:ignoreboth
    HISTIGNORE='exit:ls:bg:fg:history:clear:reset'

} && :___ishell_history_closure___
