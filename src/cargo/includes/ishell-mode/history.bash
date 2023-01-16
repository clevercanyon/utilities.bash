#!/usr/bin/env bash
##
# Utility include.
##

##
# History options for interactive shell mode.
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
    HISTIGNORE='passwd:cd:up:back:home:ls:lsa:lso:history:clear:reset:exit'

} && :___ishell_history_closure___
