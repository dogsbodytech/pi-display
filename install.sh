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
apt install -y matchbox x11-xserver-utils xwit xinit ttf-mscorefonts-installer rpi-chromium-mods unattended-upgrades vim

# Setup rc.local
cp /home/pi/pi-display/rc.local /etc/rc.local

# Setup .xinitrc
sudo -u pi cp /home/pi/pi-display/xinitrc /home/pi/.xinitrc

# Allow anyone to start an Xserver
sed -i 's/allowed_users=.*/allowed_users=anybody/' /etc/X11/Xwrapper.config

# Enable Automatic upgrades to keep the box secure
cp /home/pi/pi-display/50unattended-upgrades /etc/apt/apt.conf.d/50unattended-upgrades
cp /home/pi/pi-display/20auto-upgrades /etc/apt/apt.conf.d/20auto-upgrades

# Download and copile the latest cec-client so we can turn the TV on and off via cron
# echo "on 0" | /usr/local/bin/cec-client -s
# echo "standby 0" | /usr/local/bin/cec-client -s
apt install -y cmake libudev-dev libxrandr-dev python-dev swig

if [ -d /home/pi/cec-platform ];then rm -rf /home/pi/cec-platform; fi
sudo -u pi git clone https://github.com/Pulse-Eight/platform.git /home/pi/cec-platform
cd /home/pi/cec-platform
sudo -u pi cmake .
sudo -u pi make
make install

if [ -d /home/pi/libcec ];then rm -rf /home/pi/libcec; fi
sudo -u pi git clone https://github.com/Pulse-Eight/libcec.git /home/pi/libcec
cd /home/pi/libcec
sudo -u pi cmake -DRPI_INCLUDE_DIR=/opt/vc/include -DRPI_LIB_DIR=/opt/vc/lib .
sudo -u pi make -j4
make install
ldconfig
