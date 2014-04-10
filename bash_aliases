#!/bin/bash

alias ll='ls -AlF'
alias la='ls -A'
alias l='ls -CF'
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
alias ..='cd ..'
# Check to make sure I actully want to do it
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
# Send to a pastebin site with, $ cat [file] |sprunge
#alias sprunge='curl -F \'sprunge=<-\' http://sprunge.us'
alias unmount='umount'

alias dhcp-kill='sudo dhcpcd -k; sudo dhcpcd'
alias todo='$EDITOR ~/todo.md'

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    
	alias grep='grep --line-number --with-filename --color=auto'
    alias fgrep='fgrep --line-number --with-filename --color=auto'
    alias egrep='egrep --line-number --with-filename --color=auto'
fi

to-clipboard() {
	cat $1 | xclip -selection clipboard
}

system-update() {
	if [ -x /usr/bin/pacman ]; then # Arch
		sudo pacman -Syu
	elif [ -x /usr/bin/apt-get ]; then # Debian
		sudo apt-get update && sudo apt-get upgrade
	elif [ -x /usr/sbin/softwareupdate ]; then # Apple
		sudo softwareupdate -i -a
		return
	else
		echo "No package manager found"
	fi
}

## Courtesy of https://wiki.archlinux.org/index.php/Bash#Extract
extract() {
	local c e i

	(($#)) || return

	for i; do
		c=''
		e=1

		if [[ ! -r $i ]]; then
			echo "$0: file is unreadable: \`$i'" >&2
			continue
		fi

		case $i in
			*.t@(gz|lz|xz|b@(2|z?(2))|a@(z|r?(.@(Z|bz?(2)|gz|lzma|xz)))))
				c='bsdtar xvf';;
			*.7z)  c='7z x';;
			*.Z)   c='uncompress';;
			*.bz2) c='bunzip2';;
			*.exe) c='cabextract';;
			*.gz)  c='gunzip';;
			*.rar) c='unrar x';;
			*.xz)  c='unxz';;
			*.zip) c='unzip';;
			*)     echo "$0: unrecognized file extension: \`$i'" >&2
				continue;;
		esac

		command $c "$i"
		e=$?
	done

	return $e
}

