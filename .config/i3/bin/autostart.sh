#!/bin/env bash

export PATH="$HOME/.local/bin:$PATH"

# Restore wallpaper
variety --resume &

# Start keybindings daemon
pgrep -x sxhkd > /dev/null || sxhkd -c ~/.config/i3/sxhkd/sxhkdrc &

# polybar
$HOME/.config/i3/bin/launchbar.sh

# Fix cursor
xsetroot -cursor_name left_ptr

# kill if already running
killall -9 blueberry-tray picom dunst ksuperkey xidlehook alttab glava kdeconnect-indicator indicator-keylock xfce4-power-manager caffeine

# Start kdeconnect-indicator
sh -c 'sleep 15 && kdeconnect-indicator &'

# Start blueberry-tray
blueberry-tray &

# Start xidlehook for lock screen
xidlehook --not-when-fullscreen --not-when-audio --timer 600 'lock' '' &

# sets superkey
ksuperkey -e 'Super_L=Alt_L|F1' &
ksuperkey -e 'Super_R=Alt_L|F1' &

# Launch notification daemon
dunst -config $HOME/.config/i3/dunstrc &

# start compositor and power manager
xfce4-power-manager &

while pgrep -u $UID -x picom >/dev/null; do sleep 1; done
picom --config $HOME/.config/i3/picom.conf &

# start polkit
if [[ ! `pidof xfce-polkit` ]]; then
    /usr/lib/xfce-polkit/xfce-polkit &
fi

# change xfce4-terminal colorscheme
XFCE_TERM_PATH="$HOME/.config/xfce4/terminal"
cp "$XFCE_TERM_PATH"/colorschemes/tokyo-night "$XFCE_TERM_PATH"/terminalrc

# change cava colorscheme
CAVA_PATH="$HOME/.config/cava"
cp "$CAVA_PATH"/colorschemes/nord "$CAVA_PATH"/config

# Start emacs deamon
emacs -daemon &

# Start openrgb
pgrep -x openrgb > /dev/null || openrgb -p cyber.orp &

# Start Keylock indicator
indicator-keylock &

# Start caffeine
caffeine &

# Start window Switcher
def-alttab &

# Launch Conkeww
#sed -i "s/colors\/color-.*/colors\/color-nord.yuck\")/g" $HOME/.config/conkeww/eww.yuck
#eww --config $HOME/.config/conkeww/ open conkeww-main

# replace neovim colorscheme
#sed -i "s/theme =.*$/theme = \"nord\",/g" $HOME/.config/nvim/lua/custom/chadrc.lua

# Launch Conky
#conky -c $HOME/.config/conky/axyl.conkyrc
