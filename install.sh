#!/bin/bash
#
# Description: Installation script for displayboard
#

sudo apt-get install -y matchbox epiphany-browser xwit xinit




sudo apt-get install epiphany-browser x11-xserver-utils xautomation unclutter



sudo apt-get update
sudo apt-get -y dist-upgrade
sudo apt-get install -y matchbox chromium ttf-mscorefonts-installer xwit sqlite3 vim at
sudo update-alternatives --config editor
sudo ln -s /usr/lib/arm-linux-gnueabihf/nss/ /usr/lib/nss
sudo vim /etc/rc.local
  # See rc.local file in this folder
sudo vim .xinitrc
  # See xinitrc file in this folder
crontab -e 
  00 08 * * 1-5 echo "on 0" | /usr/local/bin/cec-client -s > /dev/null
  00 18 * * 1-5 echo "standby 0" | /usr/local/bin/cec-client -s > /dev/null
sudo reboot

**__CEC INstall__**
# For some reason the libcec1 cec-utils packages are broken on Raspbian
git clone https://github.com/Pulse-Eight/libcec 
sudo apt-get install gcc liblockdev1-dev autoconf automake libtool checkinstall libudev-dev cmake
cd libcec
./bootstrap
./configure --with-rpi-include-path="/opt/vc/include" --with-rpi-lib-path="/opt/vc/lib/" --enable-rpi
make
sudo checkinstall
sudo ldconfig
/usr/local/bin/cec-client
echo "on 0" | /usr/local/bin/cec-client -s
echo "standby 0" | /usr/local/bin/cec-client -s


