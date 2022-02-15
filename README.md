# Create a Raspberry Pi Display on Raspberry Pi OS Debian using Bullseye and the Firefox browser

We use this for [our office Warboard](https://www.dogsbody.com/blog/the-warboard/) which is not only locked down to certain IP addresses but also uses the latest SSL protocols and ciphers. 

This install also downloads and compiles the latest [cec-client](https://github.com/Pulse-Eight/libcec) that allows you to turn the TV on and off each day via cron.

Over the years we have tried many browsers but is currently FireFox (See [#History](#History))

## Installation ##

1. Install the latest Raspberry Pi OS Lite and enable SSH (Last tested with 2022-01-28-raspios-bullseye-armhf-lite.zip)

   Use the [Raspberry Pi Imager](https://www.raspberrypi.com/software/) and enable SSH in the settings

   ...or...

   Grab the latest image from  https://downloads.raspberrypi.org/raspios_lite_armhf/images and `touch /boot/ssh` to enable SSH before putting the card in the Pi.

2. Login to the Raspberry Pi (SSH as pi user) and update everything...

   `sudo apt update && sudo apt -y dist-upgrade`

3. Install git and this repo...
   ```
   sudo apt -y install git
   git clone https://github.com/dogsbodytech/pi-display.git /home/pi/pi-display
   ```
4. Run the setup script and reboot!

   ```
   sudo bash /home/pi/pi-display/install.sh
   sudo reboot
   ```

## Usage ##
- Set the URL for the display by adding it to a settings.data file...

   `echo "URL=https://www.dogsbody.com/" > /home/pi/pi-display/settings.data`

- To reload the URL or restart the displayboard due to a crash just kill Firefox

   `pkill -TERM  firefox-esr`

- Setup cron job to turn the TV on and off each day. There us an example in the cron.example file.

   `sudo cp /home/pi/pi-display/cron.example /etc/cron.d/displayboard`

## History ##
This project started by using the epiphany browser. We chose this as the version of chromium on Raspbian wasn't up to date and didn't support the latest security protocols.

The Raspberry Pi team then [released PIXEL](https://www.raspberrypi.org/blog/introducing-pixel/) which included a much more up to date version of the Chromium browser however a few years later we noticed the display flashing as the page loads.

We are now using the latest version of Firefox which has fixed both of these issues perfectly.

## Sources ##
- http://blogs.wcode.org/2013/09/howto-boot-your-raspberry-pi-into-a-fullscreen-browser-kiosk/
- https://www.danpurdy.co.uk/web-development/raspberry-pi-kiosk-screen-tutorial/
- https://drgeoffathome.wordpress.com/2014/08/08/cec-adventures-on-the-raspberry-pi/
- https://github.com/elalemanyo/raspberry-pi-kiosk-screen
