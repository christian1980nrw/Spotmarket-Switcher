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

#Please change prices (always use Cent/kWh, no matter if youre using Awattar (displaying Cent/kWh) or Entsoe API (displaying EUR/MWh) / netto prices excl. tax).

stop_price=4.1 # stop above this price
start_price=2.0 # start below this price
feedin_price=9.87 # your feed-in-tariff of your solar system
energy_fee=15.3 # proofs of origin, allocations, duties and taxes (in case if stock price is at 0 Cent/kWh)
abort_price=50.1 # abort and never charge if actual price is same or higher than this (Energy fees not included)

use_start_stop_logic=0 # Set to 1 to activate start/stop logic (start_stop_price).
fritz_dect_at_start_stop=0 # You can add a additional load (like water heater) with AVM Fritz DECT200/210 switch sockets if you like.
charge_at_solar_breakeven_logic=0 # Charge if energy including fees is cheaper than your own feedin-tariff of your solar system
fritz_dect_at_solar_breakeven_logic=0
charge_at_lowest_price=0 # set 1 to charge at lowest price per day no matter which start/stop price was defined 
fritz_dect_at_lowest_price=0
charge_at_second_lowest_price=0
fritz_dect_at_second_lowest_price=0
charge_at_third_lowest_price=0
fritz_dect_at_third_lowest_price=0
charge_at_fourth_lowest_price=0
fritz_dect_at_fourth_lowest_price=0
charge_at_fifth_lowest_price=0
fritz_dect_at_fifth_lowest_price=0
charge_at_sixth_lowest_price=0
fritz_dect_at_sixth_lowest_price=0
TZ='Europe/Amsterdam' # Set Correct Timezone
select_pricing_api=1 # please enter 1 for awattar or 2 for entsoe / Awattar: only germany DE-LU or austrian AT prices, but no API key needed / Entsoe: much more countrys available but free API key needed, see https://www.entsoe.eu/data/map/
include_second_day=0 # Set to 0 to compare only the today prices. 
# Set include_second_day to 1 to compare today & tomorrow prices if they become available (today in the afternoon).
# Please note: If you activate this and the prices decrease over several days,
# it is possible that there will be no charging or switching for several days until the lowest prices are reached.

# Please set up Solar weather API to query solar yield
use_solarweather_api_to_abort=0
abort_solar_yield_today=3.0 # abort and never charge because we are expecting enough sun today (daily megajoule per squaremeter)
abort_solar_yield_tomorrow=4.5 # abort and never charge because we are expecting enough sun tomorrow (daily megajoule per squaremeter)
#To find the kilowatt hour value from megajoules, divide by 3.6. 
country=Germany
city=Dortmund
visualcrossing_api_key=YOURAPIKEY # Get your free key at https://www.visualcrossing.com/sign-up No credit card is required to sign up for your free 1000 records per day.

# Awattar Api setup
awattar=de # enter de for Germany or at for Austria (no other countrys available, for other countrys use Entsoe API)

# Entsoe Api setup
# To find out your in and out domain key, export sample data as XML of your country at https://transparency.entsoe.eu/transmission-domain/r2/dayAheadPrices/show
# and open it with a Text editor.
in_Domain=10Y1001A1001A82H # this is for Germany DE-LU
out_Domain=10Y1001A1001A82H # Example: Spain is 10YES-REE------0
entsoe_eu_api_security_token=YOURAPIKEY

# How to get the free api_security_token: Go to https://transparency.entsoe.eu/ , click Login --> Register and create a Account. After that
# send an email to transparency@entsoe.eu with “Restful API access” in the subject line.
# Indicate the email address you entered during registration in the email body. 
# The ENTSO-E Helpdesk will make their best efforts to respond to your request within 3 working days.
# After That you can generate a security token at https://transparency.entsoe.eu/usrm/user/myAccountSettings
# The ENTSO-E Transparency Platform aims to provide free, continuous access to pan-European electricity market data for all users.

# Switchable Sockets Setup (AVM Fritz DECT200/210 wireless sockets) if used (tested with FRITZ!OS: 07.29).
fbox="192.168.178.1"
user="fritz1234"
passwd="YOURPASSWORD"
sockets=("087610414914" "087610409479" "0" "0" "0" "0")

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
getnow=$(TZ=$TZ date -d @$(( $(TZ=$TZ date +"%s") )) +%H)
now_entsoe_linenumber=$(($getnow+1))
link1=https://api.awattar.$awattar/v1/marketdata/current.yaml
link2=http://api.awattar.$awattar/v1/marketdata/current.yaml?tomorrow=include
link3="https://weather.visualcrossing.com/VisualCrossingWebServices/rest/services/timeline/$city%20$country/$todayyear-$todaymonth-$today2/$tomorrowyear-$tomorrowmonth-$tomorrow2?unitGroup=metric&elements=solarenergy&include=days&key=$visualcrossing_api_key&contentType=csv"
link4="https://transparency.entsoe.eu/api?securityToken=$entsoe_eu_api_security_token&documentType=A44&in_Domain=$in_Domain&out_Domain=$out_Domain&periodStart=$yesteryear$yestermonth$yesterday&periodEnd=$todayyear$todaymonth$today"
link5="https://transparency.entsoe.eu/api?securityToken=$entsoe_eu_api_security_token&documentType=A44&in_Domain=$in_Domain&out_Domain=$out_Domain&periodStart=$todayyear$todaymonth$today&periodEnd=$tomorrowyear$tomorrowmonth$tomorrow"
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

########## Begin of the script...
echo "Maybe we are still charging from last script runtime. Stopping scheduled charging."
dbus -y com.victronenergy.settings /Settings/CGwacs/BatteryLife/Schedule/Charge/0/Day SetValue -- -7

function download_awattar_prices_today {
  echo "Please be patient. First we wait 30 Seconds in case if the system clock is not syncronized."
  sleep 30

  curl "$link1" > "$file1"
  if test -f "$file1"; then
    echo "$file1 downloaded"
echo >> $file1
	cat $file1 | while read line;do
	[ "$(echo "$line" | grep "data_price_hour_rel_.*_amount: ")" ]&& echo "$(echo $line |  cut -f3 -d'[' | cut -f1 -d']' | sed -n 's|data_price_hour_rel_.*_amount: \(.*\)|\1|p')">> $file6
	done
        sort -g $file6 >> $file7
        printf "date_now_day: $(echo $( TZ=$TZ date +%d ))" >>  $file6
        printf "date_now_day: $(echo $( TZ=$TZ date +%d ))" >>  $file7
  else
    echo "could not get prices"
    exit 1
  fi
}

function download_awattar_prices_tomorrow {
  curl "$link2" > "$file2"
  if test -f "$file2"; then
    echo "$file2 downloaded"
    echo >> "$file2"
    if [[ $( wc -l < "$file1" ) == $( wc -l < "$file2" ) ]]; then
      rm "$file2"
      echo "$file2 has no tomorrow data, we have to try it again until the new prices are online."
    else
      rm "$file6"
      rm "$file7"
      cat $file2 | while read line;do
	[ "$(echo "$line" | grep "data_price_hour_rel_.*_amount: ")" ]&& echo "$(echo $line |  cut -f3 -d'[' | cut -f1 -d']' | sed -n 's|data_price_hour_rel_.*_amount: \(.*\)|\1|p')">> $file6
	done
      sort -g "$file6" >> "$file7"
      printf "date_now_day: $(echo $( TZ=$TZ date +%d ))" >>  "$file6"
      printf "date_now_day: $(echo $( TZ=$TZ date +%d ))" >>  "$file7"
    fi
  else
    echo "could not get prices"
    exit 1
  fi
}

function download_entsoe_prices_today {
  curl "$link4" > $file4
  if test -f "$file4"; then
    echo "$file4 downloaded"
    [ -s $file4 ]  && >nul || echo "Error: $file4 is empty, please check your API Key."
    awk '/<price.amount>/ {print substr($0, index($0, ">") + 1, index($0, "</") - index($0, ">") - 1)}' $file4 >> $file10
    sed -i '1,96d' $file10
    sed -i '25,120d' $file10
    sort -g $file10 >> $file11
    cp $file10 $file8 
    sort -g $file8 >> $file12
    printf "date_now_day: $(echo $( TZ=$TZ date +%d ))" >> $file8
    printf "date_now_day: $(echo $( TZ=$TZ date +%d ))" >> $file12
    printf "date_now_day: $(echo $( TZ=$TZ date +%d ))" >> $file10
    printf "date_now_day: $(echo $( TZ=$TZ date +%d ))" >> $file11
  else
    echo "could not get price data"
    exit 1
  fi
}


function download_entsoe_prices_tomorrow {
  # Use curl to download file
  curl $link5 -o $file5;
  if test -f "$file5"; then
    echo "$file5 downloaded"

    # Check if file contains next day prices
    if  grep -q "PT60M" "$file5" ; then
      echo 'Next day prices available.' ; 
      
      # Use Awk to extract and filter data
      awk '/<price.amount>/ {print substr($0, index($0, ">") + 1, index($0, "</") - index($0, ">") - 1)}' $file5 >> $file13

      # Remove unnecessary lines
      sed -i '1,96d' $file13
      sed -i '25,120d' $file13
      sed -i '25d' $file8

      # Concatenate and sort data
      cat $file13 >> $file8
      sort -g $file8 > $file12
      echo "date_now_day: $(echo $(TZ=$TZ date +%d))" >> $file8
      sort -g $file13 >> $file9
      echo "date_now_day: $(echo $(TZ=$TZ date +%d))" >> $file12
      echo "date_now_day: $(echo $(TZ=$TZ date +%d))" >> $file13
      echo "date_now_day: $(echo $(TZ=$TZ date +%d))" >> $file9
    else
      rm $file5
      echo "$file5 was empty, we have to try it again until the new prices are online."
    fi

  else
    echo "could not get price data"
    exit 1
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
function get_current_price_awattar { current_price=$(sed -n $((2*$(TZ=$TZ date +%H)+39)){p} $file1 | grep -Eo '[+-]?[0-9]+([.][0-9]+)?' | tail -n1); }
function get_lowest_price_awattar { lowest_price=$(sed -n 1{p} $file7 ); }
function get_second_lowest_price_awattar { second_lowest_price=$(sed -n 2{p} $file7 ); }
function get_third_lowest_price_awattar { third_lowest_price=$(sed -n 3{p} $file7 ); }
function get_fourth_lowest_price_awattar { fourth_lowest_price=$(sed -n 4{p} $file7 ); }
function get_fifth_lowest_price_awattar { fifth_lowest_price=$(sed -n 5{p} $file7 ); }
function get_sixth_lowest_price_awattar { sixth_lowest_price=$(sed -n 6{p} $file7 ); }

function get_current_entsoe_day { current_entsoe_day=$(sed -n 25{p} $file10 | grep -Eo '[0-9]+'); }
function get_current_entsoe_day2 { current_entsoe_day2=$(sed -n 25{p} $file13 | grep -Eo '[0-9]+'); }
function get_current_price_entsoe { current_price=$(sed -n $now_entsoe_linenumber{p} $file10); }
function get_lowest_price_entsoe { lowest_price=$(sed -n 1{p} $file12 ); }
function get_second_lowest_price_entsoe { second_lowest_price=$(sed -n 2{p} $file12 ); }
function get_third_lowest_price_entsoe { third_lowest_price=$(sed -n 3{p} $file12 ); }
function get_fourth_lowest_price_entsoe { fourth_lowest_price=$(sed -n 4{p} $file12 ); }
function get_fifth_lowest_price_entsoe { fifth_lowest_price=$(sed -n 5{p} $file12 ); }
function get_sixth_lowest_price_entsoe { sixth_lowest_price=$(sed -n 6{p} $file12 ); }

function get_prices_integer_awattar {
for var in lowest_price second_lowest_price third_lowest_price fourth_lowest_price fifth_lowest_price sixth_lowest_price current_price stop_price start_price feedin_price energy_fee abort_price
do
    integer_var="${var}_integer"
    eval "$integer_var"=$(printf "%.0f\n" "${!var}e15")
done
 }

# We have to convert entsoe integer prices equivalent to Cent/kwH
function get_prices_integer_entsoe {

for var in lowest_price second_lowest_price third_lowest_price fourth_lowest_price fifth_lowest_price sixth_lowest_price current_price
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

function get_solarenergy_today { solarenergy_today=$(sed -n 2{p} $file3 | grep -Eo '[+-]?[0-9]+([.][0-9]+)?' | tail -n1); solarenergy_today_integer=$( printf "%.0f\n" "${solarenergy_today}e15" ); abort_solar_yield_today_integer=$( printf "%.0f\n" "${abort_solar_yield_today}e15" ); }
function get_solarenergy_tomorrow { solarenergy_tomorrow=$(sed -n 3{p} $file3 | grep -Eo '[+-]?[0-9]+([.][0-9]+)?' | tail -n1); solarenergy_tomorrow_integer=$( printf "%.0f\n" "${solarenergy_tomorrow}e15" ); abort_solar_yield_tomorrow_integer=$( printf "%.0f\n" "${abort_solar_yield_tomorrow}e15" );}

if (( ( $select_pricing_api == 1 ) )); then

# test if Awattar today data exists
if test -f "$file1"; then
  # test if data is current
  get_current_awattar_day
  if [ "$current_awattar_day" = "$(TZ=$TZ date +%d)" ]; then
    echo "Awattar today-data is up to date."
  else
    echo "Awattar today-data is outdated, fetching new data."
    rm $file1
    rm $file6
    rm $file7
    download_awattar_prices_today
  fi
else # data file1 does not exist
  download_awattar_prices_today
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
    rm $file4
    rm $file8
    rm $file10
    rm $file11
    rm $file12
    download_entsoe_prices_today

  fi
else # Entsoe data does not exist
  download_entsoe_prices_today
fi
fi

if (( ( $include_second_day == 1 ) )); then
if (( ( $select_pricing_api == 1 ) )); then

# test if Awattar tomorrow data exists
if test -f "$file2"; then
  # test if data is current
  get_current_awattar_day2
  if [ "$current_awattar_day2" = "$(TZ=$TZ date +%d)" ]; then
    echo "Awattar tomorrow-data is up to date."
  else
    echo "Awattar tomorrow-data is outdated, fetching new data."
    rm $file3
    download_awattar_prices_tomorrow
  fi
else # data file2 does not exist
  download_awattar_prices_tomorrow

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
    rm $file5
    rm $file9
    rm $file13
    download_entsoe_prices_tomorrow
  fi
else # data file5 does not exist
  download_entsoe_prices_tomorrow
fi
fi
fi

if (( ( $select_pricing_api == 1 ) )); then
Unit="Cent/kWh"
get_current_price_awattar
get_lowest_price_awattar
get_second_lowest_price_awattar
get_third_lowest_price_awattar
get_fourth_lowest_price_awattar
get_fifth_lowest_price_awattar
get_sixth_lowest_price_awattar
get_prices_integer_awattar
fi

if (( ( $select_pricing_api == 2 ) )); then
Unit="EUR/MWh"
get_current_price_entsoe
get_lowest_price_entsoe
get_second_lowest_price_entsoe
get_third_lowest_price_entsoe
get_fourth_lowest_price_entsoe
get_fifth_lowest_price_entsoe
get_sixth_lowest_price_entsoe
get_prices_integer_entsoe
fi

if (( ( $use_solarweather_api_to_abort == 1 ) )); then
download_solarenergy
get_solarenergy_today
get_solarenergy_tomorrow
fi

echo Please verify correct system time and timezone:
TZ=$TZ date
echo "Current price is" $current_price" $Unit netto."
echo "Lowest price will be" $lowest_price" $Unit netto."
echo "Second lowest price will be" $second_lowest_price" $Unit netto."
echo "Third lowest price will be" $third_lowest_price" $Unit netto."
echo "Fourth lowest price will be" $fourth_lowest_price" $Unit netto."
echo "Fifth lowest price will be" $fifth_lowest_price" $Unit netto."
echo "Sixth lowest price will be" $sixth_lowest_price" $Unit netto."
if (( ( $use_solarweather_api_to_abort == 1 ) )); then
echo "Solarenergy today will be" $solarenergy_today" megajoule per sqaremeter."
echo "Solarenergy tomorrow will be" $solarenergy_tomorrow" megajoule per squaremeter."
[ -s $file3 ]  && >nul || echo "Error: $file3 is empty, please check your API Key if download is still not possible tomorrow."
find $file3 -size 0 -delete
fi

if ((use_start_stop_logic == 1 && stop_price_integer < start_price_integer)); then
  echo "stop price cannot be lower than start price"
  exit 1
fi
if ((abort_price_integer <= current_price_integer)); then
  echo "Current price is too high. Abort."
  exit 0
fi
if ((use_solarweather_api_to_abort == 1)); then
  if ((abort_solar_yield_today_integer <= solarenergy_today_integer)); then
    echo "There is enough sun today. Abort."
    exit 0
  fi
  if ((abort_solar_yield_tomorrow_integer <= solarenergy_tomorrow_integer)); then
    echo "There is enough sun tomorrow. Abort."
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


# Check if any charging condition is met
for condition in "${charging_conditions[@]}"; do
  if (( $condition )); then
    execute_charging=1
    break
  fi
done


fritz_dect_conditions=(
"fritz_dect_at_start_stop == 1 && start_price_integer > current_price_integer"
"fritz_dect_at_solar_breakeven_logic == 1  && feedin_price_integer > current_price_integer + energy_fee_integer"
"fritz_dect_at_lowest_price == 1 && lowest_price_integer == current_price_integer"
"fritz_dect_at_second_lowest_price == 1 && second_lowest_price_integer == current_price_integer"
"fritz_dect_at_third_lowest_price == 1 && third_lowest_price_integer == current_price_integer"
"fritz_dect_at_fourth_lowest_price == 1  && fourth_lowest_price_integer == current_price_integer"
"fritz_dect_at_fifth_lowest_price == 1 && fifth_lowest_price_integer == current_price_integer"
"fritz_dect_at_sixth_lowest_price == 1 && sixth_lowest_price_integer == current_price_integer"
)

execute_fritz_dect_on=0

# Check if any Fritz DECT condition is met
for fritz_dect_condition in "${fritz_dect_conditions[@]}"; do
  if (( $fritz_dect_condition == 1 )); then
    execute_fritz_dect_on=1
    break
  fi
done

# If any charging condition is met, start charging
if (( execute_charging == 1 )); then
  echo "starting charging"
  dbus -y com.victronenergy.settings /Settings/CGwacs/BatteryLife/Schedule/Charge/0/Day SetValue -- 7
fi

# If any Fritz DECT condition is met, execute Fritz DECT on command
  if (( execute_fritz_dect_on == 1 )); then

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
    printf "Error: Login failed.\n"
    exit 1
fi

printf "Login successful.\n\n"

# Iterate over each socket
for socket in "${sockets[@]}"; do
    if [ "$socket" = "0" ]; then
        continue
    fi

    # Get state and connectivity of socket
    connected=$(curl -s "http://$fbox/webservices/homeautoswitch.lua?sid=$sid&ain=$socket&switchcmd=getswitchpresent")
    state=$(curl -s "http://$fbox/webservices/homeautoswitch.lua?sid=$sid&ain=$socket&switchcmd=getswitchstate")

    printf "Socket $socket: "
    if [ "$connected" = "1" ]; then
        printf "$state\n"
        printf "Turning on for almost 60 minutes and then off again...\n"
        curl -s "http://$fbox/webservices/homeautoswitch.lua?sid=$sid&ain=$socket&switchcmd=setswitchon" >/dev/null
    else
        printf "Not connected\n"
    fi
done

# Wait for almost 60 minutes
sleep 3560

# Turn off each socket
for socket in "${sockets[@]}"; do
    if [ "$socket" = "0" ]; then
        continue
    fi

    curl -s "http://$fbox/webservices/homeautoswitch.lua?sid=$sid&ain=$socket&switchcmd=setswitchoff" >/dev/null
done
fi
