gsettings set org.gnome.shell.extensions.dash-to-dock show-apps-at-top true
gsettings set org.gnome.shell.extensions.dash-to-dock dock-position 'BOTTOM'


################# SCREEN SAVER ########################
gsettings set org.gnome.desktop.screensaver lock-enabled true
gsettings get org.gnome.desktop.screensaver lock-enabled

gsettings set org.gnome.desktop.session idle-delay 1200
gsettings set org.gnome.desktop.screensaver lock-delay 1200

gsettings get org.gnome.desktop.session idle-delay
gsettings get org.gnome.desktop.screensaver lock-delay

################# KEY BINDING ########################


######## TYPING #######
gsettings set org.gnome.desktop.input-sources per-window true
gsettings set org.gnome.desktop.wm.keybindings switch-input-source "['<Alt>z']"
gsettings set org.gnome.desktop.wm.keybindings switch-input-source-backward "['<Shift><Alt>z']"


######## LAUNCHER #######
# Home folder (Super+E)
gsettings set org.gnome.settings-daemon.plugins.media-keys home "['<Super>e']"
# Launch terminal (Super+R)
gsettings set org.gnome.settings-daemon.plugins.media-keys terminal "['<Super>r']"
# Search (Super+Space)
gsettings set org.gnome.settings-daemon.plugins.media-keys search "['<Super>space']"
# Settings (Super+X)
gsettings set org.gnome.settings-daemon.plugins.media-keys control-center "['<Super>x']"

# customized
gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings \
"['/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/']"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ \
name 'Sublime Text'
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ \
command 'subl'
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ \
binding '<Super>t'


####### NAVIGATION ######
# windows+number will not switch app anymore
for i in {1..9}; do
  gsettings set org.gnome.shell.keybindings "switch-to-application-$i" "[]"
done
# switch to workspace
for i in {1..5}; do
  gsettings set org.gnome.desktop.wm.keybindings "switch-to-workspace-$i" "['<Super>$i']"
done
# move window to workspace
for i in {1..5}; do
  gsettings set org.gnome.desktop.wm.keybindings "move-to-workspace-$i" "['<Shift><Super>$i']"
done
# alt tab now cycle through windows, not apps
gsettings set org.gnome.desktop.wm.keybindings switch-applications "[]"
gsettings set org.gnome.desktop.wm.keybindings switch-windows "['<Alt>Tab']"


####### SCREENSHOT ######
gsettings set org.gnome.shell.keybindings show-screenshot-ui "['<Ctrl><Alt>a']"


####### WINDOWS #########
# no more tiling
gsettings set org.gnome.mutter edge-tiling false
gnome-extensions disable tiling-assistant@ubuntu.com
gsettings set org.gnome.shell.extensions.tiling-assistant tile-left-half "[]"
gsettings set org.gnome.shell.extensions.tiling-assistant tile-right-half "[]"

# Maximize window vertically
gsettings set org.gnome.desktop.wm.keybindings maximize-vertically "['<Super>Up']"
# Toggle fullscreen mode
gsettings set org.gnome.desktop.wm.keybindings toggle-fullscreen "['F11']"


gsettings set org.gnome.settings-daemon.plugins.media-keys logout "['<Ctrl><Shift><Super>F11']"
gsettings set org.gnome.settings-daemon.plugins.media-keys suspend "['<Ctrl><Super>F11']"


###### MEDIA PLAYER #####

# Launch media player
gsettings set org.gnome.settings-daemon.plugins.media-keys media "['<Super>m']"

# Next track
gsettings set org.gnome.settings-daemon.plugins.media-keys next "['<Super>bracketright']"

# Previous track
gsettings set org.gnome.settings-daemon.plugins.media-keys previous "['<Super>bracketleft']"

# Play/Pause
gsettings set org.gnome.settings-daemon.plugins.media-keys play "['<Super>BackSpace']"

# Stop playback
gsettings set org.gnome.settings-daemon.plugins.media-keys stop "['<Super>9']"

# Volume up
gsettings set org.gnome.settings-daemon.plugins.media-keys volume-up "['<Super>equal']"

# Volume down
gsettings set org.gnome.settings-daemon.plugins.media-keys volume-down "['<Super>minus']"

# Disabled shortcuts
gsettings set org.gnome.settings-daemon.plugins.media-keys pause "[]"
gsettings set org.gnome.settings-daemon.plugins.media-keys mic-mute "[]"
gsettings set org.gnome.settings-daemon.plugins.media-keys volume-mute "[]"


##### NOTIFICATION ######
# Show the notification list: Super+N
gsettings set org.gnome.shell.keybindings toggle-message-tray "['<Super>n']"

# Focus the active notification: Disabled
gsettings set org.gnome.shell.keybindings focus-active-notification "@as []"

# open quick setting panel
gsettings set org.gnome.shell.keybindings toggle-quick-settings "['<Super>g']"






