#!/bin/bash



list_keys() {
    keys=()

    while IFS= read -r line; do
        key_id=$(echo "$line" | awk '{print $2}' | awk -F '/' '{print $2}')
        keys+=("$key_id")
    done < <(gpg --list-secret-keys --keyid-format LONG | grep '^sec')

    echo "All GPG keys:"
    index=1
    for key in "${keys[@]}"; do
        echo "$index. $key"
        ((index++))
    done
}

display_menu() {
    echo "Welcome to GPG key setup for Git:"
    echo "1. List all GPG keys"
    echo "2. Create a new GPG key"
    echo "3. Add an existing GPG key"
    echo "4. Delete a GPG key"
    echo "5. Exit"
}

create_new_key() {
    echo "Generating a new GPG key..."
    gpg --full-generate-key
    echo "New GPG key has been generated:"
}

add_existing_key() {
    list_keys

    echo "Please choose the number of the GPG key you want to add:"
    read key_number

    num_keys=$(gpg --list-secret-keys --keyid-format LONG | grep '^sec' | wc -l)
    
    if [[ "$key_number" -lt 1 || "$key_number" -gt "$num_keys" ]]; then
        echo "Invalid key number. Please choose a number between 1 and $num_keys."
        return
    fi

    GPG_KEY_ID=$(gpg --list-secret-keys --keyid-format LONG | grep '^sec' | awk '{print $2}' | awk -F '/' '{print $2}' | sed -n "${key_number}p")
    git config --global user.signingkey $GPG_KEY_ID
    git config --global commit.gpgsign true
    echo "Existing GPG key has been added:"
    git config --global user.signingkey
    echo "Don't forget to add this key to your github account"
}

delete_key() {

    list_keys

    echo "Please choose the number of the GPG key you want to delete:"
    read key_number

    num_keys=$(gpg --list-secret-keys --keyid-format LONG | grep '^sec' | wc -l)
    
    if [[ "$key_number" -lt 1 || "$key_number" -gt "$num_keys" ]]; then
        echo "Invalid key number. Please choose a number between 1 and $num_keys."
        return
    fi

    GPG_KEY_ID=$(gpg --list-secret-keys --keyid-format LONG | grep '^sec' | awk '{print $2}' | awk -F '/' '{print $2}' | sed -n "${key_number}p")
    
    if git config --global --get-all user.signingkey | grep -q $GPG_KEY_ID; then
        git config --global --unset-all user.signingkey $GPG_KEY_ID
        echo "Added GPG key $GPG_KEY_ID has been deleted from Git configuration."
    fi

    echo "Deleting GPG key $GPG_KEY_ID from the keyring..."
    gpg --delete-secret-keys $GPG_KEY_ID
    echo "GPG key $GPG_KEY_ID has been completely deleted."
}