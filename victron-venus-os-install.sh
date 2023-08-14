#!/bin/sh

set -e

if ! mkdir -p $INSTALLDIR/data/etc/Spotmarket-Switcher/service ; then
	echo "E: Could not create service directory '$INSTALLDIR/data/etc/Spotmarket-Switcher/service'".
	exit -1
fi
wgetOptions="--no-verbose --continue --no-directories --show-progress"
cd $INSTALLDIR/data/etc/Spotmarket-Switcher
for url in \
	https://raw.githubusercontent.com/christian1980nrw/Victron-ESS__AVM-Fritz-DECT200-210__Spotmarket-Switcher/main/License.md \
	https://raw.githubusercontent.com/christian1980nrw/Victron-ESS__AVM-Fritz-DECT200-210__Spotmarket-Switcher/main/README.md \
	https://github.com/christian1980nrw/Victron-ESS__AVM-Fritz-DECT200-210__Spotmarket-Switcher/blob/main/sample_apidata_to_debug_in_case_of_apichanges.zip?raw=true \
	https://raw.githubusercontent.com/christian1980nrw/Victron-ESS__AVM-Fritz-DECT200-210__Spotmarket-Switcher/main/victron-venus-os-install.sh \
	https://raw.githubusercontent.com/christian1980nrw/Victron-ESS__AVM-Fritz-DECT200-210__Spotmarket-Switcher/main/data/etc/Spotmarket-Switcher/controller.sh \
	https://user-images.githubusercontent.com/6513794/224442951-c0155a48-f32b-43f4-8014-d86d60c3b311.png \
	https://user-images.githubusercontent.com/6513794/206877184-b8bf0752-b5d5-4c1b-af15-800b6499cfc7.png
do
	echo "I: Downloading '$(basename -z $url)'"
	if ! wget $wgetOptions "$url"; then
		echo -n "E: Download of "
		basename -z "$url"
		echo "failed."
		exit -1
	fi
done
chmod +x ./controller.sh

cd service
url=https://raw.githubusercontent.com/christian1980nrw/Victron-ESS__AVM-Fritz-DECT200-210__Spotmarket-Switcher/main/data/etc/Spotmarket-Switcher/service/run
echo "I: Downloading 'run' script to service subdirectory";
wget $wgetOptions $url
chmod +x ./run

if [ ! -d $INSTALLDIR/service ]; then
	echo "W: The $INSTALLDIR/service directory is not existing."
	echo "   Not installing a symbolic link to the Sportmarket-Switcher to register this service."
	echo "   Check on https://github.com/christian1980nrw/Victron-ESS__Shelly-Plug-S__AVM-Fritz-DECT200-210__Spotmarket-Switcher/issues if that has already been reported."
else
	ln -s $INSTALLDIR/data/etc/Spotmarket-Switcher/service $INSTALLDIR/service/Spotmarket-Switcher
fi
echo >> $INSTALLDIR/data/rc.local
echo "ln -s /data/etc/Spotmarket-Switcher/service /service/Spotmarket-Switcher" >> $INSTALLDIR/data/rc.local
chmod +x $INSTALLDIR/data/rc.local

echo Installation completed. Spotmarket-Switcher will be executed every full hour.
echo The crontab will be changed automatically by the script $INSTALLDIR/data/etc/Spotmarket-Switcher/service/run .
echo Please edit the configuration file with vi $INSTALLDIR/data/etc/Spotmarket-Switcher/controller.sh
echo and change it to your needs.
echo Note: This installation will survive a Venus OS firmware update.
echo Please do an extra reboot after every firmware update so that the crontab can be recreated automatically.
echo The System will reboot in 20 seconds to finalize the setup.
sleep 20
reboot
