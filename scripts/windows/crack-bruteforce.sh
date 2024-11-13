#!/bin/bash
# Brute-force
# Example:  hashcat -a 3 -m 0 example.hash ?a?a?a?a?a?a

run_hashcat() {
    local session="$1"
    local hashmode="$2"
    local mask="$3"
    local workload="$4"
    local status_timer="$5"
    local hashcat_path="$6"
    local device="$7"
    
    temp_output=$(mktemp)

    if [ "$status_timer" = "y" ]; then
        "$hashcat_path/hashcat.exe" --session="$session" --status --status-timer=2 -m "$hashmode" hash.txt -a 3 -w "$workload" --outfile-format=2 -o plaintext.txt "$mask" -d "$device" | tee $temp_output
    else
        "$hashcat_path/hashcat.exe" --session="$session" -m "$hashmode" hash.txt -a 3 -w "$workload" --outfile-format=2 -o plaintext.txt "$mask" -d "$device" | tee $temp_output
    fi

    hashcat_output=$(cat "$temp_output")

    echo "$hashcat_output"

    if echo "$hashcat_output" | grep -q "Cracked"; then
        echo -e "${GREEN}Hashcat found the plaintext! Saving logs...${NC}"
        sleep 2
        save_logs
        save_settings "$session" "$wordlist_path" "$wordlist" ""
    else
        echo -e "${RED}Hashcat did not find the plaintext.${NC}"
        sleep 2
    fi
    
    rm "$temp_output"
}


source functions.sh
define_windows_parameters
define_colors

list_sessions
echo -e "\n${RED}Restore? (Enter restore file name or leave empty):${NC}"
read restore_file_input
restore_session "$restore_file_input"

echo -e "${MAGENTA}Enter session name (press Enter to use default '$default_session'):${NC}"
read session_input
session=${session_input:-$default_session}

echo -e "${MAGENTA}Enter Mask (press Enter to use default '$default_mask'):${NC}"
read mask_input
mask=${mask_input:-$default_mask}

echo -e "${MAGENTA}Use status timer? (y/n)${NC}"
read status_timer_input

echo -e "${MAGENTA}Enter Minimum Length (press Enter to use default '$default_min_length'):${NC}"
read min_length
min_length=${min_length:-$default_min_length}

echo -e "${MAGENTA}Enter Maximum Length (press Enter to use default '$default_max_length'):${NC}"
read max_length
max_length=${max_length:-$default_max_length}

echo -e "${RED}Enter Hashcat Path (press Enter to use default '$default_hashcat'):${NC}"
read hashcat_path_input
hashcat_path=${hashcat_path_input_input:-$default_hashcat}

echo -e "${MAGENTA}Enter hash attack mode (press Enter to use default '22000'):${NC}"
read hashmode_input
hashmode=${hashmode_input:-$default_hashmode}

echo -e "${MAGENTA}Enter workload (press Enter to use default '$default_workload') [1-4]:${NC}"
read workload_input
workload=${workload_input:-$default_workload}

echo -e "${MAGENTA}Use status timer? (press Enter to use default '$default_status_timer') [y/n]:${NC}"
read status_timer_input
status_timer=${status_timer_input:-default_status_timer}

echo -e "${MAGENTA}Enter device (press Enter to use default '$default_device'):${NC}"
read device_input
device=${device_input:-$default_device}

echo -e "${GREEN}Restore >>${NC} $default_restorepath/$session"
echo -e "${GREEN}Command >>${NC} hashcat.exe --session="$session" --increment --increment-min="$min_length" --increment-max="$max_length" -m "$hashmode" hash.txt -a 6 -w "$workload" --outfile-format=2 -o plaintext.txt "$wordlist_path/$wordlist" "$mask" -d "$device""

run_hashcat "$session" "$hashmode" "$mask" "$workload" "$status_timer" "$hashcat_path" "$device"

