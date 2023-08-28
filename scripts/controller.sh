#!/bin/bash

License=$(cat <<EOLICENSE
MIT License

Copyright (c) 2023 christian1980nrw

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
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

SIEHE AUCH

  README_de.md
  Homepage des Projekts auf https://github.com/christian1980nrw/Spotmarket-Switcher

WICHTIG - Haftungsausschluss (Disclaimer) und Lizenz

  Dieses Computerprogramm wird "wie es ist" bereitgestellt, und der Nutzer trägt das volle Risiko bei der Nutzung. Der Autor übernimmt keine Gewährleistung für die Genauigkeit, Zuverlässigkeit, Vollständigkeit oder Brauchbarkeit des Programms für irgendeinen bestimmten Zweck. Der Autor haftet weder für Schäden, die sich aus der Nutzung oder Unfähigkeit zur Nutzung des Programms ergeben, noch für Schäden, die aufgrund von Fehlern oder Mängeln des Programms entstehen. Dies gilt auch für Schäden, die aufgrund von Verletzungen von Pflichten im Rahmen einer vertraglichen oder außervertraglichen Verpflichtung entstehen.

$(echo "$License" | sed -e 's/^/  /')

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

SEE ALSO

  README_de.md
  Project homepage on https://github.com/christian1980nrw/Spotmarket-Switcher

IMPORTANT - Disclaimer and License

$(echo "$License" | sed -e 's/^/  /')

SUPPORT

  Please support this project and contribute to further development: https://revolut.me/christqki2 or https://paypal.me/christian1980nrw. If you live in Germany and wish to switch to a dynamic electricity tariff, you can support me and sign up for the tariff through the following link. We both receive a 50 Euro bonus for hardware. Visit https://invite.tibber.com/ojgfbx2e. In the Tibber app, click "I was invited" and enter the code ojgfbx2e in the app. Please note that you need a smart meter or a tracker like Pulse https://tibber.com/de/store/produkt/pulse-ir for an hourly tariff. Enter the first 4 digits of your meter number on that website to check Pulse compatibility. Of course, you can use your bonus for the Pulse order. Wait until the delivery date is confirmed and the bonus is credited.

  If you happen to need a cheap natural gas tariff or are not convinced to choose the dynamic Tibber tariff, you can still support this project and choose a classic electricity tariff using the following link to get a 50 Euro voucher for yourself and a 50 Euro bonus for this project: https://share.octopusenergy.de/glass-raven-58.
EOHELP
  fi

  exit

fi

																																  


				  

##### Configuration part...
#
# Note: This script is only for hourly-based tariff data, please create your own fork for higher resolutions like 15 minute intervals.
#       After an API reconfiguration please delete the old API-Downloadfiles with rm /tmp/awattar*.* /tmp/entsoe*.*

# Switchable Sockets Setup (AVM Fritz DECT200/210 wireless sockets) if used (tested with FRITZ!OS: 07.29).
use_fritz_dect_sockets=0 # please activate with 1 or deactivate this socket-type with 0
fbox="192.168.178.1"
user="fritz1234"
passwd="YOURPASSWORD"
sockets=("YOURSOCKETID" "0" "0" "0" "0" "0")

# Switchable Sockets Setup (Shelly Wifi Plugs) (tested with Shelly Plug S Firmware 20230109-114426/v1.12.2-g32055ee)
use_shelly_wlan_sockets=0  # please activate with 1 or deactivate this socket-type with 0
shelly_ips=("192.168.178.89" "0" "0") # add multiple Shellys if you like, dont forget to make the ips static in your router
shellyuser="admin"
shellypasswd="YOURPASSWORD" # only if used

# Solar Charger Setup (tested with Victron Venus OS)
use_victron_charger=0 # please activate with 1 or deactivate this charger-type with 0
if [ 0 -lt $use_victron_charger ]; then
  charger_command_turnon="dbus -y com.victronenergy.settings /Settings/CGwacs/BatteryLife/Schedule/Charge/0/Day SetValue -- 7"
  charger_command_turnoff="dbus -y com.victronenergy.settings /Settings/CGwacs/BatteryLife/Schedule/Charge/0/Day SetValue -- -7"
  if [ -z "$DEBUG" ]; then
    SOC_percent=$(dbus-send --system --print-reply --dest=com.victronenergy.system /Dc/Battery/Soc com.victronenergy.BusItem.GetValue | grep variant | awk '{print $3}') # This will get the battery state of charge (SOC) from a Victron Energy system
  fi
fi
energy_loss_percent=23.3 # Enter how much percent of the energy is lost by the charging and discharging process. Current and highest price will be compared and aborted if charging makes no sense.

#Please change prices (always use Cent/kWh, no matter if youre using Awattar (displaying Cent/kWh) or Entsoe API (displaying EUR/MWh) / net prices excl. tax).
stop_price=4.1 # stop above this price
start_price=2.0 # start below this price
feedin_price=9.87 # your feed-in-tariff of your solar system
energy_fee=15.3 # proofs of origin, allocations, duties and taxes (in case if stock price is at 0 Cent/kWh)
abort_price=50.1 # abort and never charge if actual price is same or higher than this (Energy fees not included)

use_start_stop_logic=0 # Set to 1 to activate start/stop logic (start_stop_price).
switchablesockets_at_start_stop=0 # You can add a additional load (like water heater) with AVM Fritz DECT200/210 switch sockets if you like.
charge_at_solar_breakeven_logic=0 # Charge if energy including fees is cheaper than your own feedin-tariff of your solar system
switchablesockets_at_solar_breakeven_logic=0
charge_at_lowest_price=0 # set 1 to charge at lowest price per day no matter which start/stop price was defined
switchablesockets_at_lowest_price=0
charge_at_second_lowest_price=0
switchablesockets_at_second_lowest_price=0
charge_at_third_lowest_price=0
switchablesockets_at_third_lowest_price=0
charge_at_fourth_lowest_price=0
switchablesockets_at_fourth_lowest_price=0
charge_at_fifth_lowest_price=0
switchablesockets_at_fifth_lowest_price=0
charge_at_sixth_lowest_price=0
switchablesockets_at_sixth_lowest_price=0
TZ='Europe/Amsterdam' # Set Correct Timezone
select_pricing_api=1 # Set to 1 for aWATTar or 2 for entsoe or 3 for Tibber / aWATTar: only germany DE-LU or Austrian AT prices, but no API key needed / Entsoe: Many more countrys available but free API key needed, see https://www.entsoe.eu/data/map/
include_second_day=0 # Set to 0 to compare only the today prices.
# Set include_second_day to 1 to compare today & tomorrow prices if they become available (today in the afternoon).
# Please note: If you activate this and the prices decrease over several days,
# it is possible that there will be no charging or switching for several days until the lowest prices are reached.

# Please set up Solar weather API to query solar yield
use_solarweather_api_to_abort=0
abort_solar_yield_today=4.5 # Abort and never charge because we are expecting enough sun today (daily megajoule per squaremeter)
abort_solar_yield_tomorrow=5.5 # Abort and never charge because we are expecting enough sun tomorrow (daily megajoule per squaremeter)
#To find the kilowatt hour value from megajoules, divide by 3.6.
abort_suntime=700 # Abort and never charge if we have more sun minutes per day as this value (time in minutes between sunrise and sunset)
latitude=51.530600 # Your location
longitude=7.860575
#You can use Google Maps to find the latitude and longitude of a location by searching for the address or location and then right-clicking
#on the location on the map. A pop-up menu will appear with the option to "What's here?" which will display the latitude and longitude of that location.
visualcrossing_api_key=YOURAPIKEY # Get your free key at https://www.visualcrossing.com/sign-up No credit card is required to sign up for your free 1000 records per day.

# Awattar API setup
awattar=de # Set to de for Germany or at for Austria (no other countrys available, for other countrys use Entsoe API)

# Entsoe API setup
# To find out your in and out domain key, go to https://www.entsoe.eu/data/energy-identification-codes-eic/eic-area-codes-map/ to find the Bidding Zone or open https://eepublicdownloads.entsoe.eu/clean-documents/EDI/Library/Market_Areas_v2.1.pdf and get the Market Balance Area code of your country.
in_Domain=10Y1001A1001A82H # this is for Germany DE-LU
out_Domain=10Y1001A1001A82H # Example: Spain is 10YES-REE------0
entsoe_eu_api_security_token=YOURAPIKEY
# How to get the free api_security_token: Go to https://transparency.entsoe.eu/ , click Login --> Register and create a Account. After that
# send an email to transparency@entsoe.eu with “Restful API access” in the subject line.
# Indicate the email address you entered during registration in the email body.
# The ENTSO-E Helpdesk will make their best efforts to respond to your request within 3 working days.
# After That you can generate a security token at https://transparency.entsoe.eu/usrm/user/myAccountSettings
# The ENTSO-E Transparency Platform aims to provide free, continuous access to pan-European electricity market data for all users.

# Tibber API setup
# To get the tibber_api_key please log in with a free or customer Tibber account at https://developer.tibber.com/settings/access-token . After that create a token by selecting the scopes you need (select "price").
# Use this link to create a free account with your smartphone. https://tibber.com/de/invite/ojgfbx2e
# Currently no contract is needed to create a free Account that is able to access the API.
# Put your API Key into the function below.

tibber_prices=energy # Set to "energy" to use the spotmarket-prices (default), set to "total" to use the total prices including taxes and fees, set to "tax" to use only the taxes and fees

get_tibber_api() {
    curl --location --request POST 'https://api.tibber.com/v1-beta/gql' \
    --header 'Content-Type: application/json'  \
    --header 'Authorization: Bearer YOUR_API_KEY_HERE'  \
    --data-raw '{"query":"{viewer{homes{currentSubscription{priceInfo{current{total energy tax startsAt}today{total energy tax startsAt}tomorrow{total energy tax startsAt}}}}}}"}' \
    | awk '{
        gsub(/"current":/, "\n&");
        gsub(/"today":/, "\n&");
        gsub(/"tomorrow":/, "\n&");
        gsub(/"total":/, "\n&");
        print
    }'
}

# further API parameters (no need to edit)
yesterday=$(TZ=$TZ date -d @$(( $(TZ=$TZ date +"%s") - 86400)) +%d)2300
yestermonth=$(TZ=$TZ date -d @$(( $(TZ=$TZ date +"%s") - 86400)) +%m)
yesteryear=$(TZ=$TZ date -d @$(( $(TZ=$TZ date +"%s") - 86400)) +%Y)
today=$(TZ=$TZ date -d @$(( $(TZ=$TZ date +"%s") )) +%d)2300
today2=$(TZ=$TZ date -d @$(( $(TZ=$TZ date +"%s") )) +%d)
todaymonth=$(TZ=$TZ date -d @$(( $(TZ=$TZ date +"%s") )) +%m)
todayyear=$(TZ=$TZ date -d @$(( $(TZ=$TZ date +"%s") )) +%Y)
tomorrow=$(TZ=$TZ date -d @$(( $(TZ=$TZ date +"%s") + 86400)) +%d)2300
tomorrow2=$(TZ=$TZ date -d @$(( $(TZ=$TZ date +"%s") + 86400)) +%d)
tomorrowmonth=$(TZ=$TZ date -d @$(( $(TZ=$TZ date +"%s") + 86400)) +%m)
tomorrowyear=$(TZ=$TZ date -d @$(( $(TZ=$TZ date +"%s") + 86400)) +%Y)
getnow=$(TZ=$TZ date -d @$(( $(TZ=$TZ date +"%s") )) +%k)
now_linenumber=$((getnow+1))
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
  LOG_FILE="/data/etc/Spotmarket-Switcher/spotmarket-switcher.log"
fi
if [ -z "$LOG_MAX_SIZE" ]; then
  LOG_MAX_SIZE=1000 # 1 MB
fi
if [ -z "$LOG_FILES_TO_KEEP" ]; then
  LOG_FILES_TO_KEEP=2
fi

########## Testing series of preconditions prior to execution of script

num_tools_missing=0
tools="awk curl cat sed sort head tail"
if [ 0 -lt $use_victron_charger ]; then
  tools="$tools dbus"
fi

for tool in $tools
do
  if ! which "$tool" > /dev/null; then
    echo "E: Please ensure the tool '$tool' is found."
    num_tools_missing=$((num_tools_missing+1))
    exit 1
  fi
done
if [ 0 -lt $num_tools_missing ]; then
  echo "E: Found $num_tools_missing tool(s) missing."
  exit 1
fi
unset num_tools_missing

########## Begin of the script...

echo >> "$LOG_FILE"
if [ 0 -lt "$use_victron_charger" ]; then
  echo "I: Maybe we are still charging from this script's previous run. Stopping scheduled charging. Battery SOC is at $SOC_percent %." | tee -a "$LOG_FILE"
  $charger_command_turnoff
fi

download_awattar_prices() {
  local url="$1"
  local file="$2"
  local output_file="$3"
  local sleep_time="$4"

  if [ -z "$DEBUG" ]; then
    echo "I: Please be patient. First we wait $sleep_time seconds in case the system clock is not syncronized and not to overload the API."
    sleep "$sleep_time"
  fi
  if ! curl "$url" > "$file"; then
    echo "E: Download of aWATTar prices from '$url' to '$file' failed."
    exit 1
  fi

  if ! test -f "$file"; then
    echo "E: Could not get aWATTar prices from '$url' to feed file '$file'."
    exit 1
  fi

  if [ -n "$DEBUG" ]; then
    echo "D: Download of file '$file' from URL '$url' successful."
  fi
  echo >> "$file"
  awk '/data_price_hour_rel_.*_amount: / {print substr($0, index($0, ":") + 2)}' "$file" > "$output_file"
  sort -g "$output_file" > "${output_file%.*}_sorted.${output_file##*.}"
  timestamp=$(TZ=$TZ date +%d)
  echo "date_now_day: $timestamp" >> "$output_file"
  echo "date_now_day: $timestamp" >> "${output_file%.*}_sorted.${output_file##*.}"

  if [ -f "$file2" ] && [ "$( wc -l < "$file1" )" = "$( wc -l < "$file2" )" ]; then
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
  fi
  if ! get_tibber_api | tr -d '{}[]' > "$file"; then
    echo "E: Download of Tibber prices from '$url' to '$file' failed."
    exit 1
  fi

  sed -n '/"today":/,/"tomorrow":/p' "$file" | sed '$d' | sed '/"today":/d' > "$file15"
  sort -t, -k1.9n $file15 > "$file16"
  sed -n '/"tomorrow":/,$p' "$file" | sed '/"tomorrow":/d' > "$file17"
  sort -t, -k1.9n $file17 > "$file18"
  if [ "$include_second_day" = 0 ]; then
  cp "$file16" "$file12"
  else
  grep '"total"' "$file14" | sort -t':' -k2 -n > "$file12"
  fi

  timestamp=$(TZ=$TZ date +%d)
  echo "date_now_day: $timestamp" >> "$file15"
  echo "date_now_day: $timestamp" >> "$file17"

  if [ ! -s "$file16" ]; then
    echo "E: Tibber prices cannot be extracted to '$file16', please check your Tibber API Key."
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
  fi

  if ! curl "$url" > "$file"; then
    echo "E: Retrieval of entsoe data from '$url' into file '$file' failed."
    exit 1
  fi

  if ! test -f "$file"; then
    echo "E: Could not find file '$file' with entsoe price data. Curl itself reported success."
    exit 1
  fi

  if [ -n "$DEBUG" ]; then echo "D: Entsoe file '$file' with price data downloaded"; fi

  if [ ! -s "$file" ]; then
    echo "E: Entsoe file '$file' is empty, please check your entsoe API Key."
    exit 1
  fi

  if [ -n "$DEBUG" ]; then echo "D: Entsoe file '$file' with price data downloaded"; fi

awk '
    /<Period>/ { capture=1 }
    /<\/Period>/ { capture=0 }
    capture && /<resolution>PT60M<\/resolution>/ { valid_period=1 }
    valid_period && /<price.amount>/ {
        gsub("<price.amount>", "", $0)
        gsub("<\/price.amount>", "", $0)
        gsub(/^[\t ]+|[\t ]+$/, "", $0)
        print $0
    }
    valid_period && /<\/Period>/ { exit }
' "$file" > "$output_file"

  sort -g "$output_file" > "${output_file%.*}_sorted.${output_file##*.}"
  timestamp=$(TZ=$TZ date +%d)
  echo "date_now_day: $timestamp" >> "$output_file"
  #echo "date_now_day: $timestamp" >> "${output_file%.*}_sorted.${output_file##*.}"

  # Check if tomorrow file contains next day prices
  if [ "$include_second_day" = 1 ] && grep -q "PT60M" "$file" && [ "$(wc -l < "$output_file")" -gt 3 ]; then
    cat $file10 > $file8
#    echo >> $file8
    if [ -f "$file13" ]; then
      cat "$file13" >> "$file8"
    fi
    sed -i '25d 50d' "$file8"
    sort -g "$file8" > "$file19"
    timestamp=$(TZ=$TZ date +%d)
    echo "date_now_day: $timestamp" >> "$file8"

  fi
}

function download_solarenergy {
  if (( use_solarweather_api_to_abort == 1 )); then
    echo "I: Please be patient. First we wait some seconds so that we will not overload the Solarweather-API."
    # Delaying a random time <=15s to reduce impact on site - download is not time-critical
    sleep $(( RANDOM % 15 + 1 ))
    if ! curl "$link3" -o "$file3"; then
      echo "E: Download of solarenergy data from '$link3' failed."
      exit 1
    elif ! test -f "$file3"; then
      echo "E: Could not get solarenergy data, missing file '$file3'."
      exit 1
    fi
    if [ -n "$DEBUG" ]; then
      echo "D: File3 $file3 downloaded"
    fi
    if ! test -f "$file3"; then
      echo "E: Could not find downloaded file '$file3' with solarenergy data."
      exit 1
    fi
    if [ -n "$DEBUG" ]; then
      echo "D: Solarenergy data downloaded to file '$file3'."
    fi
  fi
}

function get_current_awattar_day { current_awattar_day=$(sed -n 3p $file1 | grep -Eo '[0-9]+'); }
function get_current_awattar_day2 { current_awattar_day2=$(sed -n 3p $file2 | grep -Eo '[0-9]+'); }

function get_awattar_prices {
  current_price=$(sed -n $((2*$(TZ=$TZ date +%k)+39))p $file1 | grep -Eo '[+-]?[0-9]+([.][0-9]+)?' | tail -n1)
  lowest_price=$(sed -n 1p "$file7")
  second_lowest_price=$(sed -n 2p "$file7")
  third_lowest_price=$(sed -n 3p "$file7")
  fourth_lowest_price=$(sed -n 4p "$file7")
  fifth_lowest_price=$(sed -n 5p "$file7")
  sixth_lowest_price=$(sed -n 6p "$file7")
  highest_price=$(awk '/^[0-9]+(\.[0-9]+)?$/ && $1 > max { max = $1 } END { print max }' "$file7")
  average_price=$(awk '/^[0-9]+(\.[0-9]+)?$/{sum+=$1; count++} END {if (count > 0) print sum/count}' "$file7")
}

function get_tibber_prices {
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


function get_current_entsoe_day { current_entsoe_day=$(sed -n 25p "$file10" | grep -Eo '[0-9]+'); }

function get_current_tibber_day { current_tibber_day=$(sed -n 25p "$file15" | grep -Eo '[0-9]+'); }

function get_entsoe_prices {
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

function get_awattar_prices_integer {
  for var in lowest_price highest_price second_lowest_price third_lowest_price fourth_lowest_price fifth_lowest_price sixth_lowest_price current_price stop_price start_price feedin_price energy_fee abort_price
  do
    integer_var="${var}_integer"
    eval "$integer_var"="$(euroToMillicent "${!var}" 15)"
  done
}

function get_tibber_prices_integer {
  for var in lowest_price highest_price second_lowest_price third_lowest_price fourth_lowest_price fifth_lowest_price sixth_lowest_price current_price stop_price start_price feedin_price energy_fee abort_price
  do
    integer_var="${var}_integer"
    eval "$integer_var"="$(euroToMillicent "${!var}" 16)"
  done
}

# We have to convert entsoe integer prices equivalent to Cent/kwH
function get_prices_integer_entsoe {
  for var in lowest_price highest_price second_lowest_price third_lowest_price fourth_lowest_price fifth_lowest_price sixth_lowest_price current_price
  do
    integer_var="${var}_integer"
    eval "$integer_var"="$(euroToMillicent "${!var}" 14)"
  done

  for var in stop_price start_price feedin_price energy_fee abort_price
  do
    integer_var="${var}_integer"
    eval "$integer_var"="$(euroToMillicent "${!var}" 15)"
  done
}

function get_solarenergy_today {
  solarenergy_today=$(sed '2!d' $file3 | cut -d',' -f2)
  solarenergy_today_integer=$(euroToMillicent "${solarenergy_today}" 15)
  abort_solar_yield_today_integer=$(euroToMillicent "${abort_solar_yield_today}" 15)
}
function get_solarenergy_tomorrow {
  solarenergy_tomorrow=$(sed '3!d' $file3 | cut -d',' -f2)
  solarenergy_tomorrow_integer=$(euroToMillicent "$solarenergy_tomorrow" 15)
  abort_solar_yield_tomorrow_integer=$(euroToMillicent "${abort_solar_yield_tomorrow}" 15)
}
function get_cloudcover_today {
  cloudcover_today=$(sed '2!d' $file3 | cut -d',' -f1)
}
function get_cloudcover_tomorrow {
  cloudcover_tomorrow=$(sed '3!d' $file3 | cut -d',' -f1)
}
function get_sunrise_today {
  sunrise_today=$(sed '2!d' $file3 | cut -d',' -f3 | cut -d 'T' -f2 | awk -F: '{ print $1 ":" $2 }')
}
function get_sunset_today {
  sunset_today=$(sed '2!d' $file3 | cut -d',' -f4 | cut -d 'T' -f2 | awk -F: '{ print $1 ":" $2 }')
}
function get_suntime_today {
  suntime_today=$(( ($(TZ=$TZ date -d "1970-01-01 $sunset_today" +%s) - $(TZ=$TZ date -d "1970-01-01 $sunrise_today" +%s)) / 60))
}


if (( select_pricing_api == 1 )); then

  # Test if Awattar today data exists
  if test -f "$file1"; then
    # Test if data is current
    get_current_awattar_day
    if [ "$current_awattar_day" = "$(TZ=$TZ date +%-d)" ]; then
      echo "I: aWATTar today-data is up to date."
    else
      echo "I: aWATTar today-data is outdated, fetching new data."
      rm -f $file1 $file6 $file7
      download_awattar_prices "$link1" "$file1" "$file6" $(( RANDOM % 21 + 10 ))
    fi
  else # Data file1 does not exist
    echo "I: Fetching today-data data from aWATTar."
    download_awattar_prices "$link1" "$file1" "$file6" $(( RANDOM % 21 + 10 ))
  fi
  
elif (( select_pricing_api == 2 )); then
  # Test if Entsoe today data exists
  if test -f "$file8"; then
    # Test if data is current
    get_current_entsoe_day
    if [ "$current_entsoe_day" = "$(TZ=$TZ date +%d)" ]; then
      echo "I: Entsoe today-data is up to date."
    else
	  echo "I: Entsoe today-data is outdated, fetching new data."
      rm -f "$file4" "$file5" "$file8" "$file9" "$file10" "$file11" "$file13" "$file19"
      download_entsoe_prices "$link4" "$file4" "$file10" $(( RANDOM % 21 + 10 ))
    fi
  else # Entsoe data does not exist
        echo "I: Fetching today-data data from Entsoe."
      download_entsoe_prices "$link4" "$file4" "$file10" $(( RANDOM % 21 + 10 ))
  fi											

elif (( select_pricing_api == 3 )); then

  # Test if Tibber today data exists
  if test -f "$file14"; then
    # Test if data is current
    get_current_tibber_day
    if [ "$current_tibber_day" = "$(TZ=$TZ date +%d)" ]; then
      echo "I: Tibber today-data is up to date."
    else
      echo "I: Tibber today-data is outdated, fetching new data."
      rm -f "$file14" "$file15" "$file16"
      download_tibber_prices "$link6" "$file14" $(( RANDOM % 21 + 10 ))
    fi
  else # Tibber data does not exist
        echo "I: Fetching today-data data from Tibber."
    download_tibber_prices "$link6" "$file14" $(( RANDOM % 21 + 10 ))
  fi											
fi


function euroToMillicent {
  euro="$1"
  potency="$2"

  if [ -z "$potency" ]; then
    potency=14
  fi

  if echo "$euro" | grep -q '\,' ; then
    echo "E: Could not translate '$euro' to an integer since this has a comma when only a period is accepted as decimal separator."
    return 1
  fi

  v=$(LANG=C printf "%.0f" "${euro}e${potency}")

  if echo "$v" | grep -q '\.' ; then
    echo "E: Could not translate '$euro' to an integer."
    return 1
  fi
  echo "$v"
  return 0
}

# An independent segment to test the conversion of floats to integers
if [ "tests" == "$1" ]; then

  echo "I: Testing euroToMillicent"
  for i in 123456 12345.6 1234.56 123.456 12.3456 1.23456 0.123456 .123456 .233 .23 .2 2.33 2.3 2 2,33 2,3 2 23
  do
    echo -n "$i -> "
    euroToMillicent $i
  done
  exit 0

fi

if (( include_second_day == 1 )); then

  if (( select_pricing_api == 1 )); then

    # Test if Awattar tomorrow data exists
    if test -f "$file2"; then
      # Test if data is current
      get_current_awattar_day2
      if [ "$current_awattar_day2" = "$(TZ=$TZ date +%-d)" ]; then
        echo "I: aWATTar tomorrow-data is up to date."
      else
        echo "I: aWATTar tomorrow-data is outdated, fetching new data."
        rm -f $file3
        download_awattar_prices "$link2" "$file2" "$file6" $(( RANDOM % 21 + 10 ))
      fi
    else # Data file2 does not exist
      echo "I: aWATTar tomorrow-data does not exist, fetching data."
      download_awattar_prices "$link2" "$file2" "$file6" $(( RANDOM % 21 + 10 ))
    fi
					
  elif (( select_pricing_api == 2 )); then

    # Test if Entsoe tomorrow data exists
    if [ ! -s "$file9" ]; then
      echo "I: File '$file9' has no tomorrow data, we have to try it again until the new prices are online."
      rm -f "$file5" "$file9" "$file13"
      download_entsoe_prices "$link5" "$file5" "$file13" $(( RANDOM % 21 + 10 ))
    fi 
	
  elif (( select_pricing_api == 3 )); then

    if [ ! -s "$file18" ]; then
      rm -f "$file17" "$file18"
      echo "I: File '$file18' has no tomorrow data, we have to try it again until the new prices are online."
      rm -f "$file12" "$file14" "$file15" "$file16" "$file17"
      download_tibber_prices "$link6" "$file14" $(( RANDOM % 21 + 10 ))
      sort -t, -k1.9n $file17 >> "$file12"
    fi 

  fi
  
fi # Include second day
																				 
if (( select_pricing_api == 1 )); then
  Unit="Cent/kWh net"
  get_awattar_prices
  get_awattar_prices_integer
elif (( select_pricing_api == 2 )); then
  Unit="EUR/MWh net"
  get_entsoe_prices
  get_prices_integer_entsoe
elif (( select_pricing_api == 3 )); then
  Unit="EUR/kWh $tibber_prices price"
  get_tibber_prices
  get_tibber_prices_integer
fi

if (( use_solarweather_api_to_abort == 1 )); then
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
echo "Current price is $current_price $Unit." | tee -a "$LOG_FILE"
echo "Lowest price will be $lowest_price $Unit."
echo "The average price will be $average_price $Unit."
echo "Highest price will be $highest_price $Unit."
echo "Second lowest price will be $second_lowest_price $Unit."
echo "Third lowest price will be $third_lowest_price $Unit."
echo "Fourth lowest price will be $fourth_lowest_price $Unit."
echo "Fifth lowest price will be $fifth_lowest_price $Unit."
echo "Sixth lowest price will be $sixth_lowest_price $Unit."

if (( use_solarweather_api_to_abort == 1 )); then
  echo "Sunrise today will be $sunrise_today and sunset will be $sunset_today. Suntime will be $suntime_today minutes." | tee -a "$LOG_FILE"
  echo "Solarenergy today will be $solarenergy_today megajoule per sqaremeter with $cloudcover_today percent clouds." | tee -a "$LOG_FILE"
  echo "Solarenergy tomorrow will be $solarenergy_tomorrow megajoule per squaremeter with $cloudcover_tomorrow percent clouds." | tee -a "$LOG_FILE"
  if [ ! -s $file3 ]; then
    echo "E: File '$file3' is empty, please check your API Key if download is still not possible tomorrow."
  fi
  find "$file3" -size 0 -delete # FIXME - looks wrong and complicated - simple RM included in prior if clause?
fi

# stop_price_integer cannot be found by shellcheck can be ignored, false positive
if ((use_start_stop_logic == 1 && stop_price_integer < start_price_integer)); then
  echo "E: stop - price cannot be lower than start price"
  exit 1
fi

# abort_price_integer cannot be found by shellcheck can be ignored, false positive
if ((abort_price_integer <= current_price_integer)); then
  echo "I: Current price is too high. Abort." | tee -a "$LOG_FILE"
  exit 0
fi

if ((use_solarweather_api_to_abort == 1)); then
  if ((abort_suntime <= suntime_today)); then
    echo "I: There are enough sun minutes today. Abort." | tee -a "$LOG_FILE"
    exit 0
  fi
  if ((abort_solar_yield_today_integer <= solarenergy_today_integer)); then
    echo "I: There is enough solarenergy today. Abort." | tee -a "$LOG_FILE"
    exit 0
  fi
  if ((abort_solar_yield_tomorrow_integer <= solarenergy_tomorrow_integer)); then
    echo "I: There is enough sun tomorrow. Abort."  | tee -a "$LOG_FILE"
    exit 0
  fi
fi

charging_conditions=(
  "use_start_stop_logic == 1 && start_price_integer > current_price_integer"
  "charge_at_solar_breakeven_logic == 1 && feedin_price_integer > current_price_integer + energy_fee_integer"
  "charge_at_lowest_price == 1 && lowest_price_integer == current_price_integer"
  "charge_at_second_lowest_price == 1 && second_lowest_price_integer == current_price_integer"
  "charge_at_third_lowest_price == 1 && third_lowest_price_integer == current_price_integer"
  "charge_at_fourth_lowest_price == 1 && fourth_lowest_price_integer == current_price_integer"
  "charge_at_fifth_lowest_price == 1 && fifth_lowest_price_integer == current_price_integer"
  "charge_at_sixth_lowest_price == 1 && sixth_lowest_price_integer == current_price_integer"
)

execute_charging=0
execute_switchablesockets_on=0

# Check if any charging condition is met
for condition in "${charging_conditions[@]}"
do
  if (( condition )); then
    execute_charging=1
    break
  fi
done

switchablesockets_conditions=(
  "switchablesockets_at_start_stop == 1 && start_price_integer > current_price_integer"
  "switchablesockets_at_solar_breakeven_logic == 1  && feedin_price_integer > current_price_integer + energy_fee_integer"
  "switchablesockets_at_lowest_price == 1 && lowest_price_integer == current_price_integer"
  "switchablesockets_at_second_lowest_price == 1 && second_lowest_price_integer == current_price_integer"
  "switchablesockets_at_third_lowest_price == 1 && third_lowest_price_integer == current_price_integer"
  "switchablesockets_at_fourth_lowest_price == 1  && fourth_lowest_price_integer == current_price_integer"
  "switchablesockets_at_fifth_lowest_price == 1 && fifth_lowest_price_integer == current_price_integer"
  "switchablesockets_at_sixth_lowest_price == 1 && sixth_lowest_price_integer == current_price_integer  "
)

# Check if any switching condition is met
for switchablesockets_condition in "${switchablesockets_conditions[@]}"; do
  if (( switchablesockets_condition == 1 )); then
    execute_switchablesockets_on=1
    break
  fi
done

# If any charging condition is met, start charging
if (( execute_charging == 1 && use_victron_charger == 1 )); then
  # Calculate the energy_loss_percent of the current_price_integer number
  percent_of_current_price_integer=$(awk "BEGIN {print $current_price_integer*$energy_loss_percent/100}")

  # Convert the result of the calculation to an integer
  percent_of_current_price_integer=$(printf "%.0f" "$percent_of_current_price_integer")

  # Check if charging makes sense
  # FIXME: highest_price_integer not defined
  if [[ $highest_price_integer -ge $((current_price_integer+percent_of_current_price_integer)) ]]; then
    echo "I: Difference between highest price and current price is greater than ${energy_loss_percent}%." | tee -a "$LOG_FILE"
    echo "   Charging makes sense." | tee -a "$LOG_FILE"
    if [ 0 -lt $use_victron_charger ]; then
      echo "   Executing 1 hour charging." | tee -a "$LOG_FILE"
      $charger_command_turnon
    else
      echo "   Not executing 1 hour charging only since use_victron_charger not enabled." | tee -a "$LOG_FILE"
    fi
  else
    echo "I: Difference between highest price and current price is less than ${energy_loss_percent}%." | tee -a "$LOG_FILE"
    echo "   Charging makes no sense. Skipping charging." | tee -a "$LOG_FILE"
  fi
fi

# Execute Fritz DECT on command
if (( execute_switchablesockets_on == 1 && use_fritz_dect_sockets == 1 )); then
  echo "I: Executing 1 hour Fritz switching." | tee -a "$LOG_FILE"
  # Get session ID (SID)
  sid=""
  challenge=$(curl -s "http://$fbox/login_sid.lua" | grep -o "<Challenge>[a-z0-9]\{8\}" | cut -d'>' -f 2)
  if [ -z "$challenge" ]; then
    printf "E: Could not retrieve challenge from login_sid.lua.\n"  | tee -a "$LOG_FILE"
    exit 1
  fi

  hash=$(echo -n "$challenge-$passwd" | sed -e 's,.,&\n,g' | tr '\n' '\0' | md5sum | grep -o "[0-9a-z]\{32\}")
  sid=$(curl -s "http://$fbox/login_sid.lua" -d "response=$challenge-$hash" -d "username=$user" \
    | grep -o "<SID>[a-z0-9]\{16\}" |  cut -d'>' -f 2)

  if [ "$sid" = "0000000000000000" ]; then
    echo "E: Login to Fritz!Box failed." | tee -a "$LOG_FILE"
    exit 1
  fi

  if [ "$sid" = "0000000000000000" ]; then
    exit 1
  fi

  if [ -n "$DEBUG" ]; then
    echo "I: Login to Fritz!Box successful." | tee -a "$LOG_FILE"
  fi

  # Iterate over each socket
  for socket in "${sockets[@]}"
  do
    if [ "$socket" = "0" ]; then
      continue
    fi

    # Get state and connectivity of socket
    connected=$(curl -s "http://$fbox/webservices/homeautoswitch.lua?sid=$sid&ain=$socket&switchcmd=getswitchpresent")
    ##FIXME: state is ignored
    state=$(curl -s "http://$fbox/webservices/homeautoswitch.lua?sid=$sid&ain=$socket&switchcmd=getswitchstate")

    if [ "$connected" = "1" ]; then
      echo "Turning socket $socket on for almost 60 minutes and then off again..." | tee -a "$LOG_FILE"
      url="http://$fbox/webservices/homeautoswitch.lua?sid=$sid&ain=$socket&switchcmd=setswitchon"
      if ! curl -s "$url" > /dev/null; then
        echo "E: Could not call URL '$url' to switch on said switch - ignored."
      fi
    else
      echo "W: Socket $socket is not connected." | tee -a "$LOG_FILE"
    fi

  done

fi # Execute Fritz DECT on command

if (( execute_switchablesockets_on == 1 && use_shelly_wlan_sockets == 1 )); then
  for ip in "${shelly_ips[@]}"
  do
    if [ "$ip" != "0" ]; then
      echo " Executing 1 hour Shelly switching." | tee -a "$LOG_FILE"
      curl -u "$shellyuser:$shellypasswd" "http://$ip/relay/0?turn=on"
    fi
  done
fi

if [ "$use_shelly_wlan_sockets" -eq 1 ] || [ "$use_fritz_dect_sockets" -eq 1 ]; then
  if [ "$execute_switchablesockets_on" -eq 1 ]; then
    echo "Waiting for almost 60 minutes..."
    sleep 3560
  fi
fi

if (( execute_switchablesockets_on == 1 && use_shelly_wlan_sockets == 1 )); then
  for ip in "${shelly_ips[@]}"
  do
    if [ "$ip" != "0" ]; then
      curl -u "$shellyuser:$shellypasswd" "http://$ip/relay/0?turn=off"
    fi
  done
fi

if (( execute_switchablesockets_on == 1 && use_fritz_dect_sockets == 1 )); then
  # Turn off each socket
  for socket in "${sockets[@]}"; do
    if [ "$socket" = "0" ]; then
        continue
    fi
    if ! curl -s "http://$fbox/webservices/homeautoswitch.lua?sid=$sid&ain=$socket&switchcmd=setswitchoff" > /dev/null; then
      echo "E: Could not execut switch-off of socket sid=$sid ain=$socket - ignored"
    fi
  done
fi

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
  echo "[ OK ]"
fi
