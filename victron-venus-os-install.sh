#!/bin/sh
mkdir /data/etc/Spotmarket-Switcher
mkdir /data/etc/Spotmarket-Switcher/service
cd /data/etc/Spotmarket-Switcher
wget https://raw.githubusercontent.com/christian1980nrw/Victron-ESS__AVM-Fritz-DECT200-210__Spotmarket-Switcher/main/data/etc/Spotmarket-Switcher/controller.sh
chmod +x ./controller.sh
cd /data/etc/Spotmarket-Switcher/service
wget https://raw.githubusercontent.com/christian1980nrw/Victron-ESS__AVM-Fritz-DECT200-210__Spotmarket-Switcher/main/data/etc/Spotmarket-Switcher/service/run
chmod +x ./run
ln -s  /data/etc/Spotmarket-Switcher/service /service/Spotmarket-Switcher
echo >> /data/rc.local
echo "ln -s /data/etc/Spotmarket-Switcher/service /service/Spotmarket-Switcher" >> /data/rc.local
chmod +x /data/rc.local

echo Installation finished. Spotmarket-Switcher will be executed every full hour. 
echo The crontab will be changed automatically by the script /data/etc/Spotmarket-Switcher/service/run
echo Please edit the configuration file with vi /data/etc/Spotmarket-Switcher/controller.sh
echo and change it to your needs.
echo Note: This installation will survive a Venus OS firmware update.
