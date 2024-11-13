#!/bin/bash

source functions.sh

define_windows_parameters
define_my_parameters
define_colors

counter=1 

while true; do
    clear_screen
    show_title
    show_menu_based_on_os "$default_os" 
    read -r user_option  

    ((counter++))

    if [[ "$user_option" != [Xx] ]]; then
        if ((counter % 2 == 0)); then
            default_os="Windows"
        else
            default_os="Linux"
        fi
    else
        ((counter--)) 
    fi

    if [[ "$user_option" == [Qq] ]]; then
        break
    fi
    
    handle_option "$user_option"

    if [[ "$user_option" == "hashcat_option_identifier" ]]; then
        echo "Hashcat has finished. Press any key to continue..."
        read -n 1 -s 
    fi

    echo "User option: $user_option"
done
