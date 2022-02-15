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

SCRIPTDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

echo "Changing default password"
passwd

# Set the timezone
dpkg-reconfigure tzdata

# Set Hostname to displayboard
raspi-config nonint do_hostname "displayboard"

#  Wait for Network at Boot
raspi-config nonint do_boot_wait 1

# Disable Overscan
raspi-config nonint do_overscan 1

# Give the GPU the most memory possible (256MB)
raspi-config nonint do_memory_split 256

# Install the bits we need
apt install -y matchbox x11-xserver-utils xwit xinit ttf-mscorefonts-installer rpi-chromium-mods unattended-upgrades vim

# Setup rc.local
cp $SCRIPTDIR/src/rc.local /etc/rc.local

# Setup .xinitrc
sudo -u pi cp $SCRIPTDIR/src/xinitrc /home/pi/.xinitrc

# Allow anyone to start an Xserver
sed -i 's/allowed_users=.*/allowed_users=anybody/' /etc/X11/Xwrapper.config

# Enable Automatic upgrades to keep the box secure
cp $SCRIPTDIR/src/50unattended-upgrades /etc/apt/apt.conf.d/50unattended-upgrades
cp $SCRIPTDIR/src/20auto-upgrades /etc/apt/apt.conf.d/20auto-upgrades

# Download and copile the latest cec-client so we can turn the TV on and off via cron
# echo "on 0" | /usr/local/bin/cec-client -s
# echo "standby 0" | /usr/local/bin/cec-client -s
apt install -y cmake libudev-dev libxrandr-dev python-dev swig

TEMPDIR=$(mktemp -d)
sudo -u pi git clone https://github.com/Pulse-Eight/platform.git "$TEMPDIR"
cd "$TEMPDIR"
sudo -u pi cmake .
sudo -u pi make
make install
rm -rf "$TEMPDIR"

TEMPDIR=$(mktemp -d)
sudo -u pi git clone https://github.com/Pulse-Eight/libcec.git "$TEMPDIR"
cd "$TEMPDIR"
sudo -u pi cmake -DRPI_INCLUDE_DIR=/opt/vc/include -DRPI_LIB_DIR=/opt/vc/lib .
sudo -u pi make -j4
make install
ldconfig
rm -rf "$TEMPDIR"

