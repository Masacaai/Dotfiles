#!/bin/bash

export GOOGLE_ARGS='["--count", 50]'&& 
export ROFI_SEARCH='googler' && 
export ROFI_SEARCH_CMD='qutebrowser $URL'

rofi -modi blocks -blocks-wrap /usr/bin/rofi-search -show blocks -kb-custom-1 'Control+y' -theme ~/.config/rofi/configs.rasi
