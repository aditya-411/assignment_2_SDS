#!/bin/bash


display_menu() {
    echo "Welcome to GPG key setup for Git:"
    echo "1. List all GPG keys"
    echo "2. Create a new GPG key"
    echo "3. Add an existing GPG key"
    echo "4. Delete a GPG key"
    echo "5. Exit"
}

list_keys() {
    echo "All GPG keys:"
    gpg --list-secret-keys --keyid-format LONG | grep '^sec' | awk '{print $2}' | awk -F '/' '{print $2}'
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
        echo "Don't forget to add this key to your github account"
    else
        echo "Please enter a valid key"
    fi
}

delete_key() {
    echo "All GPG keys:"
    gpg --list-secret-keys --keyid-format LONG | grep '^sec' | awk '{print $2}' | awk -F '/' '{print $2}'

    echo "Please enter the GPG key ID you want to delete:"
    read GPG_KEY_ID
    if [ -n "$GPG_KEY_ID" ]; then
        if git config --global --get-all user.signingkey | grep -q $GPG_KEY_ID; then
            git config --global --unset-all user.signingkey $GPG_KEY_ID
            echo "Added GPG key $GPG_KEY_ID has been deleted from Git configuration."
        fi

        echo "Deleting GPG key $GPG_KEY_ID from the keyring..."
        gpg --delete-secret-keys $GPG_KEY_ID
        echo "GPG key $GPG_KEY_ID has been completely deleted."

    else
        echo "Please enter a valid key"
    fi
}