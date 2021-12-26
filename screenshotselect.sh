#!/bin/sh
scrot -s -q 100 unknown.png ; xclip -selection c -t image/png < unknown.png ; rm unknown.png
