## I3DS setup on the Coyote OBC

# Node IDs
The sensor nodes running on the Coyote are:

350: Left VZense ToF
351: Right VZense ToF
352: Wisdom GPR

# VZense Serial numbers
The serial numbers of the VZense cameras that should be passed to the i3ds-vzense-tof -c flag are:

<CHECK THIS>: Left VZense ToF
<CHECK THIS>: Right VZense ToF
<CHECK THIS>: Test VZense ToF

# Install actions

1. Installed i3ds-framework-cpp as described in the README
2. Built i3ds-vzense-tof as described in the README
3. Built i3ds-wisdom as described in the README
4. Set MTU of the web interface to 8192 in case large images has to be sent
    $ sudo ip link set enp1s0 mtu 8192
5. Copied the udev rules file
    $ sudo cp i3ds-vzense-tof/thirdparty/Vzense_SDK_Linux/Ubuntu18.04/0660-vzense-usb.rules /etc/udev/rules/50-vzense-usb.rules
6. Run `install.sh` script to make symlinks to address file and systemd services

# Using systemd units

All i3ds services can be started and stopped with

    $ sudo systemctl start i3ds.target
    $ sudo systemctl stop i3ds.target

The following services can also be started and stopped individually
    - i3ds-address-server.service
    - i3ds-left-tof.service
    - i3ds-right-tof.service

The tof services will automatically start the address-server.

# Setting IP Address of address server

Any machine that should connect to the nodes running on the coyote OBC should set the following environment variable

    $ export I3DS_ADDR_SRV_URL=10.250.247.50

This can be done either per shell or in .bashrc or similar
