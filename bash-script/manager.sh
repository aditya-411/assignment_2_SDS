#!/bin/bash

display_menu() {
    echo "Welcome to GPG key setup for Git:"
    echo "1. Create a new GPG key"
    echo "2. Add an existing GPG key"
    echo "3. Remove an added GPG key"
    echo "4. Exit"
}

create_new_key() {
    echo "Generating a new GPG key..."
    gpg --full-generate-key
    echo "New GPG key has been generated:"
    gpg --list-secret-keys --keyid-format LONG | grep '^sec' | awk '{print $2}' | awk -F '/' '{print $2}'
}

add_existing_key() {
    echo "Existing GPG keys:"
    gpg --list-secret-keys --keyid-format LONG | grep '^sec' | awk '{print $2}' | awk -F '/' '{print $2}'

    echo "Please enter the GPG key ID you want to add:"
    read GPG_KEY_ID
    if [ -n "$GPG_KEY_ID" ]; then
        git config --global user.signingkey $GPG_KEY_ID
        git config --global commit.gpgsign true
        echo "Existing GPG key has been added:"
        git config --global user.signingkey
    else
        echo "Please enter a valid key"
    fi
}

delete_added_key() {
    echo "Added GPG keys:"
    git config --global --get-all user.signingkey

    echo "Please enter the GPG key ID you want to remove:"
    read GPG_KEY_ID
    if [ -n "$GPG_KEY_ID" ]; then
        git config --global --unset-all user.signingkey $GPG_KEY_ID
        echo "Added GPG key $GPG_KEY_ID has been removed."
    else
        echo "Please enter a valid key"
    fi
}

while true; do
    display_menu

    read -p "Enter your choice: " choice
    case $choice in
        1)
            create_new_key
            ;;
        2)
            add_existing_key
            ;;
        3)
            delete_added_key
            ;;
        4)
            echo "Exiting..."
            exit 0
            ;;
        *)
            echo "Invalid choice. Please enter a number from 1 to 4."
            ;;
    esac
done
