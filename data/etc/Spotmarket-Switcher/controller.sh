#!/bin/bash

# Haftungsausschluss(Disclaimer): Dieses Computerprogramm wird "wie es ist" bereitgestellt und der Nutzer trägt das volle Risiko bei der Nutzung.
# Der Autor übernimmt keine Gewährleistung für die Genauigkeit, Zuverlässigkeit, Vollständigkeit oder Brauchbarkeit des Programms für irgendeinen bestimmten Zweck.
# Der Autor haftet weder für Schäden, die sich aus der Nutzung oder Unfähigkeit zur Nutzung des Programms ergeben, noch für Schäden, die aufgrund von Fehlern oder
# Mängeln des Programms entstehen. Dies gilt auch für Schäden, die aufgrund von Verletzungen von Pflichten im Rahmen einer vertraglichen oder außervertraglichen
# Verpflichtung entstehen.

# Disclaimer: This computer program is provided "as is" and the user bears the full risk of using it.
# The author makes no representations or warranties of any kind concerning the accuracy, reliability, completeness or suitability of the program for any particular purpose.
# The author shall not be liable for any damages of any kind arising from the use or inability to use the program, including but not limited to direct, indirect, incidental,
# special or consequential damages.

##### Configuration part...
#Please note that this script is only for hourly based tariff data, please create your own fork if you need 15 minutes based data.
#After every API reconfiguration please delete the old API-Downloadfiles with rm /tmp/awattar*.* /tmp/entsoe*.*

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
charger_command_turnon="dbus -y com.victronenergy.settings /Settings/CGwacs/BatteryLife/Schedule/Charge/0/Day SetValue -- 7"
charger_command_turnoff="dbus -y com.victronenergy.settings /Settings/CGwacs/BatteryLife/Schedule/Charge/0/Day SetValue -- -7"
SOC_percent=$(dbus-send --system --print-reply --dest=com.victronenergy.system /Dc/Battery/Soc com.victronenergy.BusItem.GetValue | grep int32 | awk '{print $3}') # This will get the battery state of charge (SOC) from a Victron Energy system
energy_loss_percent=23.3 # Enter how much percent of the energy is lost by the charging and discharging process. Current and highest price will be compared and aborted if charging makes no sense.

#Please change prices (always use Cent/kWh, no matter if youre using Awattar (displaying Cent/kWh) or Entsoe API (displaying EUR/MWh) / netto prices excl. tax).
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
select_pricing_api=1 # please enter 1 for awattar or 2 for entsoe / Awattar: only germany DE-LU or austrian AT prices, but no API key needed / Entsoe: much more countrys available but free API key needed, see https://www.entsoe.eu/data/map/
include_second_day=0 # Set to 0 to compare only the today prices. 
# Set include_second_day to 1 to compare today & tomorrow prices if they become available (today in the afternoon).
# Please note: If you activate this and the prices decrease over several days,
# it is possible that there will be no charging or switching for several days until the lowest prices are reached.

# Please set up Solar weather API to query solar yield
use_solarweather_api_to_abort=0
abort_solar_yield_today=4.5 # abort and never charge because we are expecting enough sun today (daily megajoule per squaremeter)
abort_solar_yield_tomorrow=5.5 # abort and never charge because we are expecting enough sun tomorrow (daily megajoule per squaremeter)
#To find the kilowatt hour value from megajoules, divide by 3.6. 
abort_suntime=700 # abort and never charge if we have more sun minutes per day as this value (time in minutes between sunrise and sunset)
latitude=51.530600 # Your location
longitude=7.860575
#You can use Google Maps to find the latitude and longitude of a location by searching for the address or location and then right-clicking
#on the location on the map. A pop-up menu will appear with the option to "What's here?" which will display the latitude and longitude of that location.
visualcrossing_api_key=YOURAPIKEY # Get your free key at https://www.visualcrossing.com/sign-up No credit card is required to sign up for your free 1000 records per day.

# Awattar Api setup
awattar=de # enter de for Germany or at for Austria (no other countrys available, for other countrys use Entsoe API)

# Entsoe Api setup
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

# further Api parameters (no need to edit)
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
now_entsoe_linenumber=$(($getnow+1))
link1=https://api.awattar.$awattar/v1/marketdata/current.yaml
link2=http://api.awattar.$awattar/v1/marketdata/current.yaml?tomorrow=include
link3="https://weather.visualcrossing.com/VisualCrossingWebServices/rest/services/timeline/$latitude%2C%20$longitude/$todayyear-$todaymonth-$today2/$tomorrowyear-$tomorrowmonth-$tomorrow2?unitGroup=metric&elements=solarenergy%2Ccloudcover%2Csunrise%2Csunset&include=days&key=$visualcrossing_api_key&contentType=csv"
link4="https://web-api.tp.entsoe.eu/api?securityToken=$entsoe_eu_api_security_token&documentType=A44&in_Domain=$in_Domain&out_Domain=$out_Domain&periodStart=$yesteryear$yestermonth$yesterday&periodEnd=$todayyear$todaymonth$today"
link5="https://web-api.tp.entsoe.eu/api?securityToken=$entsoe_eu_api_security_token&documentType=A44&in_Domain=$in_Domain&out_Domain=$out_Domain&periodStart=$todayyear$todaymonth$today&periodEnd=$tomorrowyear$tomorrowmonth$tomorrow"
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
file12=/tmp/entsoe_prices_sorted.txt
file13=/tmp/entsoe_tomorrow_prices.txt
LOG_FILE="/data/etc/Spotmarket-Switcher/spotmarket-switcher.log"
MAX_SIZE=1000 # 1 MB
LOG_FILES_TO_KEEP=2

########## Begin of the script...

if (( ( $use_victron_charger == 1 ) )); then
echo "Maybe we are still charging from last script runtime. Stopping scheduled charging. Battery SOC is at $SOC_percent %." | tee -a $LOG_FILE
$charger_command_turnoff
fi

download_awattar_prices() {
  local url=$1
  local file=$2
  local output_file=$3
  local sleep_time=$4

  echo "Please be patient. First we wait $sleep_time Seconds in case if the system clock is not syncronized."
  sleep "$sleep_time"

  curl "$url" > "$file"
  if test -f "$file"; then
    echo "$file downloaded"
    echo >> "$file"
    awk '/data_price_hour_rel_.*_amount: / {print substr($0, index($0, ":") + 2)}' "$file" > "$output_file"
    sort -g "$output_file" > "${output_file%.*}_sorted.${output_file##*.}"
    printf "date_now_day: $(echo $(TZ=$TZ date +%d))" >>  "$output_file"
    printf "date_now_day: $(echo $(TZ=$TZ date +%d))" >> "${output_file%.*}_sorted.${output_file##*.}"
  else
    echo "could not get prices"
    exit 1
  fi
    if [ -f "$file2" ] && [[ $( wc -l < "$file1" ) == $( wc -l < "$file2" ) ]]; then
      rm "$file2"
      echo "$file2 has no tomorrow data, we have to try it again until the new prices are online."
    fi
}

download_entsoe_prices() {
  local url=$1
  local file=$2
  local output_file=$3
  local entsoetomorrow=$4

  curl "$url" > "$file"
  if test -f "$file"; then
    echo "$file downloaded"
    [ -s "$file" ] && > /dev/null || echo "Error: $file is empty, please check your API Key."
    awk '/<price.amount>/ {print substr($0, index($0, ">") + 1, index($0, "</") - index($0, ">") - 1)}' "$file" >> "$output_file"
    sed -i '1,96d' "$output_file"
    sed -i '25,120d' "$output_file"
    sort -g "$output_file" >> "${output_file%.*}_sorted.${output_file##*.}"
    printf "date_now_day: $(echo $(TZ=$TZ date +%d))" >> "$output_file"
    printf "date_now_day: $(echo $(TZ=$TZ date +%d))" >> "${output_file%.*}_sorted.${output_file##*.}"
  else
    echo "could not get price data"
    exit 1
  fi

  # Check if tomorrow file contains next day prices
  if [ $entsoetomorrow=1 ] && grep -q "PT60M" "$file" && [ "$(wc -l < "$output_file")" -gt 2 ]; then
    cat $file10 > $file8
echo >> $file8
if [ -f "$file13" ]; then
  cat "$file13" >> "$file8"
echo >> $file8
fi
sed -i '25d 50d' $file8
sort -g $file8 > $file12
printf "date_now_day: $(echo $(TZ=$TZ date +%d))" >> "$file8"
printf "date_now_day: $(echo $(TZ=$TZ date +%d))" >> "$file12"
else
      echo "$output_file was empty, we have to try it again until the new prices are online."
rm $file5 $file9 $file13 >> /dev/null
  fi
}

function download_solarenergy {
if (( ( $use_solarweather_api_to_abort == 1 ) )); then
    curl $link3 -o $file3;
  if test -f "$file3"; then
    echo "$file3 downloaded"
  else
    echo "could not get solarenergy data"
    exit 1
  fi
fi
}

function get_current_awattar_day { current_awattar_day=$(sed -n 3{p} $file1 | grep -Eo '[0-9]+'); }
function get_current_awattar_day2 { current_awattar_day2=$(sed -n 3{p} $file2 | grep -Eo '[0-9]+'); }
function get_awattar_prices { current_price=$(sed -n $((2*$(TZ=$TZ date +%k)+39)){p} $file1 | grep -Eo '[+-]?[0-9]+([.][0-9]+)?' | tail -n1);
lowest_price=$(sed -n 1{p} $file7 );
second_lowest_price=$(sed -n 2{p} $file7 );
third_lowest_price=$(sed -n 3{p} $file7 );
fourth_lowest_price=$(sed -n 4{p} $file7 );
fifth_lowest_price=$(sed -n 5{p} $file7 );
sixth_lowest_price=$(sed -n 6{p} $file7 ); 
highest_price=$(awk 'NR == FNR{if(NR>1)a[FNR]=$0;next} END{print a[FNR-1]}' $file7 $file7);
average_price=$(awk '{sum+=$1} END {print sum/(NR-1)}' $file7);
}


function get_current_entsoe_day { current_entsoe_day=$(sed -n 25{p} $file10 | grep -Eo '[0-9]+'); }
function get_current_entsoe_day2 { current_entsoe_day2=$(sed -n 25{p} $file13 | grep -Eo '[0-9]+'); }
function get_entsoe_prices { current_price=$(sed -n $now_entsoe_linenumber{p} $file10);
lowest_price=$(sed -n 1{p} $file12 );
second_lowest_price=$(sed -n 2{p} $file12 );
third_lowest_price=$(sed -n 3{p} $file12 );
fourth_lowest_price=$(sed -n 4{p} $file12 );
fifth_lowest_price=$(sed -n 5{p} $file12 );
sixth_lowest_price=$(sed -n 6{p} $file12 ); 
highest_price=$(awk 'NR == FNR{if(NR>1)a[FNR]=$0;next} END{print a[FNR-1]}' $file12 $file12);
average_price=$(awk '{sum+=$1} END {print sum/(NR-1)}' $file12);
}

function get_prices_integer_awattar {
for var in lowest_price highest_price second_lowest_price third_lowest_price fourth_lowest_price fifth_lowest_price sixth_lowest_price current_price stop_price start_price feedin_price energy_fee abort_price
do
    integer_var="${var}_integer"
    eval "$integer_var"=$(printf "%.0f\n" "${!var}e15")
done
 }

# We have to convert entsoe integer prices equivalent to Cent/kwH
function get_prices_integer_entsoe {

for var in lowest_price highest_price second_lowest_price third_lowest_price fourth_lowest_price fifth_lowest_price sixth_lowest_price current_price
do
    integer_var="${var}_integer"
    eval "$integer_var"=$(printf "%.0f\n" "${!var}e14")
done

for var in stop_price start_price feedin_price energy_fee abort_price
do
    integer_var="${var}_integer"
    eval "$integer_var"=$(printf "%.0f\n" "${!var}e15")
done
}

function get_solarenergy_today { solarenergy_today=$(sed '2!d' $file3 | cut -d',' -f2); solarenergy_today_integer=$( printf "%.0f\n" "${solarenergy_today}e15" ); abort_solar_yield_today_integer=$( printf "%.0f\n" "${abort_solar_yield_today}e15" ); }
function get_solarenergy_tomorrow { solarenergy_tomorrow=$(sed '3!d' $file3 | cut -d',' -f2); solarenergy_tomorrow_integer=$( printf "%.0f\n" "${solarenergy_tomorrow}e15" ); abort_solar_yield_tomorrow_integer=$( printf "%.0f\n" "${abort_solar_yield_tomorrow}e15" );}
function get_cloudcover_today { cloudcover_today=$(sed '2!d' $file3 | cut -d',' -f1);}
function get_cloudcover_tomorrow { cloudcover_tomorrow=$(sed '3!d' $file3 | cut -d',' -f1);}
function get_sunrise_today { sunrise_today=$(sed '2!d' $file3 | cut -d',' -f3 | cut -d 'T' -f2 | awk -F: '{ print $1 ":" $2 }');}
function get_sunset_today { sunset_today=$(sed '2!d' $file3 | cut -d',' -f4 | cut -d 'T' -f2 | awk -F: '{ print $1 ":" $2 }');}
function get_suntime_today { suntime_today=$(((($(TZ=$TZ date -d "1970-01-01 $sunset_today" +%s) - $(TZ=$TZ date -d "1970-01-01 $sunrise_today" +%s))) / 60)); 
}


if (( ( $select_pricing_api == 1 ) )); then

# test if Awattar today data exists
if test -f "$file1"; then
  # test if data is current
  get_current_awattar_day
  if [ "$current_awattar_day" = "$(TZ=$TZ date +%-d)" ]; then
    echo "Awattar today-data is up to date."
  else
    echo "Awattar today-data is outdated, fetching new data."
    rm $file1 $file6 $file7
    download_awattar_prices "$link1" "$file1" "$file6" 30
  fi
else # data file1 does not exist
    download_awattar_prices "$link1" "$file1" "$file6" 30
fi
fi

if (( ( $select_pricing_api == 2 ) )); then

# test if Entsoe today data exists
if test -f "$file4"; then
  # test if data is current
  get_current_entsoe_day
  if [ "$current_entsoe_day" = "$(TZ=$TZ date +%d)" ]; then
    echo "Entsoe today-data is up to date."
  else
    echo "Entsoe today-data is outdated, fetching new data."
    rm $file4 $file8 $file10 $file11 $file12
    download_entsoe_prices "$link4" "$file4" "$file10" 0

  fi
else # Entsoe data does not exist
  download_entsoe_prices "$link4" "$file4" "$file10" 0
fi
fi

if (( ( $include_second_day == 1 ) )); then
if (( ( $select_pricing_api == 1 ) )); then

# test if Awattar tomorrow data exists
if test -f "$file2"; then
  # test if data is current
  get_current_awattar_day2
  if [ "$current_awattar_day2" = "$(TZ=$TZ date +%-d)" ]; then
    echo "Awattar tomorrow-data is up to date."
  else
    echo "Awattar tomorrow-data is outdated, fetching new data."
    rm $file3
    download_awattar_prices "$link2" "$file2" "$file6" 2
  fi
else # data file2 does not exist
    download_awattar_prices "$link2" "$file2" "$file6" 2
fi
fi
if (( ( $select_pricing_api == 2 ) )); then

# test if Entsoe tomorrow data exists
if test -f "$file5"; then
  # test if data is current
  get_current_entsoe_day2
  if [ "$current_entsoe_day2" = "$(TZ=$TZ date +%d)" ]; then
    echo "Entsoe tomorrow-data is up to date."
  else
    echo "Entsoe tomorrow-data is outdated, fetching new data."
    rm $file5 $file9 $file13
    download_entsoe_prices "$link5" "$file5" "$file13" 1
       cp "$file10" "$file8"
       cp "$file11" "$file12"
  fi
else # data file5 does not exist
  download_entsoe_prices "$link5" "$file5" "$file13" 1
fi
fi
fi

if (( ( $select_pricing_api == 1 ) )); then
Unit="Cent/kWh"
get_awattar_prices
get_prices_integer_awattar
fi

if (( ( $select_pricing_api == 2 ) )); then
Unit="EUR/MWh"
get_entsoe_prices
get_prices_integer_entsoe
fi

if (( ( $use_solarweather_api_to_abort == 1 ) )); then
download_solarenergy
get_solarenergy_today
get_solarenergy_tomorrow
get_cloudcover_today
get_cloudcover_tomorrow
get_sunrise_today
get_sunset_today
get_suntime_today

fi

echo Please verify correct system time and timezone:
echo >> $LOG_FILE
TZ=$TZ date | tee -a $LOG_FILE
echo "Current price is" $current_price" $Unit netto." | tee -a $LOG_FILE
echo "Lowest price will be "$lowest_price" $Unit netto."
echo "The average price will be "$average_price" $Unit netto."
echo "Highest price will be "$highest_price" $Unit netto."
echo "Second lowest price will be "$second_lowest_price" $Unit netto."
echo "Third lowest price will be "$third_lowest_price" $Unit netto."
echo "Fourth lowest price will be "$fourth_lowest_price" $Unit netto."
echo "Fifth lowest price will be "$fifth_lowest_price" $Unit netto."
echo "Sixth lowest price will be "$sixth_lowest_price" $Unit netto."
if (( ( $use_solarweather_api_to_abort == 1 ) )); then
echo "Sunrise today will be $sunrise_today and sunset will be $sunset_today. Suntime will be $suntime_today minutes. "  | tee -a $LOG_FILE
echo "Solarenergy today will be" $solarenergy_today" megajoule per sqaremeter with "$cloudcover_today" percent clouds."  | tee -a $LOG_FILE
echo "Solarenergy tomorrow will be" $solarenergy_tomorrow" megajoule per squaremeter with "$cloudcover_tomorrow" percent clouds."  | tee -a $LOG_FILE
[ -s $file3 ]  && >nul || echo "Error: $file3 is empty, please check your API Key if download is still not possible tomorrow."
find $file3 -size 0 -delete
fi

if ((use_start_stop_logic == 1 && stop_price_integer < start_price_integer)); then
  echo "stop price cannot be lower than start price"
  exit 1
fi
if ((abort_price_integer <= current_price_integer)); then
  echo "Current price is too high. Abort."  | tee -a $LOG_FILE
  exit 0
fi
if ((use_solarweather_api_to_abort == 1)); then
  if ((abort_suntime <= suntime_today)); then
    echo "There are enough sun minutes today. Abort."  | tee -a $LOG_FILE
    exit 0
  fi
  if ((abort_solar_yield_today_integer <= solarenergy_today_integer)); then
    echo "There is enough solarenergy today. Abort."  | tee -a $LOG_FILE
    exit 0
  fi
  if ((abort_solar_yield_tomorrow_integer <= solarenergy_tomorrow_integer)); then
    echo "There is enough sun tomorrow. Abort."  | tee -a $LOG_FILE
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
for condition in "${charging_conditions[@]}"; do
  if (( $condition )); then
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
"switchablesockets_at_sixth_lowest_price == 1 && sixth_lowest_price_integer == current_price_integer"
)

# Check if any switching condition is met
for switchablesockets_condition in "${switchablesockets_conditions[@]}"; do
  if (( $switchablesockets_condition == 1 )); then
    execute_switchablesockets_on=1
  break
  fi
done
# If any charging condition is met, start charging
if (( execute_charging == 1 && $use_victron_charger == 1 )); then

# Calculate the energy_loss_percent of the current_price_integer number
percent_of_current_price_integer=$(awk "BEGIN {print $current_price_integer*$energy_loss_percent/100}")

# convert the result of the calculation to an integer
percent_of_current_price_integer=$(printf "%.0f" $percent_of_current_price_integer)

# Check if charging makes sense
if [[ $highest_price_integer -ge $((current_price_integer+percent_of_current_price_integer)) ]]; then
  echo "Difference between highest price and current price is greater than $energy_loss_percent%." | tee -a $LOG_FILE
  echo "Charging makes sense. Executing 1 hour charging. Battery SOC is at $SOC_percent %." | tee -a $LOG_FILE
  $charger_command_turnon
else
  echo "Difference between highest price and current price is less than $energy_loss_percent%." | tee -a $LOG_FILE
  echo "Charging makes no sense. Skipping charging. Battery SOC is at $SOC_percent %." | tee -a $LOG_FILE

fi

fi
# execute Fritz DECT on command
  if (( execute_switchablesockets_on == 1 && use_fritz_dect_sockets == 1 )); then
echo " Executing 1 hour Fritz switching." | tee -a $LOG_FILE
# Get session ID (SID)
sid=""
challenge=$(curl -s "http://$fbox/login_sid.lua" | grep -o "<Challenge>[a-z0-9]\{8\}" | cut -d'>' -f 2)
	if [ -z "$challenge" ]; then
    printf "Error: Could not retrieve challenge from login_sid.lua.\n"
    exit 1
	fi

hash=$(echo -n "$challenge-$passwd" |sed -e 's,.,&\n,g' | tr '\n' '\0' | md5sum | grep -o "[0-9a-z]\{32\}")
sid=$(curl -s "http://$fbox/login_sid.lua" -d "response=$challenge-$hash" -d "username=$user" \
    | grep -o "<SID>[a-z0-9]\{16\}" |  cut -d'>' -f 2)
	if [ "$sid" = "0000000000000000" ]; then
    printf "Error: Login to Fritzbox failed.\n" | tee -a $LOG_FILE
    exit 1
	fi
printf "Login to Fritzbox successful.\n" | tee -a $LOG_FILE
# Iterate over each socket
for socket in "${sockets[@]}"; do
    if [ "$socket" = "0" ]; then
        continue
    fi

    # Get state and connectivity of socket
    connected=$(curl -s "http://$fbox/webservices/homeautoswitch.lua?sid=$sid&ain=$socket&switchcmd=getswitchpresent")
    state=$(curl -s "http://$fbox/webservices/homeautoswitch.lua?sid=$sid&ain=$socket&switchcmd=getswitchstate")

    if [ "$connected" = "1" ]; then
        printf "Turning socket $socket on for almost 60 minutes and then off again...\n" | tee -a $LOG_FILE
        curl -s "http://$fbox/webservices/homeautoswitch.lua?sid=$sid&ain=$socket&switchcmd=setswitchon" >/dev/null
    else
        printf "Socket $socket is not connected\n" | tee -a $LOG_FILE
    fi
done
fi

  if (( execute_switchablesockets_on == 1 && use_shelly_wlan_sockets == 1 )); then
  
  for ip in "${shelly_ips[@]}"
do
  if [ $ip != "0" ]; then
    echo " Executing 1 hour Shelly switching." | tee -a $LOG_FILE
    curl -u '$shellyuser:$shellypasswd' http://$ip/relay/0?turn=on
  fi
done

  fi
if [ use_shelly_wlan_sockets == 1 ] || [ use_fritz_dect_sockets == 1 ] && [ $execute_switchablesockets_on -eq 1 ]; then
echo Waiting for almost 60 minutes...
sleep 3560
fi

  if (( execute_switchablesockets_on == 1 && use_shelly_wlan_sockets == 1 )); then
  
  for ip in "${shelly_ips[@]}"
do
  if [ $ip != "0" ]; then
    curl -u '$shellyuser:$shellypasswd' http://$ip/relay/0?turn=off
  fi
done

  fi
  if (( execute_switchablesockets_on == 1 && use_fritz_dect_sockets == 1 )); then
# Turn off each socket
for socket in "${sockets[@]}"; do
    if [ "$socket" = "0" ]; then
        continue
    fi
    curl -s "http://$fbox/webservices/homeautoswitch.lua?sid=$sid&ain=$socket&switchcmd=setswitchoff" >/dev/null
done
fi

# doing logrotation
if [ -f "$LOG_FILE" ]; then
  if [ $(du -k "$LOG_FILE" | awk '{print $1}') -gt "$MAX_SIZE" ]; then
    mv "$LOG_FILE" "$LOG_FILE".$(date +%Y%m%d%H%M%S)
    touch "$LOG_FILE"
    ls -1t "$LOG_FILE"* | tail -n +$((LOG_FILES_TO_KEEP + 1)) | xargs --no-run-if-empty rm
  fi
fi
