#!/bin/sh

License=$(cat <<EOLICENSE
MIT License

Copyright (c) 2023 christian1980nrw

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be included
in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN
NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM,
DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR
THE USE OR OTHER DEALINGS IN THE SOFTWARE.
EOLICENSE
)

set -e

if [ -z "$LANG" ]; then
  export LANG=C
fi

if [ "-h" = "$1" ] || [ "--help" = "$1" ]; then
  if echo "$LANG" | grep -qi "^de" ; then
    cat <<EOHILFE
Optionen

 -h | --help - Zeigt diese Hilfe

Lizenz

$(echo "$License" | sed -e 's/^/  /')

Autor

  Christian
EOHILFE
  else
    cat <<EOHELP

Description

Options

 -h | --help - Shows this help.

License

$(echo "$License" | sed -e 's/^/  /')

Author

  Christian
EOHELP
  fi
fi

# Checking preconditions for successful execution

missing=""
for tool in sed awk grep
do
  if ! which "$tool" > /dev/null; then
    missing="$missing $tool"
  fi
done
if [ -n "$missing" ]; then
  echo "E: Install the following tools prior to running this install script or the installed scripts: $missing"
  exit 1
fi

for tool in wget curl
do
  if ! which "$tool" > /dev/null; then
    missing="$missing $tool"
  fi
done
if [ -n "$missing" ]; then
  echo "W: Install the following tools prior to the execution of the installed scripts: $missing."
  echo "   Try running 'opkg install $missing'." 
  echo
  echo "   Now continuing with the installation, which will be fine per se, but you as the user are responsible to get those dependencies installed to prevent the control script from failing. Drop an issue at https://github.com/christian1980nrw/Spotmarket-Switcher/issues if this package shall somehow prepare you better."
  echo
fi



# DESTDIR is optionally set as an environment variable.
if [ -n "$DESTDIR" ] && [ "/" != "$DESTDIR" ] ; then
    if which realpath > /dev/null; then
        RESOLVED_DESTDIR=$(realpath "$DESTDIR")
        if [ "$RESOLVED_DESTDIR" != "$DESTDIR" ]; then
            echo "W: The provided installation path ($DESTDIR) is a symbolic link that points to $RESOLVED_DESTDIR."
            echo "   The script will use the resolved path for installation."
        fi
        DESTDIR="$RESOLVED_DESTDIR"
    else
        if ! echo "$DESTDIR" | grep -q "^/"; then
            echo "E: The DESTDIR passed from environment variable must be absolute or realpath must be available."
            exit 1
        fi
    fi
    echo
    echo "W: The environment variable DESTDIR is set to the value '$DESTDIR' that is different from '/', the root directory."
    echo "   This is meant to support testing and packaging, not for a true installation."
    echo "   If you are using Victron Venus OS, the correct installation directory should be  '/'."
    echo "   No harm is expected to be caused, you anyway have 5 seconds to cancel now with CTRL-C."
    sleep 5
    echo "I: Will now continue. Still, you can interrupt at any time."
    echo
fi

if ! mkdir -p "$DESTDIR"/data/etc/Spotmarket-Switcher/service ; then
    echo "E: Could not create service directory '$DESTDIR/data/etc/Spotmarket-Switcher/service'."
    exit 1
fi

downloadToDest () {
    url="$1"
    dest="$2"

    echo "I: Downloading '$(basename "$url")'"
    if ! wget --no-verbose --continue --no-directories --show-progress -O $dest $url ; then
        echo "E: Download of '$(basename "$url")' failed."
        return 1
    fi
    chmod +x "$dest"
}

if [ -z "$SRCDIR" ]; then
    SRCDIR=scripts
fi
if [ -z "$branch" ]; then
    BRANCH=main
fi
if [ -x  "$SRCDIR/controller.sh" ]; then
   cp "$SRCDIR/controller.sh" "$DESTDIR"/data/etc/Spotmarket-Switcher/
else
   if [ -n "$DEBUG" ]; then
     # Series of extra info in case the scripts directory is not nearby
     echo "D: ls \$SRCDIR"
     ls "$SRCDIR"
   fi
   echo "I: Downloading 'controller.sh' from github repository - '$BRANCH' branch"
   downloadToDest https://raw.githubusercontent.com/christian1980nrw/Spotmarket-Switcher/$BRANCH/data/etc/Spotmarket-Switcher/controller.sh "$DESTDIR"/data/etc/Spotmarket-Switcher/controller.sh
fi
if [ -x  "$SRCDIR/run" ]; then
   cp "$SRCDIR/run" "$DESTDIR/data/etc/Spotmarket-Switcher/service/"
else
   echo "I: Downloading 'run' from github repository - '$BRANCH' branch"
   downloadToDest https://raw.githubusercontent.com/christian1980nrw/Spotmarket-Switcher/$BRANCH/data/etc/Spotmarket-Switcher/service/run "$DESTDIR"/data/etc/Spotmarket-Switcher/service/run
fi

# $DESTDIR is always an absolut path
if [ ! -d "$DESTDIR"/service ]; then
    if [ -n "$DESTDIR" ] && [ "/" != "$DESTDIR" ] ; then
        echo "I: The '$DESTDIR/service' directory is not existing, as expected because of the custom DESTDIR setting."
        echo "   Skipping creation of symbolic link to the Sportmarket-Switcher to register this service."
    else
        echo "W: The '$DESTDIR/service' directory is not existing."
        echo "   Not installing a symbolic link to the Sportmarket-Switcher to register this service."
        echo "   Check on https://github.com/christian1980nrw/Spotmarket-Switcher/issues if that has already been reported."
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
if [ -n "$missing" ]; then
    echo "Note: Remember to install these missing executables: $missing"
    echo
fi

if [ -n "$DESTDIR" ] && [ "/" != "$DESTDIR" ] ; then
    echo "I: Not auto-rebooting now since DESTDIR set to a value != '/'."
    exit 0
elif [ -e /.dockerenv ]; then
    echo "I: Not auto-rebooting since /.dockerenv exists, suggesting execution within docker"
    exit 0
elif [ -n "$NO_REBOOT" ]; then
    echo "I: Not rebooting the system since NO_REBOOT environment variable is set."
    exit 0
else
    echo "W: The System will reboot in 20 seconds to finalize the setup."
    sleep 20
    reboot
fi
