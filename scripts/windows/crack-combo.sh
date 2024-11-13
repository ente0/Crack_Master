#!/bin/bash
# Hybrid Wordlist + Mask
# Example:  hashcat -a 6 -m 0 example.hash example.dict ?a?a?a?a?a?a

run_hashcat() {
    local session="$1"
    local hashmode="$2"
    local wordlist_path="$3"
    local wordlist="$4"
    local mask_path="$5"
    local mask="$6"
    local min_length="$7"
    local max_length="$8"
    local workload="$9"
    local status_timer="${10}"
    local hashcat_path="${11}"

    temp_output=$(mktemp)

    if [ "$status_timer" = "y" ]; then
        "$hashcat_path/hashcat.exe" --session="$session" --status --status-timer=2 --increment --increment-min="$min_length" --increment-max="$max_length" -m "$hashmode" hash.txt -a 6 -w "$workload" --outfile-format=2 -o plaintext.txt "$wordlist_path/$wordlist" "$mask_path/$mask" | tee $temp_output
    else
        "$hashcat_path/hashcat.exe" --session="$session" --increment --increment-min="$min_length" --increment-max="$max_length" -m "$hashmode" hash.txt -a 6 -w "$workload" --outfile-format=2 -o plaintext.txt "$wordlist_path/$wordlist" "$mask_path/$mask" | tee $temp_output
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

echo -e "${RED}Enter Wordlists Path (press Enter to use default '$default_wordlists'):${NC}"
read wordlist_path_input
wordlist_path=${wordlist_path_input:-$default_wordlists}

echo -e "${MAGENTA}Available Wordlists in $wordlist_path:${NC}"
ls "$wordlist_path"

echo -e "${MAGENTA}Enter Wordlist (press Enter to use default '$default_wordlist'):${NC}"
read wordlist_input
wordlist=${wordlist_input:-$default_wordlist}

echo -e "${RED}Enter Masks Path (press Enter to use default '$default_masks'):${NC}"
read mask_path_input
mask_path=${mask_path_input:-$default_masks}

echo -e "${MAGENTA}Available Masks in $mask_path:${NC}"
ls "$mask_path"

echo -e "${MAGENTA}Enter Mask (press Enter to use default '$default_mask'):${NC}"
read mask_input
mask=${mask_input:-$default_mask}

echo -e "${MAGENTA}Enter Minimum Length (press Enter to use default '$default_min_length'):${NC}"
read min_length_input
min_length=${min_length_input:-$default_min_length}

echo -e "${MAGENTA}Enter Maximum Length (press Enter to use default '$default_max_length'):${NC}"
read max_length_input
max_length=${max_length_input:-$default_max_length}

echo -e "${RED}Enter Hashcat Path (press Enter to use default '$default_hashcat'):${NC}"
read hashcat_path_input
hashcat_path=${hashcat_path_input:-$default_hashcat}

echo -e "${MAGENTA}Use status timer? (press Enter to use default '$default_status_timer') [y/n]:${NC}"
read status_timer_input
status_timer=${status_timer_input:-default_status_timer}

echo -e "${MAGENTA}Enter hash attack mode (press Enter to use default '22000'):${NC}"
read hashmode_input
hashmode=${hashmode_input:-$default_hashmode}

echo -e "${MAGENTA}Enter workload (press Enter to use default '$default_workload') [1-4]:${NC}"
read workload_input
workload=${workload_input:-$default_workload}

echo -e "${GREEN}Restore >>${NC} $default_restorepath/$session"
echo -e "${GREEN}Command >>${NC} \"$hashcat_path/hashcat.exe\" --session=\"$session\" --increment --increment-min=\"$min_length\" --increment-max=\"$max_length\" -m \"$hashmode\" hash.txt -a 6 -w \"$workload\" --outfile-format=2 -o plaintext.txt \"$wordlist_path/$wordlist\" \"$mask\""

run_hashcat "$session" "$hashmode" "$wordlist_path" "$wordlist" "$mask_path" "$mask" "$min_length" "$max_length" "$workload" "$status_timer" "$hashcat_path"
