#!/bin/bash

# Find all drives on the system
drives=($(find /mnt -maxdepth 1 -type d -printf '%P\n'))

for drive in "${drives[@]}"; do
    # Find all cacerts files in the drive
    cacerts=($(find "/mnt/$drive" -name "cacerts" -type f))

    for keystore in "${cacerts[@]}"; do
        if keytool -list -alias digicertglobalrootg2 -protected -keystore "$keystore" > /dev/null 2>&1; then
            echo "[$keystore] needs JRE update if the app is used with Snowflake"
        fi
    done
done
