#!/bin/bash

export EDITOR=vim
export WORKON_HOME=$HOME/code/virtualenvs
export PROJECT_HOME=$HOME/code/repos

VWRAP="/usr/local/bin/virtualenvwrapper.sh"

if [ -f $VWRAP ]; then
	 source $VWRAP
	 export WORKON_HOME=$HOME/code/virtualenvs
	 export PROJECT_HOME=$HOME/code/repos
fi

alias ll="ls -l"

if [ "$TERM" != "linux" ]; then
	source ~/software/pureline/pureline ~/.pureline.conf
fi

