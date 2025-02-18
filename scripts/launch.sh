#!/bin/sh
#  _____ _             _     _    _             _                
# /  ___| |           | |   | |  | |           | |               
# \ `--.| |_ __ _ _ __| |_  | |  | | __ _ _   _| |__   __ _ _ __ 
#  `--. \ __/ _` | '__| __| | |/\| |/ _` | | | | '_ \ / _` | '__|
# /\__/ / || (_| | |  | |_  \  /\  / (_| | |_| | |_) | (_| | |   
# \____/ \__\__,_|_|   \__|  \/  \/ \__,_|\__, |_.__/ \__,_|_|   
#                                          __/ |                 
#                                         |___/                  
#
# by nightcat
# ---------------------------------------------------------------

# ---------------------------------------------------------------
# Define the folder where Waybar configuration and style files are located
# ---------------------------------------------------------------
WAYBAR_FOLDER="$HOME/.config/waybar/"
CONFIG_PATH="$WAYBAR_FOLDER/config.jsonc"
STYLE_PATH="$WAYBAR_FOLDER/style.css"
# Space-separated string of files to watch
CONFIG_FILES="$CONFIG_PATH $STYLE_PATH"

# ---------------------------------------------------------------
# Infinite loop to monitor changes and restart Waybar
# ---------------------------------------------------------------
while true; do
    # Start Waybar in the background with specified config and style
    waybar --config $CONFIG_PATH --style $STYLE_PATH >$WAYBAR_FOLDER/.waybar.err 2>&1 &
    
    # Wait for changes in the configuration or style files
    inotifywait -e create,modify $CONFIG_FILES
    
    # Kill any running instances of media-player.py (if applicable)
    pkill -f media-player.py 2>/dev/null
    
    # Terminate the Waybar process
    killall waybar 2>/dev/null
done
