#! /bin/bash

# Check if user is root
if [[ $EUID != 0 ]]; then
    echo Please run this script as root
    exit
fi

ROOT_DIR=$(pwd)

# Put symlink to address file
ln -s $ROOT_DIR/i3ds_addresses.csv /etc/i3ds_addresses.csv || echo "Created symlink to i3ds_adresses.csv from /etc/i3ds_adresses.csv"

# Create symlinks to service files
for file in systemd/*; do
    ln -s $ROOT_DIR/$file /etc/systemd/system/ || echo "Created symlink to $FILE in /etc/systemd/system/"
done

systemctl daemon-reload
systemctl enable i3ds.target
