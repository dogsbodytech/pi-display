# Create a Raspberry Pi Display on Raspbian Debian using Jessie and the Epiphany browser

We had an issue with a lot of other Raspberry Pi based displays/kiosks as they tended to use the Chromium browser which is very old on arm and doesn't currently support the latest SSL protocols.

This install also downloads and compiles the latest cec-client that allows you to cron turning the TV on and off each day via cron.

## Installation ##

1. Install the latest Raspbian Debian Jessie Lite (Last tested with 2016-09-23-raspbian-jessie-lite.zip)

   You can always grab the latest from  https://downloads.raspberrypi.org/raspbian_lite_latest

2. Login to the Raspberry Pi (SSH as pi user) and update everything...

   `sudo apt update && sudo apt -y dist-upgrade`

3. Run `sudo raspi-config` and...
   - Change User Password
   - Internationalisation Options - Change Timezone - Europe - London
   - Advanced Options - Hostname - displayboard
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

   `echo "URL=https://www.dogsbodytechnology.com/" > /home/pi/pi-display/settings.data`

- To reload the URL or restart the displayboard due to a crash just kill epiphany

   `killall -TERM  epiphany-browser`

- Setup cron job to turn the TV on and off each day. There us an example in the cron.example file.

   `sudo cp /home/pi/pi-display/cron.example /etc/cron.d/displayboard`

## ToDo ##
- It would be great if we could get all the `raspi-config` commands into the `install.sh` script as then the installation could be one hit :-)

## Sources ##
- http://blogs.wcode.org/2013/09/howto-boot-your-raspberry-pi-into-a-fullscreen-browser-kiosk/
- https://www.danpurdy.co.uk/web-development/raspberry-pi-kiosk-screen-tutorial/
- https://drgeoffathome.wordpress.com/2014/08/08/cec-adventures-on-the-raspberry-pi/
- https://github.com/elalemanyo/raspberry-pi-kiosk-screen
