#!/bin/sh

while true; do

  # Clean up previously running apps, gracefully at first then harshly
  killall -TERM chromium-browser 2>/dev/null
  killall -TERM matchbox-window-manager 2>/dev/null
  sleep 2
  killall -9 chromium-browser 2>/dev/null
  killall -9 matchbox-window-manager 2>/dev/null

  # Clean out existing profile information
  rm -rf /home/pi/.cache
  rm -rf /home/pi/.config
  rm -rf /home/pi/.pki
  mkdir /home/pi/.config

  # Disable DPMS / Screen blanking
  xset -dpms
  xset s off
  xset s noblank
  
  # Hide the cursor (move it to the bottom-right, comment out if you want mouse interaction)
  xwit -root -warp $( cat /sys/module/*fb*/parameters/fbwidth ) $( cat /sys/module/*fb*/parameters/fbheight )

  ## Start the window manager (remove "-use_cursor no" if you actually want mouse interaction)
  matchbox-window-manager -use_titlebar no -use_cursor no &

  # Start the browser
  URL="https://www.dogsbody.com/" # In case the settings file doesn't exist
  test -f /home/pi/pi-display/settings.data && . /home/pi/pi-display/settings.data
  chromium-browser --check-for-update-interval=31536000 -app="${URL}"
done;
