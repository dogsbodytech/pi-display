# Create a Raspberry Pi Display on Raspbian Debian using Jessie and the Epiphany browser

We had an issue with a lot of other Raspberry Pi based displays/kiosks as they tended to use the Chromium browser which is very old on arm and doesn't currently support the latest SSL protocols.  

## Installation ##

1. Install the latest Raspbian Debian Jessie Lite

   `wget https://downloads.raspberrypi.org/raspbian_lite_latest`

   (Last tested with 2016-09-23-raspbian-jessie-lite.zip)

2. Login to the Raspberry Pi (SSH as pi user) and update everything...
   ```
   sudo apt update && sudo apt -y dist-upgrade
   ```

3. Run `sudo raspi-config` and...
   - Expand Filesystem
   - Change User Password
   - Internationalisation Options - Change Timezone - Europe - London
   - Advanced Options - Overscan - Off
   - Advanced Options - Hotname - displayboard
   - Advanced Options - Memory Split - 256
   - Finish - No Reboot

4. Install git and this repo...
   ```
   sudo apt install git
   git clone https://github.com/dogsbodytech/raspbian-jessie-epiphany-display.git /home/pi/raspbian-jessie-epiphany-display
   ```
5. Run the setup script

   `sudo bash /home/pi/raspbian-jessie-epiphany-display/install.sh`


## Sources ##
- http://blogs.wcode.org/2013/09/howto-boot-your-raspberry-pi-into-a-fullscreen-browser-kiosk/
- https://www.danpurdy.co.uk/web-development/raspberry-pi-kiosk-screen-tutorial/
- https://drgeoffathome.wordpress.com/2014/08/08/cec-adventures-on-the-raspberry-pi/
- https://github.com/elalemanyo/raspberry-pi-kiosk-screen
