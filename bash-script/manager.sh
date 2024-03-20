#!/bin/bash

source ./utils.sh

while true; do
    display_menu

    read -p "Enter your choice: " choice
    case $choice in
        1) 
            list_keys;;
        2)
            create_new_key
            ;;
        3)
            add_existing_key
            ;;
        4)
            delete_key
            ;;
        5)
            echo "Exiting..."
            exit 0
            ;;
        *)
            echo "Invalid choice. Please enter a number from 1 to 4."
            ;;
    esac
done
