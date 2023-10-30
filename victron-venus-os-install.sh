#!/bin/bash

License=$(
    cat <<EOLICENSE
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
    if echo "$LANG" | grep -qi "^de"; then
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

#
#Set Colors (http://natelandau.com/bash-scripting-utilities/)
#
#FIXME: see https://github.com/christian1980nrw/Spotmarket-Switcher/pull/105
#bold=$(tput bold)
#underline=$(tput sgr 0 1)
#reset=$(tput sgr0)

#purple=$(tput setaf 171)
#red=$(tput setaf 1)
#green=$(tput setaf 76)
#tan=$(tput setaf 3)
#blue=$(tput setaf 38)

#
# Headers and  Logging
#

e_header() {
    printf "\n${bold}${purple}==========  %s  ==========${reset}\n" "$@"
}
e_arrow() {
    printf "➜ $@\n"
}
e_success() {
    printf "${green}✔ %s${reset}\n" "$@"
}
e_error() {
    printf "${red}✖ %s${reset}\n" "$@"
}
e_warning() {
    printf "${tan}➜ %s${reset}\n" "$@"
}
e_underline() {
    printf "${underline}${bold}%s${reset}\n" "$@"
}
e_bold() {
    printf "${bold}%s${reset}\n" "$@"
}
e_note() {
    printf "${underline}${bold}${blue}Note:${reset}  ${blue}%s${reset}\n" "$@"
}

echo
e_header "Spotmarket-Switcher Installer"
echo

# Checking preconditions for successful execution

missing=""
for tool in sed awk grep; do
    if ! which "$tool" >/dev/null; then
        missing="$missing $tool"
    fi
done
if [ -n "$missing" ]; then
    e_error "E: Install the following tools prior to running this install script or the installed scripts: $missing"
    exit 1
fi

for tool in wget curl; do
    if ! which "$tool" >/dev/null; then
        missing="$missing $tool"
    fi
done
if [ -n "$missing" ]; then
    e_warning "W: Install the following tools prior to the execution of the installed scripts: $missing."
    e_warning "   Try running 'opkg install $missing'."
    echo
    e_note "   Now continuing with the installation, which will be fine per se, but you as the user are responsible to get those dependencies installed to prevent the control script from failing. Drop an issue at https://github.com/christian1980nrw/Spotmarket-Switcher/issues if this package shall somehow prepare you better."
    echo
fi

# DESTDIR is optionally set as an environment variable.
if [ -n "$DESTDIR" ] && [ "/" != "$DESTDIR" ]; then
    e_warning "W: The environment variable DESTDIR is set to the value '$DESTDIR' that is different from '/', the root directory."
    e_note "   This is meant to support testing and packaging, not for a true installation."
    echo
	e_bold "   If you are using Victron Venus OS, the correct installation directory should be  '/'."
	echo
    e_note "   No harm is expected to be caused, but it's recommended to install directly to '/' for a standard installation."
    e_header "   You can cancel now with CTRL-C if this is not what you intended."

	printf "Do you want to continue? (y/N)"
	read CONTINUE
	CONTINUE=${CONTINUE:-n}
	if [ "$CONTINUE" = "y" ] || [ "$CONTINUE" = "Y" ]; then
		e_success "Starting installation."
	else
		e_error "Installation aborted."
		exit 1
	fi

else
    ln -s /data/etc/Spotmarket-Switcher/service /service/Spotmarket-Switcher
    (crontab -l | grep -Fxq "0 * * * * /data/etc/Spotmarket-Switcher/controller.sh") || (
        crontab -l
        echo "0 * * * * /data/etc/Spotmarket-Switcher/controller.sh"
    ) | crontab -
fi

if ! mkdir -p "$DESTDIR"/data/etc/Spotmarket-Switcher/service; then
    e_error "E: Could not create service directory '$DESTDIR/data/etc/Spotmarket-Switcher/service'."
    exit 1
fi

downloadToDest() {
    url="$1"
    dest="$2"

    e_bold "I: Downloading '$(basename "$url")'"
    if ! wget --no-verbose --continue --no-directories --show-progress -O "$dest" "$url"; then
        e_error "E: Download of '$(basename "$url")' failed."
        return 1
    fi
    chmod +x "$dest"
}

download_file_if_missing() {
    local file_path="$1"
    local dest_path="$2"
    local file_url="$3"

    if [ -x "$file_path" ]; then
        cp "$file_path" "$dest_path"
    else
        if [ -n "$DEBUG" ]; then
            echo "D: ls \$SRCDIR"
            ls "$SRCDIR" || {
                echo "D: pwd: $(pwd)"
                ls
            }
        fi
        e_bold "I: Downloading '$(basename "$file_path")' from github repository - '$BRANCH' branch"
        downloadToDest "$file_url" "$dest_path"
    fi
}

if [ -z "$SRCDIR" ]; then
    SRCDIR=scripts
fi
if [ -z "$BRANCH" ]; then
    BRANCH=main
fi
if [ -z "$ACTOR" ]; then
    ACTOR=christian1980nrw
fi

download_file_if_missing "$SRCDIR/controller.sh" "$DESTDIR/data/etc/Spotmarket-Switcher/controller.sh" https://raw.githubusercontent.com/"$ACTOR"/Spotmarket-Switcher/"$BRANCH"/scripts/controller.sh
download_file_if_missing "$SRCDIR/run" "$DESTDIR/data/etc/Spotmarket-Switcher/service/run" https://raw.githubusercontent.com/"$ACTOR"/Spotmarket-Switcher/"$BRANCH"/scripts/run
download_file_if_missing "$SRCDIR/sample.config.txt" "$DESTDIR/data/etc/Spotmarket-Switcher/sample.config.txt" https://raw.githubusercontent.com/"$ACTOR"/Spotmarket-Switcher/"$BRANCH"/scripts/sample.config.txt

#This option will not overwrite the destination_file if it already exists. There is no output or error message if the file is not copied, the command simply exits silently. If the target file does not exist, it will be created as usual.
cp -n "$DESTDIR/data/etc/Spotmarket-Switcher/sample.config.txt" "$DESTDIR/data/etc/Spotmarket-Switcher/config.txt"

# $DESTDIR is always an absolut path
if [ ! -d "$DESTDIR"/service ]; then
    if [ -n "$DESTDIR" ] && [ "/" != "$DESTDIR" ]; then
        echo
        e_note "I: The '$DESTDIR/service' directory is not existing, as expected because of the custom DESTDIR setting."
        e_note "   Skipping creation of symbolic link to the Sportmarket-Switcher to register this service."
        echo
    else
        echo
        e_warning "W: The '$DESTDIR/service' directory is not existing."
        e_note "   Not installing a symbolic link to the Sportmarket-Switcher to register this service."
        e_note "   Check on https://github.com/$ACTOR/Spotmarket-Switcher/issues if that has already been reported."
        echo
    fi
else
    if [ ! -L "$DESTDIR"/service/Spotmarket-Switcher ]; then
        ln -s "$DESTDIR"/data/etc/Spotmarket-Switcher/service "$DESTDIR"/service/Spotmarket-Switcher
    fi
fi

if [ -e "$DESTDIR"/data/rc.local ]; then
    if grep -q "Spotmarket-Switcher/service /service/Spotmarket-Switcher" "$DESTDIR"/data/rc.local; then
        e_note "I: Spotmarket-Switcher/service is already known to rc.local boot script - not added again."
    else
        e_note "I: Adding link to Spotmarket-Switcher/service to rc.local boot script."
        sed -i '1s|^|ln -s /data/etc/Spotmarket-Switcher/service /service/Spotmarket-Switcher\n|' /data/rc.local
    fi
else
    e_note "I: Creating new data/rc.local boot script"
    echo "ln -s /data/etc/Spotmarket-Switcher/service /service/Spotmarket-Switcher" >"$DESTDIR"/data/rc.local
    chmod +x "$DESTDIR"/data/rc.local
fi

echo
e_success "Installation completed. Spotmarket-Switcher will be executed every full hour."
echo
e_bold "The crontab will be changed automatically by the script '$DESTDIR/data/etc/Spotmarket-Switcher/service/run' ."
echo
e_underline "Please edit the configuration file with a text editor, like"
echo
echo "    vi '$DESTDIR/data/etc/Spotmarket-Switcher/config.txt'"
echo
echo "or"
echo
echo "    nano '$DESTDIR/data/etc/Spotmarket-Switcher/config.txt'"
echo
e_underline "and change it to your needs."
echo
e_success "Note: This installation will survive a Venus OS firmware update."
echo
if [ -n "$missing" ]; then
    e_note "Note: Remember to install these missing executables: $missing"
    echo
fi