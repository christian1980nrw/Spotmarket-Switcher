#!/bin/bash


VERSION="2.4.4-DEV"

set -e

if [ -z "$LANG" ]; then
    export LANG="C"
fi

# Note: This script is only for hourly-based tariff data, please create your own fork for higher resolutions like 15 minute intervals.

#######################################
###    Begin of the functions...    ###
#######################################

if [[ ${BASH_VERSINFO[0]} -le 4 ]]; then
    valid_config_version=4 # Please increase this value by 1 when changing the configuration variables
else
    declare -A valid_vars=(
    	["config_version"]="4" # Please increase this value by 1 if variables are added or deleted in the valid_vars array
        ["use_fritz_dect_sockets"]="0|1"
        ["fbox"]="^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$"
        ["user"]="string"
        ["passwd"]="string"
        ["sockets"]='^\(\"[^"]+\"( \"[^"]+\")*\)$'
        ["use_shelly_wlan_sockets"]="0|1"
        ["shelly_ips"]="^\(\".*\"\)$"
        ["shellyuser"]="string"
        ["shellypasswd"]="string"
        ["use_victron_charger"]="0|1"
        ["limit_inverter_power_after_enabling"]="^(-1|[0-9]{2,5})$"
        ["energy_loss_percent"]="[0-9]+(\.[0-9]+)?"
        ["battery_lifecycle_costs_cent_per_kwh"]="[0-9]+(\.[0-9]+)?"
        ["economic_check"]="0|1|2"
        ["start_price"]="-?[0-9]+(\.[0-9]+)?"
        ["feedin_price"]="[0-9]+(\.[0-9]+)?"
        ["energy_fee"]="[0-9]+(\.[0-9]+)?"
        ["abort_price"]="[0-9]+(\.[0-9]+)?"
        ["use_start_stop_logic"]="0|1"
        ["switchablesockets_at_start_stop"]="0|1"
        ["charge_at_solar_breakeven_logic"]="0|1"
        ["switchablesockets_at_solar_breakeven_logic"]="0|1"
        ["TZ"]="string"
        ["select_pricing_api"]="1|2|3"
        ["include_second_day"]="0|1"
        ["use_solarweather_api_to_abort"]="0|1"
        ["abort_solar_yield_today"]="[0-9]+(\.[0-9]+)?"
        ["abort_solar_yield_tomorrow"]="[0-9]+(\.[0-9]+)?"
        ["abort_suntime"]="[0-9]+"
        ["latitude"]="[-]?[0-9]+(\.[0-9]+)?"
        ["longitude"]="[-]?[0-9]+(\.[0-9]+)?"
        ["visualcrossing_api_key"]="string"
        ["awattar"]="de|at"
        ["in_Domain"]="string"
        ["out_Domain"]="string"
        ["entsoe_eu_api_security_token"]="string"
        ["tibber_prices"]="energy|total|tax"
        ["tibber_api_key"]="string"
        ["config_version"]="4"
    )

    declare -A config_values
fi

parse_and_validate_config() {
    if [[ ${BASH_VERSINFO[0]} -le 4 ]]; then
        # Für Bash-Version <= 4, überprüfe nur config_version=1
	log_message "W: Due to the older Bash version, the configuration validation is skipped."
        local file="$1"
        local version_valid=false
        while IFS='=' read -r key value; do
            key=$(echo "$key" | cut -d'#' -f1 | tr -d ' ')
            value=$(echo "$value" | awk -F'#' '{gsub(/^ *"|"$|^ *| *$/, "", $1); print $1}')
            if [[ "$key" == "config_version" && "$value" == "$valid_config_version" ]]; then
                version_valid=true
                break
            fi
        done <"$file"
        
        if [[ "$version_valid" == false ]]; then
            log_message "E: Error: config_version=$valid_config_version is missing or the configuration is invalid."
            return 1
        fi
        return 0
    else    
        local file="$1"
        local errors=""
        rotating_spinner &   # Start the spinner in the background
        local spinner_pid=$! # Get the PID of the spinner
        local version_valid=false
        local version_value=0

        # Step 1: Parse
        while IFS='=' read -r key value; do
            # Treat everything after a "#" as a comment and remove it
            key=$(echo "$key" | cut -d'#' -f1 | tr -d ' ')
            value=$(echo "$value" | awk -F'#' '{gsub(/^ *"|"$|^ *| *$/, "", $1); print $1}')

            # Only process rows with key-value pairs
            [[ "$key" == "" || "$value" == "" ]] && continue

            # Set the value in the associative array
            config_values["$key"]="$value"
	
            if [[ "$key" == "config_version" ]]; then
                version_valid=true
                version_value="$value"
	        fi
        done <"$file"

        # Step 2: Validation
        for var_name in "${!valid_vars[@]}"; do
            local validation_pattern=${valid_vars[$var_name]}

            # Check whether the variable was set at all
            if [[ -z ${config_values[$var_name]+x} ]]; then
                errors+="E: $var_name is not set.\n"
                continue
            fi

            if [[ "$validation_pattern" == "string" ]]; then
                continue
            elif [[ "$validation_pattern" == "array" && "${config_values[$var_name]}" == "" ]]; then
                continue
            elif [[ "$validation_pattern" == "ip" && ! "${config_values[$var_name]}" =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
                errors+="E: $var_name has an invalid IP address format: ${config_values[$var_name]}.\n"
                continue
            fi

            if ! [[ "${config_values[$var_name]}" =~ ^($validation_pattern)$ ]]; then
                errors+="E: $var_name has an invalid value: ${config_values[$var_name]}.\n"
            fi
        done

        if [[ "$version_valid" == true && "$version_value" -lt 1 ]]; then
            errors+="W: The config.txt version is less than 1. You are using an outdated unsupported configuration file. Please re-download and reconfigurate. \n"
        fi

        kill $spinner_pid &>/dev/null

        if [[ -n "$errors" ]]; then
            echo -e "$errors"
            return 1
        else
            echo "Config validation passed."
            return 0
        fi
    fi
}

rotating_spinner() {
    local delay=0.1
    local spinstr="|/-\\"
    while true; do
        local temp=${spinstr#?}
        printf " [%c]  Loading..." "$spinstr"
        spinstr=$temp${spinstr%"$temp"}
        sleep $delay
        printf "\r"
    done
}

download_awattar_prices() {
    local url="$1"
    local file="$2"
    local output_file="$3"
    local sleep_time="$4"

    if [ -z "$DEBUG" ]; then
        log_message "I: Please be patient. First we wait $sleep_time seconds in case the system clock is not syncronized and not to overload the API." false
        sleep "$sleep_time"
    fi
    if ! curl "$url" >"$file"; then
        log_message "E: Download of aWATTar prices from '$url' to '$file' failed."
        exit_with_cleanup 1
    fi

    if ! test -f "$file"; then
        log_message "E: Could not get aWATTar prices from '$url' to feed file '$file'."
        exit_with_cleanup 1
    fi

    if [ -n "$DEBUG" ]; then
        log_message "D: Download of file '$file' from URL '$url' successful." >&2
    fi
    echo >>"$file"
    awk '/data_price_hour_rel_.*_amount: / {print substr($0, index($0, ":") + 2)}' "$file" >"$output_file"
    sort -g "$output_file" >"${output_file%.*}_sorted.${output_file##*.}"
    timestamp=$(TZ=$TZ date +%d)
    echo "date_now_day: $timestamp" >>"$output_file"
    echo "date_now_day: $timestamp" >>"${output_file%.*}_sorted.${output_file##*.}"

    if [ -f "$file2" ] && [ "$(wc -l <"$file1")" = "$(wc -l <"$file2")" ]; then
        rm -f "$file2"
        log_message "I: File '$file2' has no tomorrow data, we have to try it again until the new prices are online." false
    fi
}

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

download_tibber_prices() {
    local url="$1"
    local file="$2"
    local sleep_time="$3"

    if [ -z "$DEBUG" ]; then
        log_message "I: Please be patient. First we wait $sleep_time seconds in case the system clock is not syncronized and not to overload the API." false
        sleep "$sleep_time"
    else
        log_message "D: No delay of download of Tibber data since DEBUG variable set."
    fi
    if ! get_tibber_api | tr -d '{}[]' >"$file"; then
        log_message "E: Download of Tibber prices from '$url' to '$file' failed."
        exit_with_cleanup 1
    fi

    sed -n '/"today":/,/"tomorrow":/p' "$file" | sed '$d' | sed '/"today":/d' >"$file15"
    sort -t, -k1.9n $file15 >"$file16"
    sed -n '/"tomorrow":/,$p' "$file" | sed '/"tomorrow":/d' >"$file17"
    sort -t, -k1.9n $file17 >"$file18"
    if [ "$include_second_day" = 0 ]; then
        cp "$file16" "$file12"
    else
    
    sed -n '4,$p' "$file14" | grep '"total"' | sort -t':' -k2 -n > "$file12"

    fi

    timestamp=$(TZ=$TZ date +%d)
    echo "date_now_day: $timestamp" >>"$file15"
    echo "date_now_day: $timestamp" >>"$file17"

    if [ ! -s "$file16" ]; then
        log_message "E: Tibber prices cannot be extracted to '$file16', please check your Tibber API Key."
        rm "$file"
        exit_with_cleanup 1
    fi
}

download_entsoe_prices() {
    local url="$1"
    local file="$2"
    local output_file="$3"
    local sleep_time="$4"

    if [ -z "$DEBUG" ]; then
        log_message "I: Please be patient. First we wait $sleep_time seconds in case the system clock is not syncronized and not to overload the API."
        sleep "$sleep_time"
    else
        log_message "D: No delay of download of entsoe data since DEBUG variable set." >&2
    fi

    if ! curl "$url" >"$file"; then
        log_message "E: Retrieval of entsoe data from '$url' into file '$file' failed."
        exit_with_cleanup 1
    fi

    if ! test -f "$file"; then
        log_message "E: Could not find file '$file' with entsoe price data. Curl itself reported success."
        exit_with_cleanup 1
    fi

    if [ -n "$DEBUG" ]; then log_message "D: Entsoe file '$file' with price data downloaded" >&2; fi

    if [ ! -s "$file" ]; then
        log_message "E: Entsoe file '$file' is empty, please check your entsoe API Key."
        exit_with_cleanup 1
    fi

    if [ -n "$DEBUG" ]; then log_message "D: No delay of download of entsoe data since DEBUG variable set." "D: Entsoe file '$file' with price data downloaded" >&2; fi

    awk '
	            error_found=0
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
        print "E: Entsoe data retrieval error found in the XML data:", error_message
    } else if (prices != "") {
        printf "%s", prices > "'"$output_file"'"
    } else {
        print "E: No prices found in the XML data."
    }
}
' "$file"

if [ -f "$output_file" ]; then
    sort -g "$output_file" > "${output_file%.*}_sorted.${output_file##*.}"
    timestamp=$(TZ=$TZ date +%d)
    echo "date_now_day: $timestamp" >> "$output_file"

    # Check if the file for tomorrow contains prices for the next day
    if [ "$include_second_day" = 1 ] && grep -q "PT60M" "$file" && [ "$(wc -l <"$output_file")" -gt 3 ]; then
        cat $file10 > $file8
        if [ -f "$file13" ]; then
            cat "$file13" >> "$file8"
        fi
        sed -i '25d;50d' "$file8"
        sort -g "$file8" > "$file19"
        timestamp=$(TZ=$TZ date +%d)
        echo "date_now_day: $timestamp" >> "$file8"
    else
        cp $file11 $file19  # If there's no second day, copy the sorted price file.
    fi
fi

}

download_solarenergy() {
    if ((use_solarweather_api_to_abort == 1)); then
        delay=$((RANDOM % 15 + 1))
        if [ -z "$DEBUG" ]; then
            log_message "I: Please be patient. A delay of $delay seconds will help avoid overloading the Solarweather-API." false
            sleep "$delay"
        else
            log_message "D: No delay of download of solarenergy data since DEBUG variable set." >&2
        fi

        if ! curl "$link3" -o "$file3"; then
            log_message "E: Download of solarenergy data from '$link3' failed. Solarenergy will be ignored."
        elif ! test -f "$file3"; then
            log_message "E: Could not get solarenergy data, missing file '$file3'. Solarenergy will be ignored."
        fi

        if grep -q "API" "$file3"; then
            log_message "E: Error, there is a problem with the Solarweather-API."
			cat "$file3"
            return 1
        fi

        if [ -n "$DEBUG" ]; then
            log_message "D: File3 $file3 downloaded" >&2
        fi
        if ! test -f "$file3"; then
            log_message "E: Could not find downloaded file '$file3' with solarenergy data. Solarenergy will be ignored."
        fi
        if [ -n "$DEBUG" ]; then
            log_message "D: Solarenergy data downloaded to file '$file3'."
        fi
    fi
}

get_current_awattar_day() { current_awattar_day=$(sed -n 3p $file1 | grep -Eo '[0-9]+'); }
get_current_awattar_day2() { current_awattar_day2=$(sed -n 3p $file2 | grep -Eo '[0-9]+'); }

get_awattar_prices() {
    current_price=$(sed -n $((2 * $(TZ=$TZ date +%k) + 39))p $file1 | grep -Eo '[+-]?[0-9]+([.][0-9]+)?' | tail -n1)
    for i in $(seq 1 $loop_hours); do
        eval P$i=$(sed -n ${i}p "$file7")
    done
    highest_price=$(grep -E '^[0-9]+\.[0-9]+$' "$file7" | tail -n1)
    average_price=$(grep -E '^[0-9]+\.[0-9]+$' "$file7" | awk '{sum+=$1; count++} END {if (count > 0) print sum/count}')
}

get_tibber_prices() {
    current_price=$(sed -n "${now_linenumber}s/.*\"${tibber_prices}\":\([^,]*\),.*/\1/p" "$file15")
    for i in $(seq 1 $loop_hours); do
        eval P$i=$(sed -n "${i}s/.*\"${tibber_prices}\":\([^,]*\),.*/\1/p" "$file12")
    done
    highest_price=$(sed -n "s/.*\"${tibber_prices}\":\([^,]*\),.*/\1/p" "$file12" | awk 'BEGIN {max = 0} {if ($1 > max) max = $1} END {print max}')
    average_price=$(sed -n "s/.*\"${tibber_prices}\":\([^,]*\),.*/\1/p" "$file12" | awk '{sum += $1} END {print sum/NR}')
}

get_current_entsoe_day() { current_entsoe_day=$(sed -n 25p "$file10" | grep -Eo '[0-9]+'); }

get_current_tibber_day() { current_tibber_day=$(sed -n 25p "$file15" | grep -Eo '[0-9]+'); }

get_entsoe_prices() {
    current_price=$(sed -n ${now_linenumber}p "$file10")
    for i in $(seq 1 $loop_hours); do
        eval P$i=$(sed -n ${i}p "$file19")
    done
    highest_price=$(awk 'BEGIN {max = 0} $1>max {max=$1} END {print max}' "$file19")
    average_price=$(awk 'NF>0 && $1 ~ /^[0-9]*(\.[0-9]*)?$/ {sum+=$1; count++} END {if (count > 0) print sum/count}' "$file19")
}

convert_vars_to_integer() {
    local potency="$1"
    shift
    for var in "$@"; do
        local integer_var="${var}_integer"
        printf -v "$integer_var" '%s' "$(euroToMillicent "${!var}" "$potency")"
        local value="${!integer_var}" # Speichern Sie den Wert in einer temporären Variable
        if [ -n "$DEBUG" ]; then
            log_message "D: Variable: $var | Original: ${!var} | Integer: $value | Len: ${#value}" >&2
        fi
    done
}

get_awattar_prices_integer() {
    local price_vars=""
    for i in $(seq 1 $loop_hours); do
        price_vars+="P$i "
    done
    price_vars+="average_price highest_price current_price start_price feedin_price energy_fee abort_price battery_lifecycle_costs_cent_per_kwh"
    convert_vars_to_integer 15 $price_vars
}

get_tibber_prices_integer() {
    local price_vars=""
    for i in $(seq 1 $loop_hours); do
        price_vars+="P$i "
    done
    price_vars+="average_price highest_price current_price"
    convert_vars_to_integer 17 $price_vars

    convert_vars_to_integer 15 start_price feedin_price energy_fee abort_price battery_lifecycle_costs_cent_per_kwh
}

get_prices_integer_entsoe() {
    local price_vars=""
    for i in $(seq 1 $loop_hours); do
        price_vars+="P$i "
    done
    price_vars+="average_price highest_price current_price"
    convert_vars_to_integer 14 $price_vars

    convert_vars_to_integer 15 start_price feedin_price energy_fee abort_price battery_lifecycle_costs_cent_per_kwh
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

# Function to evaluate conditions
evaluate_conditions() {
    local -n conditions=$1
    local -n descriptions=$2
    local -n execute_flag=$3
    local -n condition_met_description=$4

    for i in "${!conditions[@]}"; do
        if (( ${conditions[$i]} )); then
            execute_flag=1
            condition_met_description="${descriptions[$i]}"

            if [[ $DEBUG -eq 1 ]]; then
                log_message "D: Condition met: ${condition_met_description}"
            fi

            # Exit the loop if a condition is met
            return
        fi
    done

    # If no condition is met
    execute_flag=0
    condition_met_description=""
}

# Function to check economical
is_charging_economical() {
    local reference_price="$1"
    local total_cost="$2"

    local is_economical=1
    [[ $reference_price -ge $total_cost ]] && is_economical=0

    if [ -n "$DEBUG" ]; then
        log_message "D: is_charging_economical [ $is_economical - $([ "$is_economical" -eq 1 ] && echo "false" || echo "true") ]." >&2
        reference_price_euro=$(millicentToEuro $reference_price)
        total_cost_euro=$(millicentToEuro $total_cost)
        is_economical_str=$([ "$is_economical" -eq 1 ] && echo "false" || echo "true")
        log_message "D: if [ reference_price $reference_price_euro > total_cost $total_cost_euro ] result is $is_economical_str." >&2
    fi

    return $is_economical
}

# Function to calculate dynamic SOC based on the expected solarenergy
get_target_soc() {
    local megajoule=$1
    local result=""

    for ((i = 1; i < ${#config_matrix_target_soc_weather[@]}; i++)); do
        IFS=' ' read -ra line <<< "${config_matrix_target_soc_weather[$i]}"

        if awk -v megajoule="$megajoule" -v lower="${config_matrix_target_soc_weather[i-1]%% *}" \
            -v upper="${line[0]}" 'BEGIN {exit !(megajoule >= lower && megajoule < upper)}'; then
            result=$(awk -v megajoule="$megajoule" -v lower="${config_matrix_target_soc_weather[i-1]%% *}" \
                -v upper="${line[0]}" -v lower_soc="${config_matrix_target_soc_weather[i-1]##* }" -v upper_soc="${line[1]}" \
                'BEGIN {printf "%.0f", lower_soc + (megajoule - lower) * (upper_soc - lower_soc) / (upper - lower)}')
            break
        fi

        if awk -v megajoule="$megajoule" -v lower="${config_matrix_target_soc_weather[1]%% *}" \
            'BEGIN {exit !(megajoule <= lower)}'; then
            result="${config_matrix_target_soc_weather[1]##* }"
            break
        fi

        if (( i == ${#config_matrix_target_soc_weather[@]} - 1 )) && \
           awk -v megajoule="$megajoule" -v upper="${line[0]}" 'BEGIN {exit !(megajoule >= upper)}'; then
            result="${line[1]}"
            break
        fi
    done

    echo "${result:-"No target SoC found."}"
}

# Function to manage charging
manage_charging() {
    local action=$1
    local reason=$2

    if [[ $action == "on" ]]; then
        $charger_command_charge >/dev/null
        log_message "I: Victron scheduled charging is ON. Battery SOC is at $SOC_percent %. $reason"
    else
        $charger_command_stop_charging >/dev/null
        log_message "I: Victron scheduled charging is OFF. Battery SOC is at $SOC_percent %. $reason"
    fi
}

# Function to manage discharging
manage_discharging() {
    local action=$1
    local reason=$2

    if [[ $action == "on" ]]; then
        $charger_enable_inverter >/dev/null
        log_message "I: Victron discharging (ESS) is ON. Battery SOC is at $SOC_percent %. $reason"
    else
        $charger_disable_inverter >/dev/null
        log_message "I: Victron discharging (ESS) is OFF. Battery SOC is at $SOC_percent %. $reason"
    fi
}

# Function to check abort conditions and log a message
check_abort_condition() {
    local condition_result=$1
    local log_message=$2

    if ((condition_result)); then
        log_message "I: $log_message Abort."
        execute_charging=0
        execute_switchablesockets_on=0
    fi
}

# Function to manage fritz sockets and log a message
manage_fritz_sockets() {
    if [ -n "$DEBUG" ]; then
    log_message "D: Managing Fritz sockets - Action: $action, execute_switchablesockets_on: $execute_switchablesockets_on"
	fi
    local action=$1

    [ "$action" != "off" ] && action=$([ "$execute_switchablesockets_on" == "1" ] && echo "on" || echo "off")

    if fritz_login; then
        log_message "I: Turning $action Fritz sockets."
        for socket in "${sockets[@]}"; do
            [ "$socket" != "0" ] && manage_fritz_socket "$action" "$socket"
        done
    else
        log_message "E: Fritz login failed."
    fi
}

manage_fritz_socket() {
    local action=$1
    local socket=$2

    if [ "$1" != "off" ] && [ "$economic" == "expensive" ] && [ "$use_victron_charger" == "1" ]; then
        log_message "I: Disabling inverter while switching."
        $charger_disable_inverter >/dev/null
    fi
    local url="http://$fbox/webservices/homeautoswitch.lua?sid=$sid&ain=$socket&switchcmd=setswitch$action"
    curl -s "$url" >/dev/null || log_message "E: Could not call URL '$url' to switch $action said switch - ignored."
}

fritz_login() {
    # Get session ID (SID)
    sid=""
    challenge=$(curl -s "http://$fbox/login_sid.lua" | grep -o "<Challenge>[a-z0-9]\{8\}" | cut -d'>' -f 2)
    if [ -z "$challenge" ]; then
        log_message "E: Could not retrieve challenge from login_sid.lua."
        return 1
    fi

    hash=$(echo -n "$challenge-$passwd" | sed -e 's,.,&\n,g' | tr '\n' '\0' | md5sum | grep -o "[0-9a-z]\{32\}")
    sid=$(curl -s "http://$fbox/login_sid.lua" -d "response=$challenge-$hash" -d "username=$user" |
        grep -o "<SID>[a-z0-9]\{16\}" | cut -d'>' -f 2)

    if [ "$sid" = "0000000000000000" ]; then
        log_message "E: Login to Fritz!Box failed."
        return 1
    fi

    if [ -n "$DEBUG" ]; then
        log_message "D: Login to Fritz!Box successful." >&2
    fi
    return 0
}

# Function to manage shelly and log a message
manage_shelly_sockets() {
    local action=$1

    [ "$action" != "off" ] && action=$([ "$execute_switchablesockets_on" == "1" ] && echo "on" || echo "off")

    log_message "I: Turning $action Shelly sockets."
    for ip in "${shelly_ips[@]}"; do
        [ "$ip" != "0" ] && manage_shelly_socket "$action" "$ip"
    done
}

manage_shelly_socket() {
    local action=$1
    local ip=$2
    if [ "$1" != "off" ] && [ "$economic" == "expensive" ] && [ "$use_victron_charger" == "1" ]; then
        log_message "I: Disabling inverter while switching."
        $charger_disable_inverter >/dev/null
    fi
    curl -s -u "$shellyuser:$shellypasswd" "http://$ip/relay/0?turn=$action" -o /dev/null || log_message "E: Could not execute switch-$action of Shelly socket with IP $ip - ignored."
}

millicentToEuro() {
    local millicents="$1"

    local EURO_FACTOR=100000000000000000
    local DECIMAL_FACTOR=10000000000000

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

    # Replace each comma with a period, fixme if this is wrong
    euro=$(echo "$euro" | sed 's/,/./g')

    v=$(awk -v euro="$euro" -v potency="$potency" 'BEGIN {printf "%.0f", euro * (10 ^ potency)}')

    if [ -z "$v" ]; then
        log_message "E: Could not translate '$euro' to an integer."
        log_message "E: Called from ${FUNCNAME[1]} at line ${BASH_LINENO[0]}"
        return 1
    fi
    echo "$v"
    return 0
}

log_message() {
    local msg="$1"
    local prefix=$(echo "$msg" | head -n 1 | cut -d' ' -f1)
    local color="\033[1m"
    local writeToLog=true

    case "$prefix" in
    "E:") color="\033[1;31m" ;;
    "D:")
        color="\033[1;34m"
        writeToLog=false
        ;;
    "W:") color="\033[1;33m" ;;
    "I:") color="\033[1;32m" ;;
    esac

    writeToLog="${2:-$writeToLog}" # Override default if second parameter is provided

    printf "${color}%b\033[0m\n" "$msg"

    if [ "$writeToLog" == "true" ]; then
        echo -e "$msg" | sed 's/\x1b\[[0-9;]*m//g' >>"$LOG_FILE"
    fi
}

exit_with_cleanup() {
    log_message "I: Cleanup and exit with error $1"
    manage_charging "off" "Turn off charging."
    manage_fritz_sockets "off"
    manage_shelly_sockets "off"
    exit $1
}

####################################
###    Begin of the script...    ###
####################################

# Path to the current script directory
DIR="$(dirname "$0")"

if [ -z "$LOG_FILE" ]; then
    LOG_FILE="/tmp/spotmarket-switcher.log"
fi
if [ -z "$LOG_MAX_SIZE" ]; then
    LOG_MAX_SIZE=1024 # 1 MB
fi
if [ -z "$LOG_FILES_TO_KEEP" ]; then
    LOG_FILES_TO_KEEP=2
fi

if [ -z "$CONFIG" ]; then
    CONFIG="config.txt"
fi

if [ -f "$DIR/$CONFIG" ]; then
    source "$DIR/$CONFIG"

num_tools_missing=0
tools="awk curl cat sed sort head tail"
if [ 0 -lt $use_victron_charger ]; then
    tools="$tools dbus"
    charger_command_charge="dbus -y com.victronenergy.settings /Settings/CGwacs/BatteryLife/Schedule/Charge/0/Day SetValue -- 7"
    charger_command_stop_charging="dbus -y com.victronenergy.settings /Settings/CGwacs/BatteryLife/Schedule/Charge/0/Day SetValue -- -7"
    charger_command_set_SOC_target="dbus -y com.victronenergy.settings /Settings/CGwacs/BatteryLife/Schedule/Charge/0/Soc SetValue -- "
    charger_get_inverter_status="dbus -y com.victronenergy.settings /Settings/CGwacs/MaxDischargePower GetValue"
    charger_disable_inverter="dbus -y com.victronenergy.settings /Settings/CGwacs/MaxDischargePower SetValue -- 0"
    charger_enable_inverter="dbus -y com.victronenergy.settings /Settings/CGwacs/MaxDischargePower SetValue -- $limit_inverter_power_after_enabling"
    SOC_percent=$(dbus-send --system --print-reply --dest=com.victronenergy.system /Dc/Battery/Soc com.victronenergy.BusItem.GetValue | grep variant | awk '{print $3}') # This will get the battery state of charge (SOC) from a Victron Energy system
fi

for tool in $tools; do
    if ! which "$tool" >/dev/null; then
        log_message "E: Please ensure the tool '$tool' is found."
        num_tools_missing=$((num_tools_missing + 1))
    fi
done

if [ $num_tools_missing -gt 0 ]; then
    log_message "E: $num_tools_missing tools are missing."
    exit 127
fi

unset num_tools_missing

else
    log_message "E: The file $DIR/$CONFIG was not found! Configure the existing sample.config.txt file and then save it as config.txt in the same directory." false
    exit 127
fi

if [ -f "$DIR/license.txt" ]; then
    # Include the configuration file
    source "$DIR/license.txt"
else
    log_message "E: The file $DIR/license.txt was not found! Please read the license.txt file and save it together with the config.txt in the same directory. Thank you." false
    exit 127
fi

if [ -z "$UNAME" ]; then
    UNAME=$(uname)
fi
if [ "Darwin" = "$UNAME" ]; then
    log_message "W: MacOS has a different implementation of 'date' - use conda if hunting a bug on a mac".
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

########## Start ##########

echo >>"$LOG_FILE"

log_message "I: Bash Version: $(bash --version | head -n 1)"
log_message "I: Spotmarket-Switcher - Version $VERSION"

parse_and_validate_config "$DIR/$CONFIG"

if ((select_pricing_api == 1)); then
    # Test if Awattar today data exists
    if test -f "$file1"; then
        # Test if data is current
        get_current_awattar_day
        if [ "$current_awattar_day" = "$(TZ=$TZ date +%-d)" ]; then
            log_message "I: aWATTar today-data is up to date." false
        else
            log_message "I: aWATTar today-data is outdated, fetching new data." false
            rm -f $file1 $file6 $file7
            download_awattar_prices "$link1" "$file1" "$file6" $((RANDOM % 21 + 10))
        fi
    else # Data file1 does not exist
        log_message "I: Fetching today-data data from aWATTar." false
        download_awattar_prices "$link1" "$file1" "$file6" $((RANDOM % 21 + 10))
    fi

elif ((select_pricing_api == 2)); then
    # Test if Entsoe today data exists
    if test -f "$file10"; then
        # Test if data is current
        get_current_entsoe_day
        if [ "$current_entsoe_day" = "$(TZ=$TZ date +%d)" ]; then
            log_message "I: Entsoe today-data is up to date." false
        else
            log_message "I: Entsoe today-data is outdated, fetching new data." false
            rm -f "$file4" "$file5" "$file8" "$file9" "$file10" "$file11" "$file13" "$file19"
            download_entsoe_prices "$link4" "$file4" "$file10" $((RANDOM % 21 + 10))
        fi
    else # Entsoe data does not exist
        log_message "I: Fetching today-data data from Entsoe." false
        download_entsoe_prices "$link4" "$file4" "$file10" $((RANDOM % 21 + 10))
    fi

elif ((select_pricing_api == 3)); then

    # Test if Tibber today data exists
    if test -f "$file14"; then
        # Test if data is current
        get_current_tibber_day
        if [ "$current_tibber_day" = "$(TZ=$TZ date +%d)" ]; then
            log_message "I: Tibber today-data is up to date." false
        else
            log_message "I: Tibber today-data is outdated, fetching new data." false
            rm -f "$file12" "$file14" "$file15" "$file16"
            download_tibber_prices "$link6" "$file14" $((RANDOM % 21 + 10))
        fi
    else # Tibber data does not exist
        log_message "I: Fetching today-data data from Tibber." false
        download_tibber_prices "$link6" "$file14" $((RANDOM % 21 + 10))
    fi
fi

if ((include_second_day == 1)); then

    if ((select_pricing_api == 1)); then

        # Test if Awattar tomorrow data exists
        if test -f "$file2"; then
            # Test if data is current
            get_current_awattar_day2
            if [ "$current_awattar_day2" = "$(TZ=$TZ date +%-d)" ]; then
                log_message "I: aWATTar tomorrow-data is up to date." false
            else
                log_message "I: aWATTar tomorrow-data is outdated, fetching new data." false
                rm -f $file3
                download_awattar_prices "$link2" "$file2" "$file6" $((RANDOM % 21 + 10))
            fi
        else # Data file2 does not exist
            log_message "I: aWATTar tomorrow-data does not exist, fetching data." false
            download_awattar_prices "$link2" "$file2" "$file6" $((RANDOM % 21 + 10))
        fi

    elif ((select_pricing_api == 2)); then

        # Test if Entsoe tomorrow data exists
        if [ ! -s "$file9" ]; then
            log_message "I: File '$file9' has no tomorrow data, we have to try it again until the new prices are online." false
            rm -f "$file5" "$file9" "$file13"
            download_entsoe_prices "$link5" "$file5" "$file13" $((RANDOM % 21 + 10))
        fi

    elif ((select_pricing_api == 3)); then

        if [ ! -s "$file18" ]; then
            rm -f "$file17" "$file18"
            log_message "I: File '$file18' has no tomorrow data, we have to try it again until the new prices are online." false
            rm -f "$file12" "$file14" "$file15" "$file16" "$file17" "$file18"
            download_tibber_prices "$link6" "$file14" $((RANDOM % 21 + 10))
            sort -t, -k1.9n $file17 >>"$file12"
        fi

    fi

fi # Include second day

loop_hours=24
if [ "$include_second_day" = 1 ]; then
    if [ "$select_pricing_api" = 1 ] && [ -f "$file2" ] && [ "$(wc -l <"$file2")" -gt 10 ]; then
        loop_hours=48
    elif [ "$select_pricing_api" = 2 ] && [ -f "$file13" ] && [ "$(wc -l <"$file13")" -gt 10 ]; then
        loop_hours=48
    elif [ "$select_pricing_api" = 3 ] && [ -f "$file17" ] && [ "$(wc -l <"$file17")" -gt 10 ]; then
        loop_hours=48
    fi
	echo "Data available for $loop_hours hours."
fi

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

log_message "I: Please verify correct system time and timezone:\n   $(TZ=$TZ date)"
log_message "I: Current price is $current_price $Unit."
log_message "I: The average price will be $average_price $Unit."
log_message "I: Highest price will be $highest_price $Unit."
price_table=""
for i in $(seq 1 $loop_hours); do
    eval price=\$P$i
    price_table+="$i:$price "

    if [ $((i % 12)) -eq 0 ]; then
        price_table+="\n                  "
    fi
done
log_message "I: Sorted prices: $price_table"

if [ "$loop_hours" = 24 ]; then

    # Separate arrays for each column
    config_matrix24_charge=()
    config_matrix24_discharge=()
    config_matrix24_switchablesockets=()

    # Populate separate arrays
    for ((i=0; i<25; i++)); do
        row=(${config_matrix24_price[$i]})
        config_matrix24_charge+=("${row[0]}")
        config_matrix24_discharge+=("${row[1]}")
        config_matrix24_switchablesockets+=("${row[2]}")
    done

    # Use the separate arrays
    for ((i=1; i<=24; i++)); do
        hour=$i
        charge_value="${config_matrix24_charge[$i]}"
        discharge_value="${config_matrix24_discharge[$i]}"
        switchable_sockets_value="${config_matrix24_switchablesockets[$i]}"
        hour_var_name="${hour//[^a-zA-Z0-9]/_}"

        charge_var_name="charge_at_${hour_var_name}"
        discharge_var_name="discharge_at_${hour_var_name}"
        switchable_sockets_var_name="switchablesockets_at_${hour_var_name}"

        declare "$charge_var_name=$charge_value"
        declare "$switchable_sockets_var_name=$switchable_sockets_value"

    if [ $SOC_percent -ge $discharge_value ]; then
        declare "$discharge_var_name=1"
		if [ -n "$DEBUG" ]; then
        log_message "D: $discharge_var_name=1"
		fi
    else
        declare "$discharge_var_name=0"
		if [ -n "$DEBUG" ]; then
        log_message "D: $discharge_var_name=0"
		fi
    fi
		if [ -n "$DEBUG" ]; then
        log_message "D: $charge_var_name=$charge_value"
        log_message "D: $switchable_sockets_var_name=$switchable_sockets_value"
		fi
    done
	
charge_table=""
discharge_table=""
switchable_sockets_table=""
for ((i=1; i<=$loop_hours; i++)); do
    hour=$i
    charge_value="${config_matrix24_charge[i]}"
    discharge_value="${config_matrix24_discharge[i]}"
    switchable_sockets_value="${config_matrix24_switchablesockets[i]}"
    hour_var_name="${hour//[^a-zA-Z0-9]/_}"

    charge_var_name="${hour_var_name}"
    discharge_var_name="${hour_var_name}"
    switchable_sockets_var_name="${hour_var_name}"

    if [ "$charge_value" -eq 1 ]; then
        charge_table+="$charge_var_name "
    fi

    if [ "$SOC_percent" -ge "$discharge_value" ]; then
        discharge_table+="$discharge_var_name "
    fi

    if [ "$switchable_sockets_value" -eq 1 ]; then
        switchable_sockets_table+="$switchable_sockets_var_name "
    fi

done
	
fi
	
if [ "$loop_hours" = 48 ]; then
	    # Separate arrays for each column
    config_matrix48_charge=()
    config_matrix48_discharge=()
    config_matrix48_switchablesockets=()

    # Populate separate arrays
    for ((i=0; i<49; i++)); do
        row=(${config_matrix48_price[$i]})
        config_matrix48_charge+=("${row[0]}")
        config_matrix48_discharge+=("${row[1]}")
        config_matrix48_switchablesockets+=("${row[2]}")
    done

    # Use the separate arrays
    for ((i=1; i<=48; i++)); do
        hour=$i
        charge_value="${config_matrix48_charge[$i]}"
        discharge_value="${config_matrix48_discharge[$i]}"
        switchable_sockets_value="${config_matrix48_switchablesockets[$i]}"
        hour_var_name="${hour//[^a-zA-Z0-9]/_}"

        charge_var_name="charge_at_${hour_var_name}"
        discharge_var_name="discharge_at_${hour_var_name}"
        switchable_sockets_var_name="switchablesockets_at_${hour_var_name}"

        declare "$charge_var_name=$charge_value"
        declare "$switchable_sockets_var_name=$switchable_sockets_value"

    if [ $SOC_percent -ge $discharge_value ]; then
        declare "$discharge_var_name=1"
		if [ -n "$DEBUG" ]; then
        log_message "D: $discharge_var_name=1"
		fi
    else
        declare "$discharge_var_name=0"
		if [ -n "$DEBUG" ]; then
        log_message "D: $discharge_var_name=0"
		fi
    fi
	    if [ -n "$DEBUG" ]; then
        log_message "D: $charge_var_name=$charge_value"
        log_message "D: $switchable_sockets_var_name=$switchable_sockets_value"
		fi
    done

charge_table=""
discharge_table=""
switchable_sockets_table=""
for ((i=1; i<=$loop_hours; i++)); do
    hour=$i
    charge_value="${config_matrix48_charge[i]}"
    discharge_value="${config_matrix48_discharge[i]}"
    switchable_sockets_value="${config_matrix48_switchablesockets[i]}"
    hour_var_name="${hour//[^a-zA-Z0-9]/_}"

    charge_var_name="${hour_var_name}"
    discharge_var_name="${hour_var_name}"
    switchable_sockets_var_name="${hour_var_name}"

    if [ "$charge_value" -eq 1 ]; then
        charge_table+="$charge_var_name "
    fi

    if [ "$SOC_percent" -ge "$discharge_value" ]; then
        discharge_table+="$discharge_var_name "
    fi

    if [ "$switchable_sockets_value" -eq 1 ]; then
        switchable_sockets_table+="$switchable_sockets_var_name "
    fi

done

fi

log_message "I: Charge at prices: $charge_table"
log_message "I: Dynamic ESS discharge (depending SOC) at prices: $discharge_table"
log_message "I: Switchable sockets at prices: $switchable_sockets_table"

if ((use_solarweather_api_to_abort == 1)); then
    log_message "I: Sunrise today will be $sunrise_today and sunset will be $sunset_today. Suntime will be $suntime_today minutes."
    log_message "I: Solarenergy today will be $solarenergy_today megajoule per sqaremeter with $cloudcover_today percent clouds."
    log_message "I: Solarenergy tomorrow will be $solarenergy_tomorrow megajoule per squaremeter with $cloudcover_tomorrow percent clouds."
    target_soc=$(get_target_soc "$solarenergy_today")
    log_message "I: At $solarenergy_today megajoule there will be a dynamic SOC charge-target of $target_soc % calculated. The rest is reserved for solar."
    $charger_command_set_SOC_target $target_soc >/dev/null

    if [ ! -s $file3 ]; then
        log_message "E: File '$file3' is empty, please check your API Key if download is still not possible tomorrow."
    fi
    find "$file3" -size 0 -delete # FIXME - looks wrong and complicated - simple RM included in prior if clause?
else
    log_message "W: skip Solarweather. not activated"
fi
charging_condition_met=""
discharging_condition_met=""
switchablesockets_condition_met=""
execute_charging=0
execute_discharging=0
execute_switchablesockets_on=0

# Function to evaluate and execute charging, discharging, and socket conditions
evaluate_conditions() {
    local conditions=("${!1}")
    local descriptions=("${!2}")
    local execute_ref_name="$3"
    local condition_met_ref_name="$4"
    local condition_met=0

    for index in "${!conditions[@]}"; do
        if ((conditions[index])) && [[ $condition_met -eq 0 ]]; then
            eval $execute_ref_name=1
            eval $condition_met_ref_name=\"${descriptions[index]}\"
            condition_met=1
            [[ $DEBUG -ne 1 ]] && break
        fi
    done
}

# Add general conditions for charging
charging_conditions+=(
    $((use_start_stop_logic == 1 && start_price_integer > current_price_integer))
    $((charge_at_solar_breakeven_logic == 1 && feedin_price_integer > current_price_integer + energy_fee_integer))
)
charging_descriptions+=(
    "use_start_stop_logic ($use_start_stop_logic) == 1 && start_price_integer ($start_price_integer) > current_price_integer ($current_price_integer)"
    "charge_at_solar_breakeven_logic ($charge_at_solar_breakeven_logic) == 1 && feedin_price_integer ($feedin_price_integer) > current_price_integer ($current_price_integer) + energy_fee_integer ($energy_fee_integer)"
)

# Dynamically add conditions for P1 to P48 for charging, discharging, and switchable sockets
for ((i=1; i<=$loop_hours; i++)); do
    hour=$i
    charge_value="${config_matrix_charge[i]}"
    discharge_value="${config_matrix_discharge[i]}"
    switchable_sockets_value="${config_matrix_switchablesockets[i]}"
    hour_var_name="${hour//[^a-zA-Z0-9]/_}"

    charge_var_name="charge_at_${hour_var_name}"
    discharge_var_name="discharge_at_${hour_var_name}"
    switchable_sockets_var_name="switchablesockets_at_${hour_var_name}"
    price_var="P${i}_integer"

    if [[ -n "${!charge_var_name}" && "${!charge_var_name}" == 1 && "${!price_var}" == "$current_price_integer" ]]; then
        charging_conditions+=("1")
        charging_descriptions+=("\"$charge_var_name (${!charge_var_name}) == 1 && $price_var (${!price_var}) == current_price_integer ($current_price_integer)\"")
    else
        charging_conditions+=("0")
    fi

    if [[ -n "${!discharge_var_name}" && "${!discharge_var_name}" == 1 && "${!price_var}" == "$current_price_integer" ]]; then
        discharging_conditions+=("1")
        discharging_descriptions+=("\"$discharge_var_name (${!discharge_var_name}) == 1 && $price_var (${!price_var}) == current_price_integer ($current_price_integer)\"")
    else
        discharging_conditions+=("0")
    fi

    if [[ -n "${!switchable_sockets_var_name}" && "${!switchable_sockets_var_name}" == 1 && "${!price_var}" == "$current_price_integer" ]]; then
        switchablesockets_conditions+=("1")
        switchablesockets_conditions_descriptions+=("\"$switchable_sockets_var_name (${!switchable_sockets_var_name}) == 1 && $price_var (${!price_var}) == current_price_integer ($current_price_integer)\"")
    else
        switchablesockets_conditions+=("0")
    fi
done

if [ -n "$DEBUG" ]; then
log_message "D: Before evaluating charging conditions - execute_charging: $execute_charging"
log_message "D: Before evaluating discharging conditions - execute_discharging: $execute_discharging"
log_message "D: Before evaluating switchable sockets conditions - execute_switchablesockets_on: $execute_switchablesockets_on"
fi
evaluate_conditions charging_conditions[@] charging_descriptions[@] "execute_charging" "charging_condition_met"
evaluate_conditions discharging_conditions[@] discharging_descriptions[@] "execute_discharging" "discharging_condition_met"
evaluate_conditions switchablesockets_conditions[@] switchablesockets_conditions_descriptions[@] "execute_switchablesockets_on" "switchablesockets_condition_met"

if [ -n "$DEBUG" ]; then
log_message "D: After evaluating charging conditions - execute_charging: $execute_charging "
log_message "D: After evaluating discharging conditions - execute_discharging: $execute_discharging "
log_message "D: After evaluating switchable sockets conditions - execute_switchablesockets_on: $execute_switchablesockets_on "
fi

if ((use_solarweather_api_to_abort == 1)); then
    check_abort_condition $((abort_suntime <= suntime_today)) "There are enough sun minutes today. No need to charge or swtich."
    check_abort_condition $((abort_solar_yield_today_integer <= solarenergy_today_integer)) "There is enough solarenergy today. No need to charge or switch."
    check_abort_condition $((abort_solar_yield_tomorrow_integer <= solarenergy_tomorrow_integer)) "There is enough sun tomorrow. No need to charge or switch."
fi

check_abort_condition $((abort_price_integer <= current_price_integer)) "Current price ($(millicentToEuro "$current_price_integer")€) is too high. Abort. ($(millicentToEuro "$abort_price_integer")€)"

# If any charging condition is met, start charging
percent_of_current_price_integer=$(awk "BEGIN {printf \"%.0f\", $current_price_integer*$energy_loss_percent/100}")
total_cost_integer=$((current_price_integer + percent_of_current_price_integer + battery_lifecycle_costs_cent_per_kwh_integer))

# If any charging condition is met, start charging
if ((execute_charging == 1 && use_victron_charger == 1)); then
    economic=""
    # Evaluate if charging is economical
    percent_of_current_price_integer=$(awk "BEGIN {printf \"%.0f\", $current_price_integer*$energy_loss_percent/100}")
    total_cost_integer=$((current_price_integer + percent_of_current_price_integer + battery_lifecycle_costs_cent_per_kwh_integer))

    if [ "$economic_check" -eq 0 ]; then
        manage_charging "on" "Charging based on condition met of: $charging_condition_met."
    elif [ "$economic_check" -eq 1 ] && is_charging_economical $highest_price_integer $total_cost_integer; then
        manage_charging "on" "Charging based on highest price ($(millicentToEuro "$highest_price_integer") €) comparison makes sense. Total cost=$(millicentToEuro "$total_cost_integer") €"
    elif [ "$economic_check" -eq 2 ] && is_charging_economical $average_price_integer $total_cost_integer; then
        manage_charging "on" "Charging based on average price ($(millicentToEuro "$average_price_integer") €) comparison makes sense. Total cost=$(millicentToEuro "$total_cost_integer") €"
    else
        reason_msg="Considering charging losses and costs, charging is too expensive."
        economic="expensive"
        manage_charging "off" "$reason_msg (Total cost=$(millicentToEuro "$total_cost_integer") €)"
    fi
elif ((execute_charging != 1 && use_victron_charger == 1)); then
    manage_charging "off" "Charging was not executed."
else
    log_message "W: skip Victron Charger. not activated"
fi


if ((execute_discharging == 1 && use_victron_charger == 1)); then
         manage_discharging "on" "$reason_msg (total_cost=$(millicentToEuro "$total_cost_integer") €)"
fi
if ((execute_discharging == 0 && use_victron_charger == 1)); then
         manage_discharging "off" "$reason_msg (total_cost=$(millicentToEuro "$total_cost_integer") €)"
fi

# Execute Fritz DECT on command
if ((use_fritz_dect_sockets == 1)); then
    manage_fritz_sockets
else
    log_message "D: skip Fritz DECT. not activated"
fi

if ((use_shelly_wlan_sockets == 1)); then
    manage_shelly_sockets
else
    log_message "D: skip Shelly Api. not activated"
fi

echo >>"$LOG_FILE"

# Rotating log files
if [ -f "$LOG_FILE" ]; then
    if [ "$(du -k "$LOG_FILE" | awk '{print $1}')" -gt "$LOG_MAX_SIZE" ]; then
        log_message "I: Rotating log files"
        mv "$LOG_FILE" "${LOG_FILE}.$(date +%Y%m%d%H%M%S)"
        touch "$LOG_FILE"
        find . -maxdepth 1 -name "${LOG_FILE}*" -type f -exec ls -1t {} + |
            sed 's|^\./||' |
            tail -n +$((LOG_FILES_TO_KEEP + 1)) |
            xargs --no-run-if-empty rm
    fi
fi

if [ -n "$DEBUG" ]; then
    log_message "D: [ OK ]" >&2
fi
