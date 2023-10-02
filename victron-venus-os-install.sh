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
OPTIONEN

 -h | --help - Zeigt diese Hilfe

UMGEBUNGSVARIABLEN

  DEBUG - Für dieses Skript nicht relevant.

  SRCDIR - Verzeichnis, in dem die zur installierenden Skripte 'run' und 'controller.sh' erwartet werden.

  BRANCH - Der Branch des GitHub repository, in dem  die zu installierenden Skripte liegen - voreingestellt auf 'main', gern auch 'dev'.

  DESTDIR - Pfad der den zu installierenden Dateien vorangestellt wird. So könnte beispielsweise in ein chroot Verzeichnis oder ein gemountetes Venus OS image installiert werden.

  LOG_FILE - Datei, über die alle Ereignisse mitprotokolliert werden. Kann gegebenenfallse auf /dev/null gesetzt werden.

LIZENZ

$License

AUTOR

  Christian
EOHILFE
  else
    cat <<EOHELP

DESCRIPTION

OPTIONS

   -h | --help - Shows this help.

ENVIRONMENT

  DEBUG - Of minimal effect for this script, gives extra information on the file structure.

  SRCDIR - Directory in which to expect the scripts run and controller.sh that are to be installed.

  BRANCH - When downloading new versions of that script, the branch on GitHub from which the scripts shall be downloaded - usually 'main' (default) or 'dev'.

  DESTDIR - Path that is preprended to the regular path of the installation, e.g. to facilitate the installation into a chroot environment, the DESTDIR variable would specify the file path to that changed root.

  LOG_FILE - File to which all events are logged, may be set to /dev/null.

LICENSE

$License

AUTHOR

  Christian
EOHELP
  fi

  exit

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
    echo "W: The environment variable DESTDIR is set to the value '$DESTDIR' that is different from '/', the root directory."
    echo "   This is meant to support testing and packaging, not for a true installation."
    echo "   If you are using Victron Venus OS, the correct installation directory should be  '/'."
    echo "   No harm is expected to be caused, but it's recommended to install directly to '/' for a standard installation."
    echo "   You can cancel now with CTRL-C if this is not what you intended."
    sleep 5
    echo "I: Will now continue. You can still interrupt at any time."
    echo
else
    ln -s /data/etc/Spotmarket-Switcher/service /service/Spotmarket-Switcher
    (crontab -l | grep -Fxq "0 * * * * /data/etc/Spotmarket-Switcher/controller.sh") || (crontab -l; echo "0 * * * * /data/etc/Spotmarket-Switcher/controller.sh") | crontab -
fi

if ! mkdir -p "$DESTDIR"/data/etc/Spotmarket-Switcher/service ; then
    echo "E: Could not create service directory '$DESTDIR/data/etc/Spotmarket-Switcher/service'."
    exit 1
fi

downloadToDest () {
    url="$1"
    dest="$2"

    echo "I: Downloading '$(basename "$url")'"
    if ! wget --no-verbose --continue --no-directories --show-progress -O "$dest" "$url" ; then
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
     if ! ls "$SRCDIR"; then
       echo "D: pwd: $(pwd)"
       ls
     fi
   fi
   echo "I: Downloading 'controller.sh' from github repository - '$BRANCH' branch"
   downloadToDest https://raw.githubusercontent.com/christian1980nrw/Spotmarket-Switcher/"$BRANCH"/scripts/controller.sh "$DESTDIR"/data/etc/Spotmarket-Switcher/controller.sh
fi
if [ -x  "$SRCDIR/run" ]; then
   cp "$SRCDIR/run" "$DESTDIR/data/etc/Spotmarket-Switcher/service/"
else
   echo "I: Downloading 'run' from github repository - '$BRANCH' branch"
   downloadToDest https://raw.githubusercontent.com/christian1980nrw/Spotmarket-Switcher/"$BRANCH"/scripts/run "$DESTDIR"/data/etc/Spotmarket-Switcher/service/run
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
        sed -i '1s|^|ln -s /data/etc/Spotmarket-Switcher/service /service/Spotmarket-Switcher\n|' /data/rc.local
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
echo
if [ -n "$missing" ]; then
    echo "Note: Remember to install these missing executables: $missing"
    echo
fi
