#!/bin/bash
#
# Description: Installation script for displayboard
#

# Check we are root
if [ $LOGNAME != "root" ]
then
    echo "ERROR: Execution of $0 stopped as not run by user root!"
    exit 1
fi

# Disable Overscan
raspi-config nonint do_overscan 1

# Install the bits we need
apt install -y matchbox epiphany-browser xwit xinit ttf-mscorefonts-installer

# Setup rc.local
cp /home/pi/raspbian-jessie-epiphany-display/rc.local /etc/rc.local

# Setup .xinitrc
sudo -u pi cp /home/pi/raspbian-jessie-epiphany-display/xinitrc /home/pi/.xinitrc

# Allow anyone to start an Xserver
echo x11-common x11-common/xwrapper/allowed_users select Anybody | debconf-set-selections -v
echo x11-common x11-common/xwrapper/actual_allowed_users string anybody | debconf-set-selections -v

# Download and copile the latest cec-client so we can turn the TV on and off via cron
# echo "on 0" | /usr/local/bin/cec-client -s
# echo "standby 0" | /usr/local/bin/cec-client -s
apt install -y cmake libudev-dev libxrandr-dev python-dev swig

sudo -u pi git clone https://github.com/Pulse-Eight/platform.git /home/pi/cec-platform
cd /home/pi/cec-platform
sudo -u pi cmake .
sudo -u pi make
make install

sudo -u pi git clone https://github.com/Pulse-Eight/libcec.git /home/pi/libcec
cd /home/pi/libcec
sudo -u pi cmake -DRPI_INCLUDE_DIR=/opt/vc/include -DRPI_LIB_DIR=/opt/vc/lib .
sudo -u pi make -j4
make install
ldconfig


#sudo apt-get install  x11-xserver-utils xautomation unclutter
#sudo apt-get install -y sqlite3 vim at
#sudo update-alternatives --config editor
#sudo ln -s /usr/lib/arm-linux-gnueabihf/nss/ /usr/lib/nss


#crontab -e 
#  00 08 * * 1-5 echo "on 0" | /usr/local/bin/cec-client -s > /dev/null
#  00 18 * * 1-5 echo "standby 0" | /usr/local/bin/cec-client -s > /dev/null
