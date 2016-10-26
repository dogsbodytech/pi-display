# Create a Raspberry Pi Kiosk on Raspbian Debian using Jessie and the Epiphany browser

We had an issue with a lot of other Raspberry Pi based kiosks as they tended to use the Chromium browser which is very old and didn't support the latest SSL protocols.  

## Installation ##

1. Install the latest Raspbian Debian Jessie Lite
   `wget https://downloads.raspberrypi.org/raspbian_lite_latest`
   Last tested with 2016-09-23-raspbian-jessie-lite.zip

2. Login to the Raspberry Pi (SSH as pi user) and update everything..
   ```
   sudo apt update
   sudo apt dist-upgrade
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
   

   ```




2. `sudo raspi-config`
	- Change your boot to desktop environment.

4. Install Epiphany (browser), x11 server utils, xautomation and unclutter (hide the cursor from the screen)
	```
	sudo apt-get install epiphany-browser x11-xserver-utils xautomation unclutter
	```

5. Save this shell script: /home/pi/fullscreen.sh
	```
	nano /home/pi/fullscreen.sh
	```
	Fullscreen shell script should look like this: (example replace [URL] http://github.com/elalemanyo/raspberry-pi-kiosk-screen)

	```
	sudo -u pi epiphany-browser -a -i --profile ~/.config [URL] --display=:0 &
	sleep 15s;
	xte "key F11" -x:0
	```

	Change file mode:
	```
	chmod 755 /home/pi/fullscreen.sh
	```

6. Edit the autostart file to run the script:
	```
	nano ~/.config/lxsession/LXDE-pi/autostart
	```

	The autostart files needs to look like this:
	```
	@xset s off
	@xset -dpms
	@xset s noblank
	@/home/pi/fullscreen.sh
	```

7. Reload the page (if needed) every hour:
	```
	crontab -e
	```

	Add this:
	```
	0 */1 * * * xte -x :0 "key F5"
	```

## Connecting to Wi-Fi on boot ##

You may wish to have your Kiosk device connect automatically both to your home wifi (where you test it) as well as the wireless network where you deploy it.

In `/etc/network/interfaces` Add a line that says to cause wireless to connect automatically auto wlan0.


Then edit `/etc/wpa_supplicant/wpa_supplicant.conf` to define one or more wireless networks, changing the SSIDs and passwords to match your networks. The `id_str` values just need to be unique.

```
ctrl_interface=DIR=/var/run/wpa_supplicant GROUP=netdev
update_config=1

network={
	ssid="SCHOOLS NETWORK NAME"
	psk="SCHOOLS PASSWORD"
	id_str="school"
}

network={
	ssid="HOME NETWORK NAME"
	psk="HOME PASSWORD"
	id_str="home"
}
```

## Splashscreen ##

1. Install Frame Buffer Imageviewer (FBI):

	```
	sudo apt-get install fbi
	```
2. Upload splash.png:

	```
	scp splash.png pi@[IP raspberry pi]:splash.png
	```

3. Move splash image to /etc/:

	```
	sudo mv splash.png /etc/
	```

4. Add script:

	```
	sudo nano /etc/asplashscreen
	```

	```
	do_start () {
		/usr/bin/fbi -T 1 -noverbose -a /etc/splash.png
		exit 0
	}
	case "$1" in
		start|"")
	do_start
	;;
	restart|reload|force-reload)
	echo "Error: argument '$1' not supported" >&2
	exit 3
	;;
	stop)
	# No-op
	;;
	status)
	exit 0
	;;
	*)
	echo "Usage: asplashscreen [start|stop]" >&2
	exit 3
	;;
	esac
	:
	```

5. Run:

	```
	sudo mv asplashscreen /etc/init.d/asplashscreen
	```

6. Run:

	```
	sudo chmod a+x /etc/init.d/asplashscreen
	sudo insserv /etc/init.d/asplashscreen
	```

## Sources ##

- https://github.com/elalemanyo/raspberry-pi-kiosk-screen

