## I3DS setup on the Coyote OBC

# Node IDs
The sensor nodes running on the Coyote are:

- 350: Left VZense ToF
- 351: Right VZense ToF
- 352: Wisdom GPR

The Wisdom node is set to contact UDP port 12345.

# VZense Serial numbers
The serial numbers of the VZense cameras that should be passed to the i3ds-vzense-tof -c flag are:

- VD7101PJB7280868P: Left VZense ToF (coyote)
- VD7101PJB7280814P: Right VZense ToF (coyote)
- <CHECK THIS>: Test VZense ToF

# Location of check_usb.sh in i3ds-wait-for-usb.service
Within i3ds-wait-for-usb.service, the location of the __check_usb.sh__ file needs to be changed to correspond to the computers path. It is by default set to the path on the sintef zintbook lab pc.

# Install actions

1. Installed i3ds-framework-cpp as described in the README
2. Built i3ds-vzense-tof as described in the README
3. Built i3ds-wisdom as described in the README
4. Set MTU of the web interface to 8192 in case large images has to be sent
    $ sudo ip link set enp1s0 mtu 8192
5. Copied the udev rules file
    $ sudo cp i3ds-vzense-tof/thirdparty/Vzense_SDK_Linux/Ubuntu18.04/0660-vzense-usb.rules /etc/udev/rules/50-vzense-usb.rules
6. Run `install.sh` script to make symlinks to address file and systemd services
7. Change path in i3ds-wait-for-usb.service to correspond to the path on the computer you install on.

# Using systemd units

All I3DS services can be started and stopped with

    $ sudo systemctl start i3ds.target
    $ sudo systemctl stop i3ds.target

The following services can also be started and stopped individually

    - i3ds-address-server.service
    - i3ds-left-tof.service
    - i3ds-right-tof.service

The tof services will automatically start the address-server.

The main target unit is set to automatically start on boot. This can be disabled with

    $ sudo systemctl disable i3ds.target

and reenabled with

    $ sudo systemctl enable i3ds.target

to view any running I3DS processes, run

    $ pgrep -a i3ds

If changes are needed to service arguments, change the files in corobx-coyote/systemd, and run

    $ sudo systemctl daemon-reload

Then restart the services.

To see current status of all I3DS services, run

    $ systemctl status "i3ds*"

# Setting IP Address of address server

Any machine that should connect to the nodes running on the coyote OBC should set the following environment variable

    $ export I3DS_ADDR_SRV_URL=10.250.247.50

This can be done either per shell or in .bashrc or similar

# Switching address file

There are two address files provided with the repo, one called local\_addresses.csv, used for testing and one called i3ds\_addresses.csv with the IP of the Coyote OBC. The address server will always start reading from the symlink /etc/i3ds\_addresses.csv, so to switch between the settings, we can redefine the symlink like this from the corobx-coyote folder:

    $ sudo ln -sf $(pwd)/i3ds_addresses.csv /etc/i3ds_addresses.csv

to use the real IP and 

    $ sudo ln -sf $(pwd)/local_addresses.csv /etc/i3ds_addresses.csv

to switch to the localhost addresses. Then restart all services. By default, i3ds\_addresses.csv is installed by the script.
