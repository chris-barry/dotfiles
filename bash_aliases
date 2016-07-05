#!/bin/bash
#
# bash_alises - GNU Bash aliases file.
#
# Author: Chris Barry <chris@barry.im>
#
# License: Public domain.

alias ll='ls -AlF'
alias la='ls -A'
alias l='ls -CF'
alias ..='cd ..'
# Check to make sure I actully want to do it
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
# Send to a pastebin site with, $ cat [file] |sprunge
#alias sprunge='curl -F \'sprunge=<-\' http://sprunge.us'
alias unmount='umount'
alias todo='$EDITOR -p ~/Documents/notes/todo.md ~/Documents/notes/done.md'

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    
	alias grep='grep --line-number --with-filename --color=auto'
    alias fgrep='fgrep --line-number --with-filename --color=auto'
    alias egrep='egrep --line-number --with-filename --color=auto'
fi

webshare() {
	if [ -x "$(which python3)" ]; then
		python3 -m http.server $1
	elif [ -x "$(which python2)" ]; then
		python2 -m SimpleHTTPServer $1
	else
		>&2 echo "It does not look like Python is installed."
	fi
}

to-clipboard() {
	cat $1 | xclip -selection clipboard
}

system-update() {
	if [ -x "$(which pacman)" ]; then
		sudo pacman -Syu;
	elif [ -x "$(which apt-get)" ]; then
		sudo apt update && sudo apt upgrade;
	elif [ -x "$(which softwareupdate)" ]; then
		sudo softwareupdate -i -a;
	else
		>&2 echo "No package manager found"
	fi
}

# Make a file into 'L' and 'O', corresponding to the binary of the file.
lulcryption() {
	xxd -b $1 | cut -b 10-62 | tr -d ' ' | tr -d '\n' | tr '0' 'O' | tr '1' 'L' > $2
}

# sshfs-unmount mount/
sshfs-unmount() {
       fusermount -u $1
}

# youtube-dl-music https://youtube.com/watch?v=xxx
youtube-dl-music() {
	youtube-dl --extract-audio --audio-format mp3 $1
}

work-vpn() {
	if [ ! -f ~/.csd.sh ]; then
		>&2 echo "csd.sh not found"
		return
	fi
	sudo openconnect --csd-wrapper ~/.csd.sh $1
}
