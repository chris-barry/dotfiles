#!/bin/sh
eval $(gpg-agent --daemon --enable-ssh-support --write-env-file ${HOME}/.gnupg/gpg-agent.env)&

# No trackpad tapping
/usr/bin/synclient MaxTapTime=0

# Disable system beep
xset -b

# Mute by default
amixer -q set Master mute
amixer -q set Master 0

# Autolock after 10 minutes
xautolock -time 10 -locker slock -corners ----&

# Libnotify
dunst&

# Set background
feh --bg-scale ~/Pictures/Wallpapers/current&

# Music
mpd&

# Status bar
dwmstatus&

# Who needs f.lux?
redshift -c ~/.redshift&

xmodmap ~/.xmodmaprc&

exec /usr/bin/dwm
