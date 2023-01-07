#!/bin/sh
mkdir /data/etc/Spotmarket-Switcher
cd /data/etc/Spotmarket-Switcher
wget https://raw.githubusercontent.com/christian1980nrw/Victron-ESS__AVM-Fritz-DECT200-210__Spotmarket-Switcher/main/data/etc/Spotmarket-Switcher/controller.sh
chmod +x ./controller.sh
echo >> /data/rc.local
echo '(crontab -l | grep -Fxq "0 * * * * /data/etc/Spotmarket-Switcher/controller.sh") || (crontab -l; echo "0 * * * * /data/etc/Spotmarket-Switcher/controller.sh") | crontab -' >> /data/rc.local
chmod +x /data/rc.local

echo Installation finished. Spotmarket-Switcher will be executed every full hour. 
echo Please edit the file /data/etc/Spotmarket-Switcher/controller.sh and change it to your needs.
echo Note: This installation will survive a firmware update.
