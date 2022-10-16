# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="avit"

zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
HIST_STAMPS="yyyy-mm-dd"

plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration
if [ -n "$(whence vim)" ]; then
	export EDITOR=vim
fi
export GPG_TTY=$(tty)
# force git-secret to use gpg2 instead of the default gpg
export SECRETS_GPG_COMMAND=gpg2
# Java + Wayland = </3
export _JAVA_AWT_WM_NONREPARENTING=1

if [ -n "$(whence go)" ]; then
	export GOPATH="$HOME/go"
	export PATH="$PATH:$GOPATH/bin"
fi

if [ -n "$(whence virsh)" ]; then
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
elif [ -n "$(whence wal)" ]; then
	(cat ~/.cache/wal/sequences &)
fi

if [ -d /home/linuxbrew/.linuxbrew/bin ]; then
	export PATH=$PATH:/home/linuxbrew/.linuxbrew/bin
fi 

if [ -d $HOME/.krew ]; then
	export PATH="$HOME/.krew/bin:$PATH"
fi

