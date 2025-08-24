#!/bin/bash

# Disable enp34s0 connection in NetworkManager
nmcli dev disconnect enp34s0

# Delete any existing IP from the NIC
sudo ip addr flush dev enp34s0

# Create the bridge
ip link add name br0 type bridge

# Assign the enp34s0 insterface to the bridge
ip link set enp34s0 master br0

# Bring the both interfaces up
ip link set enp34s0 up
ip link set br0 up

# Add static ip address to bridge interface
sudo ip addr add 192.168.0.20/24 dev br0
sudo ip route add default 192.168.1.1

# DN
echo "nameserver 8.8.8.8" | sudo tee /etc/resolv.conf
