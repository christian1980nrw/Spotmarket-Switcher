#!/bin/bash

License=$(
	cat <<EOLICENSE
  MIT License

  Copyright (c) 2023 christian1980nrw

  Permission is hereby granted, free of charge, to any person
  obtaining a copy of this software and associated documentation
  files (the "Software"), to deal in the Software without restriction,
  including without limitation the rights to use, copy, modify,
  merge, publish, distribute, sublicense, and/or sell copies of the
  Software, and to permit persons to whom the Software is furnished
  to do so, subject to the following conditions:

  The above copyright notice and this permission notice shall be
  included in all copies or substantial portions of the Software.

  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
  EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
  OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
  NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
  BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN
  AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF
  OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
  IN THE SOFTWARE.
EOLICENSE
)

set -e

if [ -z "$LANG" ]; then
	export LANG="C"
fi

if test "-h" = "$1" || test "--help" = "$1"; then
	if echo "$LANG" | grep -qi "^de"; then
		cat <<EOHILFE
Verwendung: $0 - ohne Argumente

BESCHREIBUNG

  Dieses Skript erwartet, auf einem System unter Venus OS ausgeführt werden, um die stündlich angepassten, am Vortag festgelegten Strompreise herunterzuladen und Ladevorgänge am Wechselrichter oder Smart Devices im Haus zu steuern. Ein regulärer Benutzer sollte dieses Skript nicht manuell bearbeiten. Es sollte mithilfe des Installations-Skripts des Projekts installiert und regelmäßig vom cron-Dienst ausgeführt werden.

OPTIONEN

  -h | --help - Zeigt diese Hilfe an

UMGEBUNGSVARIABLEN

  DEBUG - Wenn auf einen beliebigen Wert gesetzt, werden keine Veränderungen am System vorgenommen und die Ausgaben auf der Konsole sind teilweise ausführlicher.

  rc_local_file - Der Pfad zur Datei, über die der Service gestartet wird, kann festgelegt werden. Dies ist ausschließlich für Testzwecke vorgesehen.

  LOG_FILE - In diese Datei werden alle auch auf der Konsole ausgegebenen Informationen gespeichert - voreingestellt auf "/tmp/spotmarket-switcher.log"

  LOG_MAX_SIZE=1024  - Maximale Größe (in kb) der log Datei - voreingestellt auf 1 MB

  LOG_FILES_TO_KEEP=2 - Wenn eine Log Datei zu groß wird, so wird eine neue angelegt - diese Variable legt fest, wie viele LOG-Dateien für einen Rückblick erhalten werden sollen.

SIEHE AUCH

  README_de.md
  Homepage des Projekts auf https://github.com/christian1980nrw/Spotmarket-Switcher

WICHTIG - Haftungsausschluss (Disclaimer) und Lizenz

  Dieses Computerprogramm wird "wie es ist" bereitgestellt, und der Nutzer trägt das volle Risiko bei der Nutzung. Der Autor übernimmt keine Gewährleistung für die Genauigkeit, Zuverlässigkeit, Vollständigkeit oder Brauchbarkeit des Programms für irgendeinen bestimmten Zweck. Der Autor haftet weder für Schäden, die sich aus der Nutzung oder Unfähigkeit zur Nutzung des Programms ergeben, noch für Schäden, die aufgrund von Fehlern oder Mängeln des Programms entstehen. Dies gilt auch für Schäden, die aufgrund von Verletzungen von Pflichten im Rahmen einer vertraglichen oder außervertraglichen Verpflichtung entstehen.

$License

UNTERSTÜTZUNG

  Bitte unterstützen Sie dieses Projekt und tragen Sie zur Weiterentwicklung bei: https://revolut.me/christqki2 oder https://paypal.me/christian1980nrw. Wenn Sie in Deutschland leben und zu einem dynamischen Stromtarif wechseln möchten, können Sie das Projekt unterstützen und den Tarif über den folgenden Link abschließen. Wir beide erhalten eine Prämie von 50 Euro für Hardware. Besuchen Sie https://invite.tibber.com/ojgfbx2e. Klicken Sie in der Tibber-App auf "Ich wurde eingeladen" und geben Sie den Code ojgfbx2e in der App ein. Bitte beachten Sie, dass für einen dynamischen Tarif ein intelligenter Zähler oder ein Tracker wie Pulse https://tibber.com/de/store/produkt/pulse-ir benötigt wird. Geben Sie die ersten 4 Ziffern Ihrer Zählernummer auf dieser Website ein, um die Pulse-Kompatibilität zu überprüfen. Natürlich können Sie Ihren Bonus für die Pulse-Bestellung verwenden. Warten Sie dazu, bis der Liefertermin bestätigt und der Bonus gutgeschrieben wurde.

  Wenn Sie einen günstigen Erdgastarif benötigen oder nicht überzeugt sind, den dynamischen Tibber-Tarif zu wählen, können Sie dieses Projekt dennoch unterstützen und einen klassischen Stromtarif von Octopus Energy über den folgenden Link abschließen, um einen 50-Euro-Gutschein für sich selbst und einen 50-Euro-Bonus für dieses Projekt zu erhalten: https://share.octopusenergy.de/glass-raven-58.
EOHILFE
	else
		cat <<EOHELP
Usage: $0 - without arguments

DESCRIPTION

  This script should be executed on a system running under Venus OS to download hourly adjusted electricity prices determined on the previous day and control charging operations on the inverter or smart devices in the house. A regular user should not manually modify this script. It should be installed using the project's installation script and executed regularly by the cron service.

OPTIONS

  -h | --help - Show this help

ENVIRONMENT VARIABLES

  DEBUG - If set to any value, no system changes will be made, and console outputs will be more detailed.

  rc_local_file - The path to the file through which the service is started can be specified. Intended solely for testing purposes.

  LOG_FILE - File storing all the data that was sent to the console - preset to "/tmp/spotmarket-switcher.log"

  LOG_MAX_SIZE=1024  - Maximal size (in kb) of log file - preset to 1 MB

  LOG_FILES_TO_KEEP=2 - When a log file becomes too large, a new file will be created. This variable determined the number of file to keep for a retrospection.

SEE ALSO

  README_de.md
  Project homepage on https://github.com/christian1980nrw/Spotmarket-Switcher

IMPORTANT - Disclaimer and License

$License

SUPPORT

  Please support this project and contribute to further development: https://revolut.me/christqki2 or https://paypal.me/christian1980nrw. If you live in Germany and wish to switch to a dynamic electricity tariff, you can support me and sign up for the tariff through the following link. We both receive a 50 Euro bonus for hardware. Visit https://invite.tibber.com/ojgfbx2e. In the Tibber app, click "I was invited" and enter the code ojgfbx2e in the app. Please note that you need a smart meter or a tracker like Pulse https://tibber.com/de/store/produkt/pulse-ir for an hourly tariff. Enter the first 4 digits of your meter number on that website to check Pulse compatibility. Of course, you can use your bonus for the Pulse order. Wait until the delivery date is confirmed and the bonus is credited.

  If you happen to need a cheap natural gas tariff or are not convinced to choose the dynamic Tibber tariff, you can still support this project and choose a classic electricity tariff using the following link to get a 50 Euro voucher for yourself and a 50 Euro bonus for this project: https://share.octopusenergy.de/glass-raven-58.
EOHELP
	fi

	exit

fi

#
# Note: This script is only for hourly-based tariff data, please create your own fork for higher resolutions like 15 minute intervals.
#       After an API reconfiguration please delete the old API-Downloadfiles with rm /tmp/awattar*.* /tmp/entsoe*.*

# Path to the current script directory
DIR="$(dirname "$0")"

if [ -f "$DIR/config.txt" ]; then
	# Include the configuration file
	source "$DIR/config.txt"
else
	echo "The file $DIR/config.txt was not found! Configure the existing sample.config.txt file and then save it as config.txt in the same directory."
	exit 127
fi

get_tibber_api() {
	curl --location --request POST 'https://api.tibber.com/v1-beta/gql' \
		--header 'Content-Type: application/json' \
		--header "Authorization: Bearer $tibber_api_key" \
		--data-raw '{"query":"{viewer{homes{currentSubscription{priceInfo{current{total energy tax startsAt}today{total energy tax startsAt}tomorrow{total energy tax startsAt}}}}}}"}' |
		awk '{
        gsub(/"current":/, "\n&");
        gsub(/"today":/, "\n&");
        gsub(/"tomorrow":/, "\n&");
        gsub(/"total":/, "\n&");
        print
    }'
}

if [ -z "$UNAME" ]; then
	UNAME=$(uname)
fi
if [ "Darwin" = "$UNAME" ]; then
	echo "W: MacOS has a different implementation of 'date' - use conda if hunting a bug on a mac".
fi

# further API parameters (no need to edit)
dateInSeconds=$(LC_ALL=C TZ=$TZ date +"%s")
if [ "Darwin" = "$UNAME" ]; then
	yesterday=$(LC_ALL=C TZ=$TZ date -j -f "%s" $((dateInSeconds - 86400)) +%d)2300
	yestermonth=$(LC_ALL=C TZ=$TZ date -j -f "%s" $((dateInSeconds - 86400)) +%m)
	yesteryear=$(LC_ALL=C TZ=$TZ date -j -f "%s" $((dateInSeconds - 86400)) +%Y)
	today=$(LC_ALL=C TZ=$TZ date -j -f "%s" $((dateInSeconds)) +%d)2300
	today2=$(LC_ALL=C TZ=$TZ date -j -f "%s" $((dateInSeconds)) +%d)
	todaymonth=$(LC_ALL=C TZ=$TZ date -j -f "%s" $((dateInSeconds)) +%m)
	todayyear=$(LC_ALL=C TZ=$TZ date -j -f "%s" $((dateInSeconds)) +%Y)
	tomorrow=$(LC_ALL=C TZ=$TZ date -j -f "%s" $((dateInSeconds + 86400)) +%d)2300
	tomorrow2=$(LC_ALL=C TZ=$TZ date -j -f "%s" $((dateInSeconds + 86400)) +%d)
	tomorrowmonth=$(LC_ALL=C TZ=$TZ date -j -f "%s" $((dateInSeconds + 86400)) +%m)
	tomorrowyear=$(LC_ALL=C TZ=$TZ date -j -f "%s" $((dateInSeconds + 86400)) +%Y)
	getnow=$(LC_ALL=C TZ=$TZ date -j -f "%s" $((dateInSeconds)) +%k)
else
	yesterday=$(LC_ALL=C TZ=$TZ date -d @$((dateInSeconds - 86400)) +%d)2300
	yestermonth=$(LC_ALL=C TZ=$TZ date -d @$((dateInSeconds - 86400)) +%m)
	yesteryear=$(LC_ALL=C TZ=$TZ date -d @$((dateInSeconds - 86400)) +%Y)
	today=$(LC_ALL=C TZ=$TZ date -d @$((dateInSeconds)) +%d)2300
	today2=$(LC_ALL=C TZ=$TZ date -d @$((dateInSeconds)) +%d)
	todaymonth=$(LC_ALL=C TZ=$TZ date -d @$((dateInSeconds)) +%m)
	todayyear=$(LC_ALL=C TZ=$TZ date -d @$((dateInSeconds)) +%Y)
	tomorrow=$(LC_ALL=C TZ=$TZ date -d @$((dateInSeconds + 86400)) +%d)2300
	tomorrow2=$(LC_ALL=C TZ=$TZ date -d @$((dateInSeconds + 86400)) +%d)
	tomorrowmonth=$(LC_ALL=C TZ=$TZ date -d @$((dateInSeconds + 86400)) +%m)
	tomorrowyear=$(LC_ALL=C TZ=$TZ date -d @$((dateInSeconds + 86400)) +%Y)
	getnow=$(LC_ALL=C TZ=$TZ date -d @$((dateInSeconds)) +%k)
fi

now_linenumber=$((getnow + 1))
link1="https://api.awattar.$awattar/v1/marketdata/current.yaml"
link2="http://api.awattar.$awattar/v1/marketdata/current.yaml?tomorrow=include"
link3="https://weather.visualcrossing.com/VisualCrossingWebServices/rest/services/timeline/$latitude%2C%20$longitude/$todayyear-$todaymonth-$today2/$tomorrowyear-$tomorrowmonth-$tomorrow2?unitGroup=metric&elements=solarenergy%2Ccloudcover%2Csunrise%2Csunset&include=days&key=$visualcrossing_api_key&contentType=csv"
link4="https://web-api.tp.entsoe.eu/api?securityToken=$entsoe_eu_api_security_token&documentType=A44&in_Domain=$in_Domain&out_Domain=$out_Domain&periodStart=$yesteryear$yestermonth$yesterday&periodEnd=$todayyear$todaymonth$today"
link5="https://web-api.tp.entsoe.eu/api?securityToken=$entsoe_eu_api_security_token&documentType=A44&in_Domain=$in_Domain&out_Domain=$out_Domain&periodStart=$todayyear$todaymonth$today&periodEnd=$tomorrowyear$tomorrowmonth$tomorrow"
link6="https://api.tibber.com/v1-beta/gql"
file1=/tmp/awattar_today_prices.yaml
file2=/tmp/awattar_tomorrow_prices.yaml
file3=/tmp/expected_solarenergy.csv
file4=/tmp/entsoe_today_prices.xml
file5=/tmp/entsoe_tomorrow_prices.xml
file6=/tmp/awattar_prices.txt
file7=/tmp/awattar_prices_sorted.txt
file8=/tmp/entsoe_prices.txt
file9=/tmp/entsoe_tomorrow_prices_sorted.txt
file10=/tmp/entsoe_today_prices.txt
file11=/tmp/entsoe_today_prices_sorted.txt
file12=/tmp/tibber_prices_sorted.txt
file13=/tmp/entsoe_tomorrow_prices.txt
file14=/tmp/tibber_prices.txt
file15=/tmp/tibber_today_prices.txt
file16=/tmp/tibber_today_prices_sorted.txt
file17=/tmp/tibber_tomorrow_prices.txt
file18=/tmp/tibber_tomorrow_prices_sorted.txt
file19=/tmp/entsoe_prices_sorted.txt

########## Optional environmental variables

if [ -z "$LOG_FILE" ]; then
	LOG_FILE="/tmp/spotmarket-switcher.log"
fi
if [ -z "$LOG_MAX_SIZE" ]; then
	LOG_MAX_SIZE=1024 # 1 MB
fi
if [ -z "$LOG_FILES_TO_KEEP" ]; then
	LOG_FILES_TO_KEEP=2
fi

########## Testing series of preconditions prior to execution of script

num_tools_missing=0
tools="awk curl cat sed sort head tail"
if [ 0 -lt $use_victron_charger ]; then
	tools="$tools dbus"
	charger_command_turnon="dbus -y com.victronenergy.settings /Settings/CGwacs/BatteryLife/Schedule/Charge/0/Day SetValue -- 7"
	charger_command_turnoff="dbus -y com.victronenergy.settings /Settings/CGwacs/BatteryLife/Schedule/Charge/0/Day SetValue -- -7"
	SOC_percent=$(dbus-send --system --print-reply --dest=com.victronenergy.system /Dc/Battery/Soc com.victronenergy.BusItem.GetValue | grep variant | awk '{print $3}') # This will get the battery state of charge (SOC) from a Victron Energy system
fi

for tool in $tools; do
	if ! which "$tool" >/dev/null; then
		echo "E: Please ensure the tool '$tool' is found."
		num_tools_missing=$((num_tools_missing + 1))
	fi
done

if [ $num_tools_missing -gt 0 ]; then
	echo "E: $num_tools_missing tools are missing."
	exit 1
fi

unset num_tools_missing

########## Begin of the script...

echo >>"$LOG_FILE"

log_info() {
	echo "$1" | tee -a "$LOG_FILE"
}

download_awattar_prices() {
	local url="$1"
	local file="$2"
	local output_file="$3"
	local sleep_time="$4"

	if [ -z "$DEBUG" ]; then
		echo "I: Please be patient. First we wait $sleep_time seconds in case the system clock is not syncronized and not to overload the API."
		sleep "$sleep_time"
	fi
	if ! curl "$url" >"$file"; then
		log_info "E: Download of aWATTar prices from '$url' to '$file' failed."
		exit 1
	fi

	if ! test -f "$file"; then
		log_info "E: Could not get aWATTar prices from '$url' to feed file '$file'."
		exit 1
	fi

	if [ -n "$DEBUG" ]; then
		echo "D: Download of file '$file' from URL '$url' successful." >&2
	fi
	echo >>"$file"
	awk '/data_price_hour_rel_.*_amount: / {print substr($0, index($0, ":") + 2)}' "$file" >"$output_file"
	sort -g "$output_file" >"${output_file%.*}_sorted.${output_file##*.}"
	timestamp=$(TZ=$TZ date +%d)
	echo "date_now_day: $timestamp" >>"$output_file"
	echo "date_now_day: $timestamp" >>"${output_file%.*}_sorted.${output_file##*.}"

	if [ -f "$file2" ] && [ "$(wc -l <"$file1")" = "$(wc -l <"$file2")" ]; then
		rm -f "$file2"
		echo "I: File '$file2' has no tomorrow data, we have to try it again until the new prices are online."
	fi
}

download_tibber_prices() {
	local url="$1"
	local file="$2"
	local sleep_time="$3"

	if [ -z "$DEBUG" ]; then
		echo "I: Please be patient. First we wait $sleep_time seconds in case the system clock is not syncronized and not to overload the API."
		sleep "$sleep_time"
	else
		echo "D: No delay of download of Tibber data since DEBUG variable set."
	fi
	if ! get_tibber_api | tr -d '{}[]' >"$file"; then
		log_info "E: Download of Tibber prices from '$url' to '$file' failed."
		exit 1
	fi

	sed -n '/"today":/,/"tomorrow":/p' "$file" | sed '$d' | sed '/"today":/d' >"$file15"
	sort -t, -k1.9n $file15 >"$file16"
	sed -n '/"tomorrow":/,$p' "$file" | sed '/"tomorrow":/d' >"$file17"
	sort -t, -k1.9n $file17 >"$file18"
	if [ "$include_second_day" = 0 ]; then
		cp "$file16" "$file12"
	else
		grep '"total"' "$file14" | sort -t':' -k2 -n >"$file12"
	fi

	timestamp=$(TZ=$TZ date +%d)
	echo "date_now_day: $timestamp" >>"$file15"
	echo "date_now_day: $timestamp" >>"$file17"

	if [ ! -s "$file16" ]; then
		log_info "E: Tibber prices cannot be extracted to '$file16', please check your Tibber API Key."
		rm "$file"
		exit 1
	fi
}

download_entsoe_prices() {
	local url="$1"
	local file="$2"
	local output_file="$3"
	local sleep_time="$4"

	if [ -z "$DEBUG" ]; then
		echo "I: Please be patient. First we wait $sleep_time seconds in case the system clock is not syncronized and not to overload the API."
		sleep "$sleep_time"
	else
		echo "D: No delay of download of entsoe data since DEBUG variable set." >&2
	fi

	if ! curl "$url" >"$file"; then
		log_info "E: Retrieval of entsoe data from '$url' into file '$file' failed."
		exit 1
	fi

	if ! test -f "$file"; then
		log_info "E: Could not find file '$file' with entsoe price data. Curl itself reported success."
		exit 1
	fi

	if [ -n "$DEBUG" ]; then echo "D: Entsoe file '$file' with price data downloaded" >&2; fi

	if [ ! -s "$file" ]; then
		log_info "E: Entsoe file '$file' is empty, please check your entsoe API Key."
		exit 1
	fi

	if [ -n "$DEBUG" ]; then echo "D: Entsoe file '$file' with price data downloaded"; fi

awk '
/<Period>/ {
    capture_period = 1
}
/<\/Period>/ {
    capture_period = 0
}
capture_period && /<resolution>PT60M<\/resolution>/ {
    valid_period = 1
}
valid_period && /<price.amount>/ {
    gsub("<price.amount>", "", $0)
    gsub("<\/price.amount>", "", $0)
    gsub(/^[\t ]+|[\t ]+$/, "", $0)
    prices = prices $0 ORS
}
valid_period && /<\/Period>/ {
    exit
}


/<Reason>/ {
    in_reason = 1
    error_message = ""
}

in_reason && /<code>/ {
    gsub(/<code>|<\/code>/, "")
    gsub(/^[\t ]+|[\t ]+$/, "", $0)
    error_code = $0
}

in_reason && /<text>/ {
    gsub(/<text>|<\/text>/, "")
	gsub(/^[\t ]+|[\t ]+$/, "", $0)
    error_message = $0
}

/<\/Reason>/ {
    in_reason = 0
}

END {
    if (error_code == 999) {
        print "E: Entsoe data retrieval error:", error_message
        exit 1
    } else if (prices != "") {
        print prices > "'"$output_file"'"
    } else {
        print "E: No prices found in the XML data."
		exit 1
    }
}
' "$file"

	sort -g "$output_file" >"${output_file%.*}_sorted.${output_file##*.}"
	timestamp=$(TZ=$TZ date +%d)
	echo "date_now_day: $timestamp" >>"$output_file"
	#echo "date_now_day: $timestamp" >> "${output_file%.*}_sorted.${output_file##*.}"

	# Check if tomorrow file contains next day prices
	if [ "$include_second_day" = 1 ] && grep -q "PT60M" "$file" && [ "$(wc -l <"$output_file")" -gt 3 ]; then
		cat $file10 >$file8
		#    echo >> $file8
		if [ -f "$file13" ]; then
			cat "$file13" >>"$file8"
		fi
		sed -i '25d 50d' "$file8"
		sort -g "$file8" >"$file19"
		timestamp=$(TZ=$TZ date +%d)
		echo "date_now_day: $timestamp" >>"$file8"
	else
		cp $file11 $file19 # If no second day, copy sorted price file.
	fi
}

download_solarenergy() {
	if ((use_solarweather_api_to_abort == 1)); then
		delay=$((RANDOM % 15 + 1))
		if [ -z "$DEBUG" ]; then
			echo "I: Please be patient. A delay of $delay seconds will help avoid overloading the Solarweather-API."
			# Delaying a random time <=15s to reduce impact on site - download is not time-critical
			sleep "$delay"
		else
			echo "D: No delay of download of solarenergy data since DEBUG variable set." >&2
		fi
		if ! curl "$link3" -o "$file3"; then
			log_info "E: Download of solarenergy data from '$link3' failed."
			exit 1
		elif ! test -f "$file3"; then
			log_info "E: Could not get solarenergy data, missing file '$file3'."
			exit 1
		fi
		if [ -n "$DEBUG" ]; then
			echo "D: File3 $file3 downloaded" >&2
		fi
		if ! test -f "$file3"; then
			log_info "E: Could not find downloaded file '$file3' with solarenergy data."
			exit 1
		fi
		if [ -n "$DEBUG" ]; then
			echo "D: Solarenergy data downloaded to file '$file3'."
		fi
	fi
}

get_current_awattar_day() { current_awattar_day=$(sed -n 3p $file1 | grep -Eo '[0-9]+'); }
get_current_awattar_day2() { current_awattar_day2=$(sed -n 3p $file2 | grep -Eo '[0-9]+'); }

get_awattar_prices() {
	current_price=$(sed -n $((2 * $(TZ=$TZ date +%k) + 39))p $file1 | grep -Eo '[+-]?[0-9]+([.][0-9]+)?' | tail -n1)
	lowest_price=$(sed -n 1p "$file7")
	second_lowest_price=$(sed -n 2p "$file7")
	third_lowest_price=$(sed -n 3p "$file7")
	fourth_lowest_price=$(sed -n 4p "$file7")
	fifth_lowest_price=$(sed -n 5p "$file7")
	sixth_lowest_price=$(sed -n 6p "$file7")
	# highest_price=$(awk '/^[0-9]+(\.[0-9]+)?$/ && $1 > max { max = $1 } END { print max }' "$file7")
	# average_price=$(awk '/^[0-9]+(\.[0-9]+)?$/{sum+=$1; count++} END {if (count > 0) print sum/count}' "$file7")
	highest_price=$(grep -E '^[0-9]+\.[0-9]+$' "$file7" | tail -n1)
	average_price=$(grep -E '^[0-9]+\.[0-9]+$' "$file7" | awk '{sum+=$1; count++} END {if (count > 0) print sum/count}')
}

get_tibber_prices() {
	current_price=$(sed -n "${now_linenumber}s/.*\"${tibber_prices}\":\([^,]*\),.*/\1/p" "$file15")
	lowest_price=$(sed -n "1s/.*\"${tibber_prices}\":\([^,]*\),.*/\1/p" "$file12")
	second_lowest_price=$(sed -n "2s/.*\"${tibber_prices}\":\([^,]*\),.*/\1/p" "$file12")
	third_lowest_price=$(sed -n "3s/.*\"${tibber_prices}\":\([^,]*\),.*/\1/p" "$file12")
	fourth_lowest_price=$(sed -n "4s/.*\"${tibber_prices}\":\([^,]*\),.*/\1/p" "$file12")
	fifth_lowest_price=$(sed -n "5s/.*\"${tibber_prices}\":\([^,]*\),.*/\1/p" "$file12")
	sixth_lowest_price=$(sed -n "6s/.*\"${tibber_prices}\":\([^,]*\),.*/\1/p" "$file12")
	highest_price=$(sed -n "s/.*\"${tibber_prices}\":\([^,]*\),.*/\1/p" "$file12" | awk 'BEGIN {max = 0} {if ($1 > max) max = $1} END {print max}')
	average_price=$(sed -n "s/.*\"${tibber_prices}\":\([^,]*\),.*/\1/p" "$file12" | awk '{sum += $1} END {print sum/NR}')
}

get_current_entsoe_day() { current_entsoe_day=$(sed -n 25p "$file10" | grep -Eo '[0-9]+'); }

get_current_tibber_day() { current_tibber_day=$(sed -n 25p "$file15" | grep -Eo '[0-9]+'); }

get_entsoe_prices() {
	current_price=$(sed -n ${now_linenumber}p "$file10")
	lowest_price=$(sed -n 1p "$file19")
	second_lowest_price=$(sed -n 2p "$file19")
	third_lowest_price=$(sed -n 3p "$file19")
	fourth_lowest_price=$(sed -n 4p "$file19")
	fifth_lowest_price=$(sed -n 5p "$file19")
	sixth_lowest_price=$(sed -n 6p "$file19")
	highest_price=$(awk 'BEGIN {max = 0} $1>max {max=$1} END {print max}' "$file19")
	average_price=$(awk 'NF>0 && $1 ~ /^[0-9]*(\.[0-9]*)?$/ {sum+=$1; count++} END {if (count > 0) print sum/count}' "$file19")
}

convert_vars_to_integer() {
	local potency="$1"
	shift
	for var in "$@"; do
		local integer_var="${var}_integer"
		printf -v "$integer_var" '%s' "$(euroToMillicent "${!var}" "$potency")"
		if [ -n "$DEBUG" ]; then
			echo "D: Variable: $var | Original: ${!var} | Integer: ${!integer_var}" >&2
		fi
	done
}

get_awattar_prices_integer() {
	convert_vars_to_integer 15 lowest_price average_price highest_price second_lowest_price third_lowest_price fourth_lowest_price fifth_lowest_price sixth_lowest_price current_price stop_price start_price feedin_price energy_fee abort_price battery_lifecycle_costs_cent_per_kwh
}

get_tibber_prices_integer() {
	convert_vars_to_integer 17 lowest_price average_price highest_price second_lowest_price third_lowest_price fourth_lowest_price fifth_lowest_price sixth_lowest_price current_price
	convert_vars_to_integer 15 stop_price start_price feedin_price energy_fee abort_price battery_lifecycle_costs_cent_per_kwh
}

get_prices_integer_entsoe() {
	convert_vars_to_integer 14 lowest_price average_price highest_price second_lowest_price third_lowest_price fourth_lowest_price fifth_lowest_price sixth_lowest_price current_price
	convert_vars_to_integer 15 stop_price start_price feedin_price energy_fee abort_price battery_lifecycle_costs_cent_per_kwh
}

get_solarenergy_today() {
	solarenergy_today=$(sed '2!d' $file3 | cut -d',' -f2)
	solarenergy_today_integer=$(euroToMillicent "${solarenergy_today}" 15)
	abort_solar_yield_today_integer=$(euroToMillicent "${abort_solar_yield_today}" 15)
}

get_solarenergy_tomorrow() {
	solarenergy_tomorrow=$(sed '3!d' $file3 | cut -d',' -f2)
	solarenergy_tomorrow_integer=$(euroToMillicent "$solarenergy_tomorrow" 15)
	abort_solar_yield_tomorrow_integer=$(euroToMillicent "${abort_solar_yield_tomorrow}" 15)
}

get_cloudcover_today() {
	cloudcover_today=$(sed '2!d' $file3 | cut -d',' -f1)
}

get_cloudcover_tomorrow() {
	cloudcover_tomorrow=$(sed '3!d' $file3 | cut -d',' -f1)
}

get_sunrise_today() {
	sunrise_today=$(sed '2!d' $file3 | cut -d',' -f3 | cut -d 'T' -f2 | awk -F: '{ print $1 ":" $2 }')
}

get_sunset_today() {
	sunset_today=$(sed '2!d' $file3 | cut -d',' -f4 | cut -d 'T' -f2 | awk -F: '{ print $1 ":" $2 }')
}

get_suntime_today() {
	suntime_today=$((($(TZ=$TZ date -d "1970-01-01 $sunset_today" +%s) - $(TZ=$TZ date -d "1970-01-01 $sunrise_today" +%s)) / 60))
}

# Function to evaluate charging and switchablesockets conditions
evaluate_conditions() {
	local -n conditions_ref="$1"
	local -n descriptions_ref="$2"
	local -n execute_ref="$3"
	local -n condition_met_ref="$4"

	for condition in "${!conditions_ref[@]}"; do
		if [ -n "$DEBUG" ]; then
			result="( ${descriptions_ref[$condition]} ) evaluates to $([ "${conditions_ref[$condition]}" -eq 1 ] && echo true || echo false)"
			echo "D: condition_evaluation [ $result ]." >&2
		fi
		if ((conditions_ref[$condition])); then
			execute_ref=1
			condition_met_ref="$condition"
			break
		fi
	done
}

# Function to check economical
is_charging_economical() {
	# In the Bash scripting environment, true represents a command that always ends with a success status (exit code 0), and false is a command that always ends with a failure status (exit code 1).
	# In the context of comparisons or conditions in Bash:

	#    A success status (e.g. a command's exit code 0) is often interpreted as "true".
	#    A failure status (e.g. any exit code other than 0) is often interpreted as "false".

	# In many programming languages, true represents the value 1 and false represents the value 0, but in the Bash scripting environment things are a little different as it involves the exit code of commands.
	# For this reason, a value of 1 is output as false
 
	local reference_price="$1"
	local total_cost="$2"

	local is_economical=0
	[[ $reference_price -ge $total_cost ]] && is_economical=1

	if [ -n "$DEBUG" ]; then
		echo "D: is_charging_economical [ $is_economical - $([ "$is_economical" -eq 1 ] && echo "false" || echo "true") ]." >&2
  		echo "D: if [ reference_price ($reference_price) > total_cost ($total_cost) ]." >&2
	fi

	return $is_economical
}

# Function to manage charging
manage_charging() {
	local action=$1
	local reason=$2

	if [[ $action == "on" ]]; then
		$charger_command_turnon >/dev/null
		log_info "Victron scheduled charging is ON. Battery SOC is at $SOC_percent %. $reason"
	else
		$charger_command_turnoff >/dev/null
		log_info "Victron scheduled charging is OFF. Battery SOC is at $SOC_percent %. $reason"
	fi
}

# Function to check abort conditions and log a message
check_abort_condition() {
	local condition_result=$1
	local log_message=$2

	if ((condition_result)); then
		log_info "I: $log_message Abort."
		execute_charging=0
		execute_switchablesockets_on=0
	fi
}

# Function to manage sockets and log a message
manage_fritz_socket() {
	local action=$1
	local socket=$2
	local url="http://$fbox/webservices/homeautoswitch.lua?sid=$sid&ain=$socket&switchcmd=setswitch$action"
	curl -s "$url" >/dev/null || log_info "E: Could not call URL '$url' to switch $action said switch - ignored."
}

manage_shelly_socket() {
	local action=$1
	local ip=$2
	curl -s -u "$shellyuser:$shellypasswd" "http://$ip/relay/0?turn=$action" -o /dev/null || log_info "E: Could not execute switch-$action of Shelly socket with IP $ip - ignored."
}

if ((select_pricing_api == 1)); then
	# Test if Awattar today data exists
	if test -f "$file1"; then
		# Test if data is current
		get_current_awattar_day
		if [ "$current_awattar_day" = "$(TZ=$TZ date +%-d)" ]; then
			echo "I: aWATTar today-data is up to date."
		else
			echo "I: aWATTar today-data is outdated, fetching new data."
			rm -f $file1 $file6 $file7
			download_awattar_prices "$link1" "$file1" "$file6" $((RANDOM % 21 + 10))
		fi
	else # Data file1 does not exist
		echo "I: Fetching today-data data from aWATTar."
		download_awattar_prices "$link1" "$file1" "$file6" $((RANDOM % 21 + 10))
	fi

elif ((select_pricing_api == 2)); then
	# Test if Entsoe today data exists
	if test -f "$file10"; then
		# Test if data is current
		get_current_entsoe_day
		if [ "$current_entsoe_day" = "$(TZ=$TZ date +%d)" ]; then
			echo "I: Entsoe today-data is up to date."
		else
			echo "I: Entsoe today-data is outdated, fetching new data."
			rm -f "$file4" "$file5" "$file8" "$file9" "$file10" "$file11" "$file13" "$file19"
			download_entsoe_prices "$link4" "$file4" "$file10" $((RANDOM % 21 + 10))
		fi
	else # Entsoe data does not exist
		echo "I: Fetching today-data data from Entsoe."
		download_entsoe_prices "$link4" "$file4" "$file10" $((RANDOM % 21 + 10))
	fi

elif ((select_pricing_api == 3)); then

	# Test if Tibber today data exists
	if test -f "$file14"; then
		# Test if data is current
		get_current_tibber_day
		if [ "$current_tibber_day" = "$(TZ=$TZ date +%d)" ]; then
			echo "I: Tibber today-data is up to date."
		else
			echo "I: Tibber today-data is outdated, fetching new data."
			rm -f "$file14" "$file15" "$file16"
			download_tibber_prices "$link6" "$file14" $((RANDOM % 21 + 10))
		fi
	else # Tibber data does not exist
		echo "I: Fetching today-data data from Tibber."
		download_tibber_prices "$link6" "$file14" $((RANDOM % 21 + 10))
	fi
fi

millicentToEuro() {
    local millicents="$1"

    local EURO_FACTOR=1000000000000000
    local DECIMAL_FACTOR=100000000000

    local euro_main_part=$((millicents / EURO_FACTOR))
    local euro_decimal_part=$(((millicents % EURO_FACTOR) / DECIMAL_FACTOR))

    printf "%d.%04d\n" $euro_main_part $euro_decimal_part
}

euroToMillicent() {
	euro="$1"
	potency="$2"

	if [ -z "$potency" ]; then
		potency=14
	fi

	#if echo "$euro" | grep -q '\,'; then
	#	echo "E: Could not translate '$euro' to an integer since this has a comma when only a period is accepted as decimal separator."
	#	return 1
	#fi

	# Replace each comma with a period, fixme if this is wrong
	euro=$(echo "$euro" | sed 's/,/./g')

	if which bc >/dev/null 2>&1; then
		# Using bc to multiply the euro number and convert it to an integer
		v=$(echo "scale=0; $euro * 10^$potency / 1" | bc)
	else
		v=$(awk "BEGIN {print int($euro * (10 ^ $potency))}")
	fi

	if [ -z "$v" ]; then
		log_info "E: Could not translate '$euro' to an integer."
		log_info "E: Called from ${FUNCNAME[1]} at line ${BASH_LINENO[0]}"
		return 1
	fi
	echo "$v"
	return 0
}

# An independent segment to test the conversion of floats to integers
if [ "tests" == "$1" ]; then

	echo "I: Testing euroToMillicent"
	for i in 123456 12345.6 1234.56 123.456 12.3456 1.23456 0.123456 .123456 .233 .23 .2 2.33 2.3 2 2,33 2,3 2 23; do
		echo -n "$i -> "
		euroToMillicent $i
	done
	exit 0

fi

if ((include_second_day == 1)); then

	if ((select_pricing_api == 1)); then

		# Test if Awattar tomorrow data exists
		if test -f "$file2"; then
			# Test if data is current
			get_current_awattar_day2
			if [ "$current_awattar_day2" = "$(TZ=$TZ date +%-d)" ]; then
				echo "I: aWATTar tomorrow-data is up to date."
			else
				echo "I: aWATTar tomorrow-data is outdated, fetching new data."
				rm -f $file3
				download_awattar_prices "$link2" "$file2" "$file6" $((RANDOM % 21 + 10))
			fi
		else # Data file2 does not exist
			echo "I: aWATTar tomorrow-data does not exist, fetching data."
			download_awattar_prices "$link2" "$file2" "$file6" $((RANDOM % 21 + 10))
		fi

	elif ((select_pricing_api == 2)); then

		# Test if Entsoe tomorrow data exists
		if [ ! -s "$file9" ]; then
			echo "I: File '$file9' has no tomorrow data, we have to try it again until the new prices are online."
			rm -f "$file5" "$file9" "$file13"
			download_entsoe_prices "$link5" "$file5" "$file13" $((RANDOM % 21 + 10))
		fi

	elif ((select_pricing_api == 3)); then

		if [ ! -s "$file18" ]; then
			rm -f "$file17" "$file18"
			echo "I: File '$file18' has no tomorrow data, we have to try it again until the new prices are online."
			rm -f "$file12" "$file14" "$file15" "$file16" "$file17"
			download_tibber_prices "$link6" "$file14" $((RANDOM % 21 + 10))
			sort -t, -k1.9n $file17 >>"$file12"
		fi

	fi

fi # Include second day

if ((select_pricing_api == 1)); then
	Unit="Cent/kWh net"
	get_awattar_prices
	get_awattar_prices_integer
elif ((select_pricing_api == 2)); then
	Unit="EUR/MWh net"
	get_entsoe_prices
	get_prices_integer_entsoe
elif ((select_pricing_api == 3)); then
	Unit="EUR/kWh $tibber_prices price"
	get_tibber_prices
	get_tibber_prices_integer
fi

if ((use_solarweather_api_to_abort == 1)); then
	download_solarenergy
	get_solarenergy_today
	get_solarenergy_tomorrow
	get_cloudcover_today
	get_cloudcover_tomorrow
	get_sunrise_today
	get_sunset_today
	get_suntime_today
fi

printf "I: Please verify correct system time and timezone:\n   "
TZ=$TZ date | tee -a "$LOG_FILE"
echo
log_info "Current price is $current_price $Unit."
echo "Lowest price will be $lowest_price $Unit."
echo "The average price will be $average_price $Unit."
echo "Highest price will be $highest_price $Unit."
echo "Second lowest price will be $second_lowest_price $Unit."
echo "Third lowest price will be $third_lowest_price $Unit."
echo "Fourth lowest price will be $fourth_lowest_price $Unit."
echo "Fifth lowest price will be $fifth_lowest_price $Unit."
echo "Sixth lowest price will be $sixth_lowest_price $Unit."

if ((use_solarweather_api_to_abort == 1)); then
	log_info "Sunrise today will be $sunrise_today and sunset will be $sunset_today. Suntime will be $suntime_today minutes."
	log_info "Solarenergy today will be $solarenergy_today megajoule per sqaremeter with $cloudcover_today percent clouds."
	log_info "Solarenergy tomorrow will be $solarenergy_tomorrow megajoule per squaremeter with $cloudcover_tomorrow percent clouds."
	if [ ! -s $file3 ]; then
		echo "E: File '$file3' is empty, please check your API Key if download is still not possible tomorrow."
	fi
	find "$file3" -size 0 -delete # FIXME - looks wrong and complicated - simple RM included in prior if clause?
fi

# stop_price_integer cannot be found by shellcheck can be ignored, false positive
if ((use_start_stop_logic == 1 && stop_price_integer < start_price_integer)); then
	log_info "E: stop - price cannot be lower than start price"
	exit 1
fi

# abort_price_integer cannot be found by shellcheck can be ignored, false positive
if ((abort_price_integer <= current_price_integer)); then
	log_info "I: Current price is too high. Abort."
	exit 0
fi

declare -A charging_conditions_descriptions=(
	["use_start_stop_logic"]="use_start_stop_logic ($use_start_stop_logic) == 1 && start_price_integer ($start_price_integer) > current_price_integer ($current_price_integer)"
	["charge_at_solar_breakeven_logic"]="charge_at_solar_breakeven_logic ($charge_at_solar_breakeven_logic) == 1 && feedin_price_integer ($feedin_price_integer) > current_price_integer ($current_price_integer) + energy_fee_integer ($energy_fee_integer)"
	["charge_at_lowest_price"]="charge_at_lowest_price ($charge_at_lowest_price) == 1 && lowest_price_integer ($lowest_price_integer) == current_price_integer ($current_price_integer)"
	["charge_at_second_lowest_price"]="charge_at_second_lowest_price ($charge_at_second_lowest_price) == 1 && second_lowest_price_integer ($second_lowest_price_integer) == current_price_integer ($current_price_integer)"
	["charge_at_third_lowest_price"]="charge_at_third_lowest_price ($charge_at_third_lowest_price) == 1 && third_lowest_price_integer ($third_lowest_price_integer) == current_price_integer ($current_price_integer)"
	["charge_at_fourth_lowest_price"]="charge_at_fourth_lowest_price ($charge_at_fourth_lowest_price) == 1 && fourth_lowest_price_integer ($fourth_lowest_price_integer) == current_price_integer ($current_price_integer)"
	["charge_at_fifth_lowest_price"]="charge_at_fifth_lowest_price ($charge_at_fifth_lowest_price) == 1 && fifth_lowest_price_integer ($fifth_lowest_price_integer) == current_price_integer ($current_price_integer)"
	["charge_at_sixth_lowest_price"]="charge_at_sixth_lowest_price ($charge_at_sixth_lowest_price) == 1 && sixth_lowest_price_integer ($sixth_lowest_price_integer) == current_price_integer ($current_price_integer)"
)

declare -A charging_conditions=(
	["use_start_stop_logic"]=$((use_start_stop_logic == 1 && start_price_integer > current_price_integer))
	["charge_at_solar_breakeven_logic"]=$((charge_at_solar_breakeven_logic == 1 && feedin_price_integer > current_price_integer + energy_fee_integer))
	["charge_at_lowest_price"]=$((charge_at_lowest_price == 1 && lowest_price_integer == current_price_integer))
	["charge_at_second_lowest_price"]=$((charge_at_second_lowest_price == 1 && second_lowest_price_integer == current_price_integer))
	["charge_at_third_lowest_price"]=$((charge_at_third_lowest_price == 1 && third_lowest_price_integer == current_price_integer))
	["charge_at_fourth_lowest_price"]=$((charge_at_fourth_lowest_price == 1 && fourth_lowest_price_integer == current_price_integer))
	["charge_at_fifth_lowest_price"]=$((charge_at_fifth_lowest_price == 1 && fifth_lowest_price_integer == current_price_integer))
	["charge_at_sixth_lowest_price"]=$((charge_at_sixth_lowest_price == 1 && sixth_lowest_price_integer == current_price_integer))
)

charging_condition_met=""
execute_charging=0
execute_switchablesockets_on=0

# Check if any charging condition is met
evaluate_conditions charging_conditions charging_conditions_descriptions execute_charging charging_condition_met

declare -A switchablesockets_conditions_descriptions=(
	["switchablesockets_at_start_stop"]="switchablesockets_at_start_stop ($switchablesockets_at_start_stop) == 1 && start_price_integer ($start_price_integer) > current_price_integer ($current_price_integer)"
	["switchablesockets_at_solar_breakeven_logic"]="switchablesockets_at_solar_breakeven_logic ($switchablesockets_at_solar_breakeven_logic) == 1 && feedin_price_integer ($feedin_price_integer) > current_price_integer ($current_price_integer) + energy_fee_integer ($energy_fee_integer)"
	["switchablesockets_at_lowest_price"]="switchablesockets_at_lowest_price ($switchablesockets_at_lowest_price) == 1 && lowest_price_integer ($lowest_price_integer) == current_price_integer ($current_price_integer)"
	["switchablesockets_at_second_lowest_price"]="switchablesockets_at_second_lowest_price ($switchablesockets_at_second_lowest_price) == 1 && second_lowest_price_integer ($second_lowest_price_integer) == current_price_integer ($current_price_integer)"
	["switchablesockets_at_third_lowest_price"]="switchablesockets_at_third_lowest_price ($switchablesockets_at_third_lowest_price) == 1 && third_lowest_price_integer ($third_lowest_price_integer) == current_price_integer ($current_price_integer)"
	["switchablesockets_at_fourth_lowest_price"]="switchablesockets_at_fourth_lowest_price ($switchablesockets_at_fourth_lowest_price) == 1 && fourth_lowest_price_integer ($fourth_lowest_price_integer) == current_price_integer ($current_price_integer)"
	["switchablesockets_at_fifth_lowest_price"]="switchablesockets_at_fifth_lowest_price ($switchablesockets_at_fifth_lowest_price) == 1 && fifth_lowest_price_integer ($fifth_lowest_price_integer) == current_price_integer ($current_price_integer)"
	["switchablesockets_at_sixth_lowest_price"]="switchablesockets_at_sixth_lowest_price ($switchablesockets_at_sixth_lowest_price) == 1 && sixth_lowest_price_integer ($sixth_lowest_price_integer) == current_price_integer ($current_price_integer)"
)

declare -A switchablesockets_conditions=(
	["switchablesockets_at_start_stop"]=$((switchablesockets_at_start_stop == 1 && start_price_integer > current_price_integer))
	["switchablesockets_at_solar_breakeven_logic"]=$((switchablesockets_at_solar_breakeven_logic == 1 && feedin_price_integer > current_price_integer + energy_fee_integer))
	["switchablesockets_at_lowest_price"]=$((switchablesockets_at_lowest_price == 1 && lowest_price_integer == current_price_integer))
	["switchablesockets_at_second_lowest_price"]=$((switchablesockets_at_second_lowest_price == 1 && second_lowest_price_integer == current_price_integer))
	["switchablesockets_at_third_lowest_price"]=$((switchablesockets_at_third_lowest_price == 1 && third_lowest_price_integer == current_price_integer))
	["switchablesockets_at_fourth_lowest_price"]=$((switchablesockets_at_fourth_lowest_price == 1 && fourth_lowest_price_integer == current_price_integer))
	["switchablesockets_at_fifth_lowest_price"]=$((switchablesockets_at_fifth_lowest_price == 1 && fifth_lowest_price_integer == current_price_integer))
	["switchablesockets_at_sixth_lowest_price"]=$((switchablesockets_at_sixth_lowest_price == 1 && sixth_lowest_price_integer == current_price_integer))
)

# Check if any switching condition is met
evaluate_conditions switchablesockets_conditions switchablesockets_conditions_descriptions execute_switchablesockets_on switchablesockets_condition_met

if ((use_solarweather_api_to_abort == 1)); then
	check_abort_condition $((abort_suntime <= suntime_today)) "There are enough sun minutes today."
	check_abort_condition $((abort_solar_yield_today_integer <= solarenergy_today_integer)) "There is enough solarenergy today."
	check_abort_condition $((abort_solar_yield_tomorrow_integer <= solarenergy_tomorrow_integer)) "There is enough sun tomorrow."
fi

# If any charging condition is met, start charging
percent_of_current_price_integer=$(awk "BEGIN {print $current_price_integer*$energy_loss_percent/100}" | printf "%.0f")
total_cost=$((current_price_integer + percent_of_current_price_integer + battery_lifecycle_costs_cent_per_kwh_integer))

if ((execute_charging == 1 && use_victron_charger == 1)); then
	if [ "$economic_check" -eq 0 ]; then
		manage_charging "on" "Charging based on condition met of: $charging_condition_met."
	elif [ "$economic_check" -eq 1 ] && is_charging_economical $highest_price_integer $total_cost; then
		manage_charging "on" "Charging based on highest price ($highest_price €) comparison makes sense. total_cost=$(millicentToEuro "$total_cost") €"
	elif [ "$economic_check" -eq 2 ] && is_charging_economical $average_price_integer $total_cost; then
		manage_charging "on" "Charging based on average price ($average_price €) comparison makes sense. total_cost=$(millicentToEuro "$total_cost") €"
	else
		manage_charging "off" "Considering charging losses and costs, charging is too expensive."
	fi
elif ((execute_charging != 1 && use_victron_charger == 1)); then
	manage_charging "off" "Charging was not executed."
fi

# Execute Fritz DECT on command
if ((use_fritz_dect_sockets == 1)); then
	# Get session ID (SID)
	sid=""
	challenge=$(curl -s "http://$fbox/login_sid.lua" | grep -o "<Challenge>[a-z0-9]\{8\}" | cut -d'>' -f 2)
	if [ -z "$challenge" ]; then
		log_info "E: Could not retrieve challenge from login_sid.lua."
		exit 1
	fi

	hash=$(echo -n "$challenge-$passwd" | sed -e 's,.,&\n,g' | tr '\n' '\0' | md5sum | grep -o "[0-9a-z]\{32\}")
	sid=$(curl -s "http://$fbox/login_sid.lua" -d "response=$challenge-$hash" -d "username=$user" |
		grep -o "<SID>[a-z0-9]\{16\}" | cut -d'>' -f 2)

	if [ "$sid" = "0000000000000000" ]; then
		log_info "E: Login to Fritz!Box failed."
		exit 1
	fi

	if [ -n "$DEBUG" ]; then
		echo "D: Login to Fritz!Box successful." >&2
	fi

	if ((execute_switchablesockets_on == 1)); then
		log_info "Turning ON Fritz sockets."
		for socket in "${sockets[@]}"; do
			[ "$socket" != "0" ] && manage_fritz_socket "on" "$socket"
		done
	else
		log_info "Turning OFF Fritz sockets."
		for socket in "${sockets[@]}"; do
			[ "$socket" != "0" ] && manage_fritz_socket "off" "$socket"
		done
	fi
fi

action_for_shelly_sockets=$([ "$execute_switchablesockets_on" == "1" ] && echo "on" || echo "off")
if ((use_shelly_wlan_sockets == 1)); then
	log_info "Turning $action_for_shelly_sockets Shelly sockets."
	for ip in "${shelly_ips[@]}"; do
		[ "$ip" != "0" ] && manage_shelly_socket "$action_for_shelly_sockets" "$ip"
	done
fi

echo >>"$LOG_FILE"

# Rotating log files
if [ -f "$LOG_FILE" ]; then
	if [ "$(du -k "$LOG_FILE" | awk '{print $1}')" -gt "$LOG_MAX_SIZE" ]; then
		mv "$LOG_FILE" "${LOG_FILE}.$(date +%Y%m%d%H%M%S)"
		touch "$LOG_FILE"
		find . -maxdepth 1 -name "${LOG_FILE}*" -type f -exec ls -1t {} + |
			sed 's|^\./||' |
			tail -n +$((LOG_FILES_TO_KEEP + 1)) |
			xargs --no-run-if-empty rm
	fi
fi

if [ -n "$DEBUG" ]; then
	echo "D: [ OK ]" >&2
fi
