#!/bin/sh
mkdir /data/etc/Spotmarket-Switcher
cd /data/etc/Spotmarket-Switcher
wget https://raw.githubusercontent.com/christian1980nrw/Victron-ESS__AVM-Fritz-DECT200-210__Spotmarket-Switcher/main/data/etc/Spotmarket-Switcher/controller.sh
chmod +x ./controller.sh
(crontab -l | grep -Fxq "/data/etc/Spotmarket-Switcher/controller.sh") || (crontab -l; echo "0 * * * * /data/etc/Spotmarket-Switcher/controller.sh") | crontab -

echo Installation finished. Spotmarket-Switcher will be executed every full hour. 
echo Please edit the file /data/etc/Spotmarket-Switcher/controller.sh and change it to your needs.
echo Note: This installation will survive a firmware update.
