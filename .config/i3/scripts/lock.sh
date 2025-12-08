#!/bin/bash
# ===============================================================
# config script for displaying i3 lock screen
# ===============================================================

# i3lock --date-color=ffffffff --time-color=ffffffff -n -k --indicator --radius 120 --ring-width 15 -i "$lock_bg" -f -F
lock_bg="/home/john/.local/share/wallpapers/berserk1.png"

#===============================================================
# fetch background colors
#===============================================================
RING_COLOR=$(sed -n '1p' ~/.cache/wal/colors)   # Primary color
KEYHL_COLOR=$(sed -n '2p' ~/.cache/wal/colors) # Highlight color
BSHL_COLOR=$(sed -n '3p' ~/.cache/wal/colors)  # Secondary color
SEPARATOR_COLOR=$(sed -n '4p' ~/.cache/wal/colors)
RINGVER_COLOR=$(sed -n '6p' ~/.cache/wal/colors)
RINGWRONG_COLOR=$(sed -n '7p' ~/.cache/wal/colors)
    #--ring-color=$RING_COLOR \

# ===============================================================
# execute i3lock command with given parameters 
# ===============================================================
i3lock \
    -n \
    -k \
    --indicator \
    --date-color=ffffff \
    --date-str="%A, %m %Y" \
    --time-color=ffffff \
    --image=$lock_bg \
    --ring-color=880808 \
    --keyhl-color=$KEYHL_COLOR \
    --bshl-color=$BSHL_COLOR \
    --separator-color=$SEPARATOR_COLOR \
    --ringver-color=$RINGVER_COLOR \
    --ringwrong-color=$RINGWRONG_COLOR \
    --radius 120 \
    --ring-width 20 \
    -f \
    -e \
    -F

# ===============================================================
# tweak appearance of i3lock
# ===============================================================
appearance="i3lock \
    --image=$lock_bg \
    --ring-color=$RING_COLOR \
    --keyhl-color=$KEYHL_COLOR \
    --bshl-color=$BSHL_COLOR \
    --separator-color=$SEPARATOR_COLOR \
    --ringver-color=$RINGVER_COLOR \
    --ringwrong-color=$RINGWRONG_COLOR"


# ===============================================================
# auto lock the screen
# ===============================================================
#xautolock -detectsleep -time 3 -locker \ $appearance 




