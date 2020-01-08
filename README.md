# Create a Raspberry Pi Display on Raspbian Debian using Buster and the Chromium browser

We use this for [our office Warboard](https://www.dogsbody.com/blog/the-warboard/) which is not only locked down to certain IP addresses but also uses the latest SSL protocols and ciphers. 

This install also downloads and compiles the latest [cec-client](https://github.com/Pulse-Eight/libcec) that allows you to turn the TV on and off each day via cron.

This repo used to use the epiphany browser as the stock chromium on Raspbian wasn't up to date and didn't used to support the latest security protocols.  Now the Raspberry Pi team have [released PIXEL](https://www.raspberrypi.org/blog/introducing-pixel/) which includes a *much* more up to date version of the Chromium browser so we have returned to that.

## Installation ##

1. Install the latest Raspbian Debian Buster Lite (Last tested with 2019-09-26-raspbian-buster-lite.zip)

   You can always grab the latest from  https://downloads.raspberrypi.org/raspbian_lite_latest

   touch /boot/ssh to enable SSH before putting the card in the Pi.

2. Login to the Raspberry Pi (SSH as pi user) and update everything...

   `sudo apt update && sudo apt -y dist-upgrade`

3. Run `sudo raspi-config` and...
   - Change User Password
   - Localisation Options - Change Timezone - Europe - London
   - Network Options - Hostname - displayboard
   - Boot Options - Wait for Network at Boot - Yes
   - Advanced Options - Memory Split - 256
   - Finish - No Reboot

4. Install git and this repo...
   ```
   sudo apt -y install git
   git clone https://github.com/dogsbodytech/pi-display.git /home/pi/pi-display
   ```
5. Run the setup script and reboot!

   ```
   sudo bash /home/pi/pi-display/install.sh
   sudo reboot
   ```

## Usage ##
- Set the URL for the display by adding it to a settings.data file...

   `echo "URL=https://www.dogsbody.com/" > /home/pi/pi-display/settings.data`

- To reload the URL or restart the displayboard due to a crash just kill Chromium

   `pkill -TERM  chromium`

- Setup cron job to turn the TV on and off each day. There us an example in the cron.example file.

   `sudo cp /home/pi/pi-display/cron.example /etc/cron.d/displayboard`

## ToDo ##
- It would be great if we could get all the `raspi-config` commands into the `install.sh` script as then the installation could be one hit :-)

## Sources ##
- http://blogs.wcode.org/2013/09/howto-boot-your-raspberry-pi-into-a-fullscreen-browser-kiosk/
- https://www.danpurdy.co.uk/web-development/raspberry-pi-kiosk-screen-tutorial/
- https://drgeoffathome.wordpress.com/2014/08/08/cec-adventures-on-the-raspberry-pi/
- https://github.com/elalemanyo/raspberry-pi-kiosk-screen
