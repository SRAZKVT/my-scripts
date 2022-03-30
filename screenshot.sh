#!/bin/sh
if [ $XDG_SESSION_TYPE = 'x11' ]; then
	scrot -q 100 unknown.png
	xclip -selection c -t image/png < unknown.png
elif [ $XDG_SESSION_TYPE = 'wayland' ] || [ $XDG_SESSION_TYPE = 'xwayland' ]; then
	### TODO: use screenshot utility working under wayland
	printf "this script yet isn't supporting wayland\n"
	exit 1
	wl-copy < unknown.png
fi
rm unknown.png
