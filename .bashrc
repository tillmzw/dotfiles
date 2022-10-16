#!/bin/bash

if [ -n "$(type -t zsh)" ]; then
	echo "zsh available. Please consider switching."
fi

if [ "$TERM" != "linux" ]; then
	source ~/software/pureline/pureline ~/.pureline.conf
fi

if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
	. /etc/bash_completion
fi

alias ll='ls -l --color=auto'

export GPG_TTY=$(tty)
# force git-secret to use gpg2 instead of the default gpg
export SECRETS_GPG_COMMAND=gpg2
# Java + Wayland = </3
export _JAVA_AWT_WM_NONREPARENTING=1

if [ -n "$(type -t go)" ]; then
	export GOPATH="$HOME/go"
	export PATH="$PATH:$GOPATH/bin"
fi

if [ -n "$(type -t virsh)" ]; then
	export LIBVIRT_DEFAULT_URI="qemu:///system"
fi

if [ -d "$HOME/.local/bin" ]; then
	export PATH="$PATH":"$HOME/.local/bin"
fi

declare -r NVM_DIR="$HOME/software/nvm"
if [ -d "$NVM_DIR" ]; then
	[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
fi

# https://stackoverflow.com/a/18915067
SSH_ENV="$HOME/.ssh/environment"

function start_agent {
	echo "Initialising new SSH agent..."
	/usr/bin/ssh-agent | sed 's/^echo/#echo/' > "${SSH_ENV}"
	echo succeeded
	chmod 600 "${SSH_ENV}"
	. "${SSH_ENV}" > /dev/null
	#/usr/bin/ssh-add;
}
# Source SSH settings, if applicable
if [ -f "${SSH_ENV}" ]; then
	. "${SSH_ENV}" > /dev/null
	#ps ${SSH_AGENT_PID} doesn't work under cywgin
	ps -ef | grep ${SSH_AGENT_PID} | grep ssh-agent$ > /dev/null || {
		start_agent;
	}
else
	start_agent;
fi

if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
	# SSH session, do not load wal
	# : is a null command
	:
elif [ -n "$(type -t wal)" ]; then
	(cat ~/.cache/wal/sequences &)
fi

if [ -d /home/linuxbrew/.linuxbrew/bin ]; then
	export PATH=$PATH:/home/linuxbrew/.linuxbrew/bin
fi 

if [ -d $HOME/.krew ]; then
	export PATH="$HOME/.krew/bin:$PATH"
fi

