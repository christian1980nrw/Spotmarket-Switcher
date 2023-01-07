#!/bin/sh
mkdir /data/etc/Spotmarket-Switcher
mkdir /data/etc/Spotmarket-Switcher/service
cd /data/etc/Spotmarket-Switcher
wget https://raw.githubusercontent.com/christian1980nrw/Victron-ESS__AVM-Fritz-DECT200-210__Spotmarket-Switcher/main/License.md
wget https://raw.githubusercontent.com/christian1980nrw/Victron-ESS__AVM-Fritz-DECT200-210__Spotmarket-Switcher/main/README.md
wget https://raw.githubusercontent.com/christian1980nrw/Victron-ESS__AVM-Fritz-DECT200-210__Spotmarket-Switcher/main/data/etc/Spotmarket-Switcher/controller.sh
wget https://user-images.githubusercontent.com/6513794/209883987-5660ebb9-07aa-4aaa-a6c9-a6d650482610.png
wget https://user-images.githubusercontent.com/6513794/206877184-b8bf0752-b5d5-4c1b-af15-800b6499cfc7.png
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
