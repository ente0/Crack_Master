#!/bin/bash

default_scripts="$HOME/Crack_Master"
default_windows_scripts="/c/Users/$USER/source/repos/ente0v1/Crack_Master/scripts/windows"

define_colors() {
    RED='\033[0;31m'
    GREEN='\033[0;32m'
    YELLOW='\033[1;33m'
    BLUE='\033[0;34m'
    MAGENTA='\033[0;35m'
    CYAN='\033[0;36m'
    NC='\033[0m' # No Color
}

define_default_parameters() {
    default_hashcat="."
    default_status_timer="y"
    default_workload="4"
    default_os="Linux"
    default_restorepath="$HOME/.local/share/hashcat/sessions"
    default_session=$(date +"%Y-%m-%d")
    default_wordlists="wordlists"
    default_masks="masks"
    default_rules="rules"
    default_wordlist="dnsmap.txt"
    default_mask="?d?d?d?d"
    default_rule="T0XlCv2.rule"
    default_min_length="4"
    default_max_length="16"
    default_hashmode="22000"
}

define_windows_parameters() {
    default_hashcat="."
    default_status_timer="y"
    default_workload="4"
    default_os="Linux"
    default_restorepath="$HOME/hashcat/sessions"
    default_session="fsociety"
    default_wordlists="/c/Users/$USER/wordlists"
    default_masks="masks"
    default_rules="rules"
    default_wordlist="rockyou.txt"
    default_mask="?d?d?d?d"
    default_rule="T0XlCv2.rule"
    default_min_length="4"
    default_max_length="16"
    default_hashmode="22000"
}

list_sessions () {
    echo -e "${GREEN}Available sessions:${NC}"
    restore_files=$(find "$default_restorepath" -name "*.restore" -exec basename {} \; | sed 's/\.restore$//')
    if [ -z "$restore_files" ]; then
        echo "No restore files found..."
    else
        echo "$restore_files"
    fi
}

clear_screen() {
    clear
}

random_color() {
    local colors=("$RED" "$MAGENTA" "$CYAN" "$BLUE" "$GREEN" "$YELLOW")
    local random_index=$((RANDOM % ${#colors[@]}))
    echo -e "${colors[$random_index]}"
}

show_title() {
    option_color="${color}" 
    echo -e "${color}"
    cat <<EOF



		       ▄▀▄▄▄▄   ▄▀▀▄▀▀▀▄  ▄▀▀█▄   ▄▀▄▄▄▄   ▄▀▀▄ █            
		      █ █    ▌ █   █   █ ▐ ▄▀ ▀▄ █ █    ▌ █  █ ▄▀            
		      ▐ █      ▐  █▀▀█▀    █▄▄▄█ ▐ █      ▐  █▀▄             
		        █       ▄▀    █   ▄▀   █   █        █   █            
		       ▄▀▄▄▄▄▀ █     █   █   ▄▀   ▄▀▄▄▄▄▀ ▄▀   █             
		      █     ▐  ▐     ▐   ▐   ▐   █     ▐  █    ▐             
		      ▐                          ▐        ▐                  
		 ▄▀▀▄ ▄▀▄  ▄▀▀█▄   ▄▀▀▀▀▄  ▄▀▀▀█▀▀▄  ▄▀▀█▄▄▄▄  ▄▀▀▄▀▀▀▄
		█  █ ▀  █ ▐ ▄▀ ▀▄ █ █   ▐ █    █  ▐ ▐  ▄▀   ▐ █   █   █
		▐  █    █   █▄▄▄█    ▀▄   ▐   █       █▄▄▄▄▄  ▐  █▀▀█▀ 
		  █    █   ▄▀   █ ▀▄   █     █        █    ▌   ▄▀    █ 
		▄▀   ▄▀   █   ▄▀   █▀▀▀    ▄▀        ▄▀▄▄▄▄   █     █  
		█    █    ▐   ▐    ▐      █          █    ▐   ▐     ▐  
		▐    ▐                    ▐          ▐                 



EOF
}

show_windows_menu() {
    echo -e "   ${option_color}Menu Options for Windows:${NC}"
    echo -e "   ${option_color}1.${NC} Crack with Wordlist                                                             ${CYAN}[EASY]"
    echo -e "   ${option_color}2.${NC} Crack with Association                                                        ${GREEN}[MEDIUM]"
    echo -e "   ${option_color}3.${NC} Crack with Brute-Force                                                          ${YELLOW}[HARD]"
    echo -e "   ${option_color}4.${NC} Crack with Combinator                                                       ${RED}[ADVANCED]"
    echo -e ""
    echo -e "                                                              ${option_color}Press Enter to switch to Linux.${NC}"
    echo -e "--------------------------------------------------------------------------------------------"
    echo -ne "  ${option_color}Enter option (1-4, or Q to quit): ${NC}"
}

show_linux_menu() {
    echo -e "   ${option_color}Menu Options for Linux:${NC}"
    echo -e "   ${option_color}1.${NC} Crack with Wordlist                                                             ${CYAN}[EASY]"
    echo -e "   ${option_color}2.${NC} Crack with Association                                                        ${GREEN}[MEDIUM]"
    echo -e "   ${option_color}3.${NC} Crack with Brute-Force                                                          ${YELLOW}[HARD]"
    echo -e "   ${option_color}4.${NC} Crack with Combinator                                                       ${RED}[ADVANCED]"
    echo -e ""
    echo -e "                                                            ${option_color}Press Enter to switch to Windows.${NC}"
    echo -e "--------------------------------------------------------------------------------------------"
    echo -ne "  ${option_color}Enter option (1-4, or Q to quit): ${NC}"
}

show_menu_based_on_os() {
    if [[ "$1" == "Linux" ]]; then
        show_linux_menu
    elif [[ "$1" == "Windows" ]]; then
        show_windows_menu
    else
        echo "Invalid OS choice"
        exit 1
    fi
}

animate_text() {
    local text="$1"
    local delay="$2"

    for (( i=0; i<${#text}; i++ )); do
        clear
        printf "%s" "${text:0:$i}"
        sleep "$delay"
    done
}

handle_option() {
    local option="$1"

    case "$option" in
        1)
            animate_text "..." 0.1
            if [[ "$default_os" == "Linux" ]]; then
                echo -ne "windows/crack-wordlist.sh ${YELLOW}is Executing${NC}\n\n\n"
                scripts/windows/crack-wordlist.sh
            elif [[ "$default_os" == "Windows" ]]; then
                echo -ne "./crack-wordlist.sh ${YELLOW}is Executing${NC}\n\n\n"
                scripts/linux/crack-wordlist.sh
            fi
            ;;
        2)
            animate_text "..." 0.1
            if [[ "$default_os" == "Linux" ]]; then
                echo -e "windows/crack-rule.sh ${YELLOW}is Executing${NC}\n\n\n"
                scripts/windows/crack-rule.sh
            elif [[ "$default_os" == "Windows" ]]; then
                echo -e "./crack-rule.sh ${YELLOW}is Executing${NC}\n\n\n"
                scripts/linux/crack-rule.sh
            fi
            ;;

        3)
            animate_text "..." 0.1
            if [[ "$default_os" == "Linux" ]]; then
                echo -ne "windows/crack-bruteforce.sh ${YELLOW}is Executing${NC}\n\n\n"
                scripts/windows/crack-bruteforce.sh
            elif [[ "$default_os" == "Windows" ]]; then
                echo -ne "./crack-bruteforce.sh ${YELLOW}is Executing${NC}\n\n\n"
                scripts/linux/crack-bruteforce.sh
            fi
            ;;

        4)
            animate_text "..." 0.1
            if [[ "$default_os" == "Linux" ]]; then
                echo -ne "windows/crack-combo.sh ${YELLOW}is Executing${NC}\n\n\n"
                scripts/windows/crack-combo.sh
            elif [[ "$default_os" == "Windows" ]]; then
                echo -ne "./crack-combo.sh ${YELLOW}is Executing${NC}\n\n\n"
                scripts/linux/crack-combo.sh
            fi
            ;;

        [Qq])
            echo -ne "Exiting: "
            animate_text "..." 0.1
            echo -e "${YELLOW}Done!${NC}"
            echo -e "${YELLOW}Exiting...${NC}"
            exit 0
            ;;
        [Xx])
            execute_windows_scripts
            ;;
        *)
            echo -e "${RED}Invalid option. Please try again.${NC}"
            ;;
    esac
}

execute_windows_scripts() {
    if [[ -d "scripts/windows" ]]; then
        for script in "scripts/windows"; do
            if [[ -f "$script" ]]; then
                echo "Executing Windows script: $script"
            fi
        done
    else
        echo "Windows scripts directory not found: '$windows_scripts_dir'"
    fi
}

save_settings() {
    local session="$1"
    local path_wordlists="$2"
    local default_wordlist="$3"
    local mask="$4"
    local rule="$5"
    local plaintext_file="plaintext.txt"
    local hash_file="hash.txt"
    
    status+="\nSession: $session"
    status+="\nWordlist: $path_wordlists/$default_wordlist"
    status+="\nMask: $mask"
    status+="\nRule: $rule"
    status+="\nHash: $(cat $hash_file)"
    status+="\nPlaintext: $(cat $plaintext_file)"
}

restore_session() {
    local restore_file_input="$1"
    if [ -n "$restore_file_input" ]; then
        local restore_file="$default_restorepath/$restore_file_input.restore"
        if [ ! -f "$restore_file" ]; then
            echo "Error: Restore file '$restore_file' not found."
            exit 1
        else
            local session=$(basename "$restore_file" .restore)
            echo -e "${GREEN}Restore >>${NC} $default_restorepath/$session"
            echo -e "${GREEN}Command >>${NC} hashcat --session="$session" -m "$default_hashmode" hash.txt -a "?" -w "$workload" --outfile-format=2 -o plaintext.txt "$default_wordlists/$default_wordlist""
            hashcat --session "$session" --restore
            exit 0
        fi
    fi
}

save_logs() {
    mkdir "$session"
    mv "$session" logs
    echo -e "$status" > status.txt
    mv status.txt "logs/$session"
    mv plaintext.txt "logs/$session"
}


