# ~/.bashrc: executed by bash(1) for non-login shells.

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

set -o vi
export EDITOR=vim
export TZ="America/New_York"
export CLICOLOR=1
export PATH=$PATH:/home/chris/bin

# chris@arch:~$ |
PS1='\u@\h:\w$ '
PS2='> '
PS3='> '
PS4='+ '

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# Alias definitions.
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# Enable gpg-agent
if [ -f "${HOME}/.gnupg/gpg-agent.env" ]; then
	. ${HOME}/.gnupg/gpg-agent.env
	export GPG_AGENT_INFO
	export SSH_AUTH_SOCK
fi

GPG_TTY=$(tty)
export GPG_TTY
