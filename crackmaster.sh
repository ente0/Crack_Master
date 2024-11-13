#!/bin/bash

# Source the functions library
source functions.sh

# Define parameters
#define_default_parameters
define_windows_parameters
define_my_parameters
define_colors

# Variable to track the current OS selection (0 for Windows, 1 for Linux)
counter=1  # Counter variable

# Loop to keep displaying the menu and handling options until the user chooses to quit
while true; do
    clear_screen
    show_title
    show_menu_based_on_os "$default_os"  # Show menu based on current OS selection
    read -r user_option  # Read user input

    # Increment the counter
    ((counter++))

    # Select OS based on counter parity, unless "X" is selected
    if [[ "$user_option" != [Xx] ]]; then
        if ((counter % 2 == 0)); then
            default_os="Windows"
        else
            default_os="Linux"
        fi
    else
        ((counter--))  # Decrement counter to ensure correct menu display
    fi

    # Pause briefly to allow the user to read previous output before clearing the screen
    #sleep 1

    # If the user selected "Quit", exit the loop
    if [[ "$user_option" == [Qq] ]]; then
        break
    fi
    
    handle_option "$user_option"

    # If the option runs hashcat, freeze the screen
    if [[ "$user_option" == "hashcat_option_identifier" ]]; then
        echo "Hashcat has finished. Press any key to continue..."
        read -n 1 -s  # Wait for a key press
    fi

    echo "User option: $user_option"
done
