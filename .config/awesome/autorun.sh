#!/usr/bin/env bash

function run {
  if ! pgrep -f $1 ;
  then
    $@&
  fi
}

run /usr/bin/lxpolkit
run xfce4-power-manager
run kdeconnect-indicator
run udiskie --tray
run mpris-proxy
run picom -b -f --experimental-backends
run caffeine
run clipit
run xset s 300 5
run xss-lock -n -l -- dm-tool switch-to-greeter 
