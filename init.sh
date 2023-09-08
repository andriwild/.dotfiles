#!/bin/sh

# map caps-lock to esc
setxkbmap -option "ctrl:nocaps"

# make sure process is not alerady running
function run {
  if ! pgrep $1 ;
  then
    $@&
  fi
}

run "syndaemon -i 1.0 -t -K -R -d"
run "xcape -e 'Super_L=Alt_L|F1;Control_L=Escape'"
run "numlockx on"
run "nm-applet"
run "xfce4-power-manager"

