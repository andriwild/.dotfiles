#!/bin/sh

syndaemon -i 1.0 -t -K -R -d
setxkbmap -option "ctrl:nocaps"
xcape -e 'Super_L=Alt_L|F1;Control_L=Escape'
