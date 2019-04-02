#!/bin/bash

if [ "$TERM" != "linux" ]; then
	source ~/software/pureline/pureline ~/.pureline.conf
fi

if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
	. /etc/bash_completion
fi

alias ll='ls -l --color=auto'
alias pwgen='pwgen -B 12'

ANDROID="$HOME/software/android-sdk"
export PATH="$PATH:$ANDROID/platform-tools:$ANDROID/tools"
export HARVEST_API_TOKEN="1193208.pt.41BcMtOUlYydnpuG_0DIcIRJDPGWy8h8jBRlIiI5ZS5YWj7BDfZdJ2QGRU7iojRcpjfWnaMeYbMK4qJK7FQ7qg"
export HARVEST_API_ID="523501"
# to get GPG to use the right tty (?)
export GPG_TTY=$(tty)
# force git-secret to use gpg2 instead of the default gpg
export SECRETS_GPG_COMMAND=gpg2

if [ -n "$(type -t thefuck)" ]; then
	eval "$(thefuck --alias)"
fi

if [ -n "$(type -t go)" ]; then
	export GOPATH="$HOME/go"
	export PATH="$PATH:$GOPATH/bin"
fi

if [ -n "$(type -t virsh)" ]; then
	export LIBVIRT_DEFAULT_URI="qemu:///system"
fi

VIRTUALENVWRAPPER_PYTHON=$(which python3)
if [ -f "/usr/share/virtualenvwrapper/virtualenvwrapper.sh" ]; then
	source /usr/share/virtualenvwrapper/virtualenvwrapper.sh
elif [ -f "$HOME/.local/bin/virtualenvwrapper.sh" ] ; then
	# for installs from `pip install --user virtualenvwrapper`
	source "$HOME/.local/bin/virtualenvwrapper.sh"
fi

export BORG_PASSCOMMAND="pass show borgbackup"
export BORG_REPO="/mnt/backup/borg"

if [ -f "$HOME/software/password-store/src/completion/pass.bash-completion" ]; then
	source "$HOME/software/password-store/src/completion/pass.bash-completion"
fi

if [ $(type -t kubectl) ]; then
	eval $(kubectl completion bash)
fi

if [ -d "$HOME/.local/bin" ]; then
	# haskell
	export PATH="$PATH":"$HOME/.local/bin"
fi

if [ -d "$HOME/bin" ]; then
	# haskell
	export PATH="$PATH":"$HOME/bin"
fi

for gemdir in $HOME/.gem/ruby/*; do
	export PATH="$PATH:$gemdir/bin"
done

declare -r PYENV_DIR="$HOME/software/pyenv"
if [ -d "$PYENV_DIR" ]; then
	export PYENV_ROOT="$PYENV_DIR"
	[ -s "$PYENV_DIR/bin/pyenv" ] && eval "$($PYENV_DIR/bin/pyenv init -)"
fi

declare -r NVM_DIR="$HOME/software/nvm"
if [ -d "$NVM_DIR" ]; then
	[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
fi

