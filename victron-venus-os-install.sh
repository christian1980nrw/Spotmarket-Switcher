#!/bin/sh

set -e


# DESTDIR is optionally set as an environment variable.
if [ -n "$DESTDIR" ] && [ "/" != "$DESTDIR" ] ; then
    if which realpath > /dev/null; then
        # avoiding trouble when DESTDIR is not absolute because of changed directories
        DESTDIR=$(realpath "$DESTDIR")
    else
        if ! echo "$DESTDIR" | grep -q "^/"; then
            echo "E: The DESTDIR passed from environment variable must be absolute or realpath must be available."
            exit 1
        fi
    fi
    echo
    echo "W: The environment variable DESTDIR is set to the value '$DESTDIR' that is different from '/', the root directory."
    echo "   This is meant to support testing and packaging, not for a true installation."
    echo "   No harm is expected to be caused, you anyway have 5 seconds to cancel now with CTRL-C."
    sleep 5
    echo "I: Will now continue. Still, you can interrupt at any time."
    echo
fi

if ! mkdir -p "$DESTDIR"/data/etc/Spotmarket-Switcher/service ; then
    echo "E: Could not create service directory '$DESTDIR/data/etc/Spotmarket-Switcher/service'."
    exit 1
fi

wgetOptions="--no-verbose --continue --no-directories --show-progress"
cd "$DESTDIR"/data/etc/Spotmarket-Switcher

for url in \
    https://raw.githubusercontent.com/christian1980nrw/Victron-ESS__AVM-Fritz-DECT200-210__Spotmarket-Switcher/main/License.md \
    https://raw.githubusercontent.com/christian1980nrw/Victron-ESS__AVM-Fritz-DECT200-210__Spotmarket-Switcher/main/README.md \
    https://github.com/christian1980nrw/Victron-ESS__AVM-Fritz-DECT200-210__Spotmarket-Switcher/blob/main/sample_apidata_to_debug_in_case_of_apichanges.zip?raw=true \
    https://raw.githubusercontent.com/christian1980nrw/Victron-ESS__AVM-Fritz-DECT200-210__Spotmarket-Switcher/main/victron-venus-os-install.sh \
    https://raw.githubusercontent.com/christian1980nrw/Victron-ESS__AVM-Fritz-DECT200-210__Spotmarket-Switcher/main/data/etc/Spotmarket-Switcher/controller.sh \
    https://user-images.githubusercontent.com/6513794/224442951-c0155a48-f32b-43f4-8014-d86d60c3b311.png \
    https://user-images.githubusercontent.com/6513794/206877184-b8bf0752-b5d5-4c1b-af15-800b6499cfc7.png
do
    echo "I: Downloading '$(basename "$url")'"
    if ! wget $wgetOptions "$url"; then
        echo "E: Download of '$(basename "$url")' failed."
        exit 1
    fi
done

chmod +x ./controller.sh

url=https://raw.githubusercontent.com/christian1980nrw/Victron-ESS__AVM-Fritz-DECT200-210__Spotmarket-Switcher/main/data/etc/Spotmarket-Switcher/service/run
echo "I: Downloading 'run' script to service subdirectory"
cd service
if ! wget $wgetOptions $url; then
  echo "E: Failure downloading run script from '$url'."
  exit 1
fi
chmod +x ./run

# $DESTDIR is always an absolut path
if [ ! -d "$DESTDIR"/service ]; then
    if [ -n "$DESTDIR" ] && [ "/" != "$DESTDIR" ] ; then
        echo "I: The '$DESTDIR/service' directory is not existing, as expected because of the custom DESTDIR setting."
        echo "   Skipping creation of symbolic link to the Sportmarket-Switcher to register this service."
    else
        echo "W: The '$DESTDIR/service' directory is not existing."
        echo "   Not installing a symbolic link to the Sportmarket-Switcher to register this service."
        echo "   Check on https://github.com/christian1980nrw/Victron-ESS__Shelly-Plug-S__AVM-Fritz-DECT200-210__Spotmarket-Switcher/issues if that has already been reported."
    fi
else
    if [ ! -L "$DESTDIR"/service/Spotmarket-Switcher ]; then
        ln -s "$DESTDIR"/data/etc/Spotmarket-Switcher/service "$DESTDIR"/service/Spotmarket-Switcher
    fi
fi

if [ -e "$DESTDIR"/data/rc.local ]; then
    if grep -q "Spotmarket-Switcher/service /service/Spotmarket-Switcher" "$DESTDIR"/data/rc.local; then
        echo "I: Spotmarket-Switcher/service is already known to rc.local boot script - not added again."
    else
        echo "I: Adding link to Spotmarket-Switcher/service to rc.local boot script."
        echo "ln -s /data/etc/Spotmarket-Switcher/service /service/Spotmarket-Switcher" >> "$DESTDIR"/data/rc.local
    fi
else
    echo "I: Creating new data/rc.local boot script"
    echo "ln -s /data/etc/Spotmarket-Switcher/service /service/Spotmarket-Switcher" > "$DESTDIR"/data/rc.local
    chmod +x "$DESTDIR"/data/rc.local
fi

echo
echo "Installation completed. Spotmarket-Switcher will be executed every full hour."
echo "The crontab will be changed automatically by the script '$DESTDIR/data/etc/Spotmarket-Switcher/service/run' ."
echo "Please edit the configuration file with a text editor, like"
echo "  vi '$DESTDIR/data/etc/Spotmarket-Switcher/controller.sh'"
echo "and change it to your needs."
echo
echo "Note: This installation will survive a Venus OS firmware update."
echo "      Please do an extra reboot after every firmware update so that the crontab can be recreated automatically."
echo
if [ -n "$DESTDIR" ] && [ "/" != "$DESTDIR" ] ; then
    echo "Not auto-rebooting now since DESTDIR set to a value != '/'."
else
    echo "The System will reboot in 20 seconds to finalize the setup."
    sleep 20
    reboot
fi
