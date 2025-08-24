#!/bin/bash

# Disable enp34s0 connection in NetworkManager
nmcli dev disconnect enp34s0

# Create the bridge
ip link add name br0 type bridge

# Assign the enp34s0 insterface to the bridge
ip link set enp34s0 master br0

# Bring the bridge interface up
ip link set br0 up

# Reconnect the bridge in NetworkManager
nmcli con add type bridge ifname br0
nmcli con add type bridge-slave ifname enp34s0 master br0

# Bring up the connections in NetworkManager
nmcli con up bridge-br0
nmcli con up bridge-slave-enp34s0
