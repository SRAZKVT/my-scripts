#!/bin/sh
scrot -a $(slop -f '%x,%y,%w,%h') -q 100 unknown.png ; xclip -selection c -t image/png < unknown.png ; rm unknown.png
